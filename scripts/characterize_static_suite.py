import subprocess
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import os

# Generate fine DC sweep from 0.80V to 2.85V
vins = np.linspace(0.80, 2.85, 60)
codes = []
ideals = []
vholds = []

with open('netlist/tb_sar_adc_top.spice', 'r') as f:
    orig_spice = f.read()

print('Running 60-point fine DC sweep...')
for k, v in enumerate(vins):
    mod_spice = orig_spice.replace('V3 vin VSS 1.65', f'V3 vin VSS {v:.4f}')
    with open('netlist/tb_sweep.spice', 'w') as f:
        f.write(mod_spice)
    
    subprocess.run(['ngspice', '-b', 'netlist/tb_sweep.spice'], stdout=subprocess.DEVNULL)
    
    var_map = {}
    with open('tb_sar_adc_top.raw', 'r', errors='ignore') as f:
        reading_vars = False
        for line in f:
            if line.startswith('Variables:'): reading_vars = True; continue
            if line.startswith('Values:'): break
            if reading_vars:
                parts = line.strip().split()
                if len(parts) >= 2: var_map[int(parts[0])] = parts[1]
    
    num_vars = len(var_map)
    target_vars = {'time', 'v(x1.vhold)'}
    for b in range(8): target_vars.add(f'v(dout[{b}])')
    idx_to_name = {k2: v2 for k2, v2 in var_map.items() if v2 in target_vars}
    data = {v2: [] for v2 in idx_to_name.values()}
    
    with open('tb_sar_adc_top.raw', 'r', errors='ignore') as f:
        for line in f:
            if line.startswith('Values:'): break
        val_count = 0
        row = {}
        for line in f:
            parts = line.split()
            if not parts: continue
            if len(parts) == 2:
                val = float(parts[1]); var_idx = 0
            else:
                val = float(parts[0]); var_idx = val_count
            if var_idx in idx_to_name: row[idx_to_name[var_idx]] = val
            val_count += 1
            if val_count == num_vars:
                for k2 in data: data[k2].append(row.get(k2, 0.0))
                val_count = 0; row = {}
    
    t_raw = np.array(data['time'])
    idx_eval = np.argmin(np.abs(t_raw - 35e-9))
    bits = [int(data[f'v(dout[{b}])'][idx_eval] > 1.65) for b in range(8)]
    code = sum(bits[b] * (1 << b) for b in range(8))
    vh = data['v(x1.vhold)'][idx_eval]
    ideal = int(np.round((vh / 3.3) * 256.0))
    codes.append(code)
    ideals.append(ideal)
    vholds.append(vh)

codes = np.array(codes)
ideals = np.array(ideals)
vholds = np.array(vholds)

# Calculate DNL and INL
# Best-fit line
coeffs = np.polyfit(vholds, codes, 1)
fitted_codes = np.polyval(coeffs, vholds)
inl_best_fit = codes - fitted_codes

# Step-to-step DNL
d_vh = np.diff(vholds)
d_code = np.diff(codes)
lsb_nominal = coeffs[0] * np.mean(d_vh)
dnl = (d_code / (coeffs[0] * d_vh)) - 1.0

finite_dnl = dnl[np.isfinite(dnl)]
max_dnl = np.max(np.abs(finite_dnl)) if len(finite_dnl) > 0 else 0.0
max_inl = np.max(np.abs(inl_best_fit))

print('='*55)
print('📊 STATIC PERFORMANCE RESULTS (0.80V - 2.85V)')
print('='*55)
print(f'Max Absolute DNL: {max_dnl:.2f} LSB (PRD Target: < 1.0 LSB)')
print(f'Max Absolute INL: {max_inl:.2f} LSB (PRD Target: < 1.0 LSB)')
print(f'Average Error   : {np.mean(np.abs(codes - ideals)):.2f} LSB')
print('='*55)

# Plot DNL and INL
fig, (ax1, ax2, ax3) = plt.subplots(3, 1, figsize=(10, 10), dpi=150)

ax1.plot(vholds, codes, 'b.-', label='Simulated ADC Code')
ax1.plot(vholds, fitted_codes, 'r--', label=f'Best Fit Line (Gain={coeffs[0]:.2f} LSB/V)')
ax1.set_title('8-Bit Asynchronous SAR ADC Transfer Curve (GF180MCU 3.3V)', fontweight='bold')
ax1.set_xlabel('Vhold (V)')
ax1.set_ylabel('ADC Code')
ax1.grid(True, linestyle='--', alpha=0.6)
ax1.legend()

ax2.step(vholds[:-1], dnl, 'g-', where='mid', label=f'DNL (Max: {max_dnl:.2f} LSB)')
ax2.axhline(1.0, color='r', linestyle='--', alpha=0.5)
ax2.axhline(-1.0, color='r', linestyle='--', alpha=0.5)
ax2.set_title('Differential Non-Linearity (DNL)', fontweight='bold')
ax2.set_xlabel('Vhold (V)')
ax2.set_ylabel('DNL (LSB)')
ax2.set_ylim([-1.5, 1.5])
ax2.grid(True, linestyle='--', alpha=0.6)
ax2.legend()

ax3.plot(vholds, inl_best_fit, 'm.-', label=f'INL (Best-Fit Max: {max_inl:.2f} LSB)')
ax3.axhline(1.0, color='r', linestyle='--', alpha=0.5)
ax3.axhline(-1.0, color='r', linestyle='--', alpha=0.5)
ax3.set_title('Integral Non-Linearity (INL - Best Fit)', fontweight='bold')
ax3.set_xlabel('Vhold (V)')
ax3.set_ylabel('INL (LSB)')
ax3.set_ylim([-1.5, 1.5])
ax3.grid(True, linestyle='--', alpha=0.6)
ax3.legend()

plt.tight_layout()
os.makedirs('docs/images', exist_ok=True)
plt.savefig('docs/images/static_inl_dnl_characterization.png')
print('Static plot saved to docs/images/static_inl_dnl_characterization.png')
