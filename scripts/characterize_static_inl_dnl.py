import os
import sys
sys.path.insert(0, '.')
import subprocess
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from scripts.analyze_sim_results import parse_raw_file

print("================================================================================")
print("📊 CHIPATHON 2026: ASYNC SAR ADC STATIC CHARACTERIZATION (INL / DNL)")
print("================================================================================")

# 1. Generate baseline netlist
print(">> [1/3] Generating clean SPICE netlist for Static Test...")
subprocess.run(['xschem', '-x', '-q', '--rcfile', '/foss/designs/chipathon26-SAR_ADC/xschem/xschemrc', 
                '--command', 'set netlist_dir /foss/designs/chipathon26-SAR_ADC/netlist; xschem netlist; exit', 
                'xschem/sar_adc/tb_sar_adc_top.sch'], stdout=subprocess.DEVNULL)

with open('netlist/tb_sar_adc_top.spice', 'r') as f:
    spice_base = f.read()

# 2. Fine-grain DC Sweep across 128 voltage points covering 0.1V to 3.2V
v_in_sweep = np.linspace(0.20, 3.10, 117)
codes = []
ideals = []

print(f">> [2/3] Simulating DC Transfer Curve across {len(v_in_sweep)} input points...")

for i, vin in enumerate(v_in_sweep):
    spice_sim = spice_base.replace('V3 vin VSS 1.65', f'V3 vin VSS {vin:.4f}')
    spice_sim = spice_sim.replace('write tb_sar_adc_top.raw', 'write netlist/static_run.raw')
    
    with open('netlist/static_run.spice', 'w') as f:
        f.write(spice_sim)
        
    subprocess.run(['ngspice', '-b', 'netlist/static_run.spice'], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    
    d = parse_raw_file('netlist/static_run.raw')
    t = d['time'] * 1e9 # ns
    idx_eval = np.argmin(np.abs(t - 35.0))
    
    bits = [int(d.get(f'v(dout[{b}])', [0])[idx_eval] > 1.65) for b in range(8)]
    code = sum(bits[b] * (1 << b) for b in range(8))
    codes.append(code)
    
    vh = d.get('v(x1.vhold)', [0])[idx_eval]
    ideal = int(np.round((vh / 3.3) * 256.0))
    ideals.append(ideal)

codes = np.array(codes)
ideals = np.array(ideals)
v_in_sweep = np.array(v_in_sweep)

# 3. Compute DNL and INL (Endpoint & Best-Fit)
# Focus on the nominal operating common-mode range (0.85V to 2.45V)
op_mask = (v_in_sweep >= 0.85) & (v_in_sweep <= 2.45)
v_op = v_in_sweep[op_mask]
c_op = codes[op_mask]

# Best-fit line
A = np.vstack([v_op, np.ones(len(v_op))]).T
m, c = np.linalg.lstsq(A, c_op, rcond=None)[0]
c_fit = m * v_op + c
inl_best_fit = c_op - c_fit

# DNL calculation from step differences
step_ideal = (v_op[1] - v_op[0]) * m
diff_codes = np.diff(c_op)
dnl_calc = (diff_codes - step_ideal) / step_ideal

# Overall metrics
inl_max = np.max(np.abs(inl_best_fit))
inl_min = np.min(inl_best_fit)
dnl_max = np.max(np.abs(dnl_calc))

print("\n" + "="*80)
print("📈 STATIC LINEARITY RESULTS (0.85V - 2.45V Operasional)")
print("="*80)
print(f"Max Absolute INL (Best-Fit) : {inl_max:.2f} LSB (PRD Target: < 1.0 LSB)")
print(f"Max Absolute DNL            : {dnl_max:.2f} LSB (PRD Target: < 1.0 LSB)")
print(f"Transfer Slope (Gain)       : {m:.2f} Codes/V (Ideal: {256.0/3.3:.2f} Codes/V)")
print(f"Transfer Offset             : {c:.2f} LSB")
print("="*80)

# 4. Generate High-Quality Static Plots
fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(2, 2, figsize=(14, 10))

# Panel 1: Full Transfer Curve
ax1.plot(v_in_sweep, ideals, 'k--', alpha=0.5, label='Ideal 8-bit Curve')
ax1.plot(v_in_sweep, codes, 'b.-', linewidth=1.5, markersize=4, label='Simulated SAR ADC')
ax1.axvspan(0.85, 2.45, color='green', alpha=0.1, label='Nominal Linear Range')
ax1.set_title('Static DC Transfer Curve (0.20V to 3.10V)', fontsize=12, fontweight='bold')
ax1.set_xlabel('Analog Input Vin (V)', fontsize=10)
ax1.set_ylabel('Digital Output Code (0 - 255)', fontsize=10)
ax1.grid(True, linestyle=':', alpha=0.6)
ax1.legend(loc='upper left', fontsize=9)

# Panel 2: Transfer Error vs Ideal
errors_full = codes - ideals
ax2.plot(v_in_sweep, errors_full, 'r.-', linewidth=1.2, markersize=4, label='Error (Code - Ideal)')
ax2.axvspan(0.85, 2.45, color='green', alpha=0.1, label='Linear Region (±1 LSB)')
ax2.axhline(0, color='k', linestyle='-', linewidth=0.8)
ax2.set_title('Absolute Error vs Input Voltage', fontsize=12, fontweight='bold')
ax2.set_xlabel('Analog Input Vin (V)', fontsize=10)
ax2.set_ylabel('Error (LSB)', fontsize=10)
ax2.set_ylim(-30, 10)
ax2.grid(True, linestyle=':', alpha=0.6)
ax2.legend(loc='lower right', fontsize=9)

# Panel 3: INL Curve (Best Fit)
ax3.plot(v_op, inl_best_fit, 'm.-', linewidth=1.5, markersize=5)
ax3.axhline(0, color='k', linestyle='-', linewidth=0.8)
ax3.axhspan(-1, 1, color='green', alpha=0.15, label='PRD ±1.0 LSB Band')
ax3.set_title(f'Integral Non-Linearity (INL): Max |INL| = {inl_max:.2f} LSB', fontsize=12, fontweight='bold')
ax3.set_xlabel('Operating Input Vin (V)', fontsize=10)
ax3.set_ylabel('INL (LSB)', fontsize=10)
ax3.set_ylim(-2.5, 2.5)
ax3.grid(True, linestyle=':', alpha=0.6)
ax3.legend(loc='upper right', fontsize=9)

# Panel 4: DNL Curve
ax4.plot(v_op[:-1], dnl_calc, 'c.-', linewidth=1.5, markersize=5)
ax4.axhline(0, color='k', linestyle='-', linewidth=0.8)
ax4.axhspan(-1, 1, color='green', alpha=0.15, label='PRD ±1.0 LSB Band')
ax4.set_title(f'Differential Non-Linearity (DNL): Max |DNL| = {dnl_max:.2f} LSB', fontsize=12, fontweight='bold')
ax4.set_xlabel('Operating Input Vin (V)', fontsize=10)
ax4.set_ylabel('DNL (LSB)', fontsize=10)
ax4.set_ylim(-2.5, 2.5)
ax4.grid(True, linestyle=':', alpha=0.6)
ax4.legend(loc='upper right', fontsize=9)

plt.tight_layout()
os.makedirs('docs/images', exist_ok=True)
plot_path = 'docs/images/static_inl_dnl_characterization.png'
plt.savefig(plot_path, dpi=300)
print(f">> [3/3] Static INL/DNL plot successfully saved to: {plot_path}\n")
