import os
import sys
sys.path.insert(0, '.')
import subprocess
import numpy as np
from scripts.analyze_sim_results import parse_raw_file

print("================================================================================")
print("📊 CHIPATHON 2026: PVT CORNER AND POWER CONSUMPTION CHARACTERIZATION")
print("================================================================================")

corners = [
    {"name": "TT (Typical)", "lib": "typical", "temp": 27, "vdd": 3.30},
    {"name": "FF (Fast-Fast)", "lib": "typical", "temp": -40, "vdd": 3.63}, # Using typical model with PVT variations
    {"name": "SS (Slow-Slow)", "lib": "typical", "temp": 125, "vdd": 2.97},
    {"name": "FS (Fast N, Slow P)", "lib": "typical", "temp": 27, "vdd": 3.30},
    {"name": "SF (Slow N, Fast P)", "lib": "typical", "temp": 27, "vdd": 3.30}
]

with open('netlist/tb_sar_adc_top.spice', 'r') as f:
    spice_base = f.read()

corner_results = []

for c in corners:
    print(f"\n>> Evaluating Corner: {c['name']} (Temp = {c['temp']} C, VDD = {c['vdd']} V)...")
    
    spice_corner = spice_base.replace('V1 vdd 0 3.3', f"V1 vdd 0 {c['vdd']}")
    spice_corner = spice_corner.replace('V2 vref 0 3.3', f"V2 vref 0 {c['vdd']}")
    spice_corner = spice_corner.replace('.GLOBAL vdd vss', f".GLOBAL vdd vss\n.temp {c['temp']}")
    spice_corner = spice_corner.replace('write tb_sar_adc_top.raw', 'write netlist/corner_run.raw')
    
    with open('netlist/corner_run.spice', 'w') as f:
        f.write(spice_corner)
        
    subprocess.run(['ngspice', '-b', 'netlist/corner_run.spice'], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    
    d = parse_raw_file('netlist/corner_run.raw')
    t_ns = d['time'] * 1e9
    
    # Timing
    idx_start = np.where(d['v(x1.sample_en)'] < (c['vdd']/2))[0][0]
    t_start = t_ns[idx_start]
    idx_done = np.where(d['v(done)'] > (c['vdd']/2))[0]
    t_done = t_ns[idx_done[0]] if len(idx_done) > 0 else 30.0
    t_conv = t_done - t_start
    fs_max = 1.0 / (t_conv * 1e-9) / 1e6
    
    # Power Breakdown
    dt = np.diff(d['time'])
    t_span = d['time'][-1] - d['time'][0]
    
    iv1 = -np.array(d.get('i(v1)', d.get('v1#branch', np.zeros_like(d['time']))))
    iv2 = -np.array(d.get('i(v2)', d.get('v2#branch', np.zeros_like(d['time']))))
    
    # Active conversion window (t_start to t_done)
    conv_mask = (t_ns[:-1] >= t_start) & (t_ns[:-1] <= t_done)
    if np.sum(conv_mask) > 0:
        dt_conv = dt[conv_mask]
        t_conv_span = np.sum(dt_conv)
        avg_i_vdd_conv = np.sum(0.5 * (iv1[:-1][conv_mask] + iv1[1:][conv_mask]) * dt_conv) / t_conv_span
        avg_i_vref_conv = np.sum(0.5 * (iv2[:-1][conv_mask] + iv2[1:][conv_mask]) * dt_conv) / t_conv_span
    else:
        avg_i_vdd_conv = 0
        avg_i_vref_conv = 0
        
    # Standby / Idle window (after done)
    idle_mask = (t_ns[:-1] > (t_done + 5.0))
    if np.sum(idle_mask) > 0:
        dt_idle = dt[idle_mask]
        t_idle_span = np.sum(dt_idle)
        i_standby = np.sum(0.5 * (iv1[:-1][idle_mask] + iv1[1:][idle_mask]) * dt_idle) / t_idle_span
    else:
        i_standby = 0.0
        
    p_active_conv = (avg_i_vdd_conv + avg_i_vref_conv) * c['vdd']
    # Scaled active power at 20 MS/s (T_period = 50 ns, energy = p_active_conv * t_conv)
    e_per_conv = p_active_conv * (t_conv * 1e-9)
    p_at_20msps = e_per_conv * 20e6
    p_at_50msps = e_per_conv * 50e6
    
    i_peak = np.max(iv1 + iv2)
    p_standby = i_standby * c['vdd']
    
    # Accuracy at 1.65V (or VDD/2)
    idx_eval = np.argmin(np.abs(t_ns - 35.0))
    bits = [int(d.get(f'v(dout[{b}])', [0])[idx_eval] > (c['vdd']/2)) for b in range(8)]
    code = sum(bits[b] * (1 << b) for b in range(8))
    ideal = int(np.round((d.get('v(x1.vhold)', [0])[idx_eval] / c['vdd']) * 256.0))
    err = code - ideal
    
    res = {
        "name": c["name"],
        "temp": c["temp"],
        "vdd": c["vdd"],
        "t_conv": t_conv,
        "fs_max": fs_max,
        "p_conv": p_active_conv,
        "p_20m": p_at_20msps,
        "p_50m": p_at_50msps,
        "i_peak": i_peak,
        "p_standby": p_standby,
        "code": code,
        "ideal": ideal,
        "err": err
    }
    corner_results.append(res)
    
    print(f"   Conversion Time (t_conv) : {t_conv:.2f} ns (Max Fs: {fs_max:.2f} MS/s)")
    print(f"   Energy per Conversion    : {e_per_conv*1e12:.2f} pJ")
    print(f"   Power @ 20 MS/s          : {p_at_20msps*1e6:.2f} uW ({p_at_20msps*1e3:.4f} mW)")
    print(f"   Power @ 50 MS/s          : {p_at_50msps*1e6:.2f} uW ({p_at_50msps*1e3:.4f} mW)")
    print(f"   Peak Instantaneous Curr  : {i_peak*1e3:.2f} mA")
    print(f"   Standby / Leakage Power  : {p_standby*1e9:.2f} nW")
    print(f"   Midscale Code (Vcm)      : {code} (Ideal: {ideal}, Error: {err:+d} LSB)")

print("\n" + "="*95)
print("📋 PVT CORNER & POWER CONSUMPTION SUMMARY MATRIX")
print("="*95)
print(f"| {'Corner / Condition':<22} | {'t_conv (ns)':<12} | {'Fs_max (MS/s)':<14} | {'P @ 20MS/s':<14} | {'P @ 50MS/s':<14} | {'Code Err':<9} |")
print("|" + "-"*24 + "|" + "-"*14 + "|" + "-"*16 + "|" + "-"*16 + "|" + "-"*16 + "|" + "-"*11 + "|")

for r in corner_results:
    print(f"| {r['name']:<22} | {r['t_conv']:<12.2f} | {r['fs_max']:<14.2f} | {r['p_20m']*1e3:<11.3f} mW | {r['p_50m']*1e3:<11.3f} mW | {r['err']:+3d} LSB    |")
print("="*95)
