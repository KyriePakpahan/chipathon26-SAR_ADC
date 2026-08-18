import os
import sys
sys.path.insert(0, '.')
import subprocess
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

print("================================================================================")
print("📊 CHIPATHON 2026: DYNAMIC FREQUENCY CHARACTERIZATION (LOW-FREQ & NEAR-NYQUIST)")
print("================================================================================")

# Dynamic test configuration
# Fs = 10 MS/s (Ts = 100 ns, 5ns sample pulse, 95ns hold/conversion)
# N = 64 coherent cycles (Duration = 6.4 us)
# Case A: Low-Frequency -> M = 7  -> Fin = 7/64 * 10 MHz = 1.09375 MHz
# Case B: Near-Nyquist  -> M = 29 -> Fin = 29/64 * 10 MHz = 4.53125 MHz (Nyquist = 5.0 MHz)

cases = [
    {"name": "Low-Frequency (1.09 MHz)", "M": 7, "fin": 1.09375e6, "fin_str": "1.09375MEG"},
    {"name": "Near-Nyquist (4.53 MHz)", "M": 29, "fin": 4.53125e6, "fin_str": "4.53125MEG"}
]

with open('xschem/sar_adc/tb_sar_adc_dynamic.sch', 'r') as f:
    sch_base = f.read()

results = []

for idx, c in enumerate(cases):
    print(f"\n>> [{idx+1}/2] Simulating Dynamic Spectrum: {c['name']}...")
    sch_test = sch_base.replace('SIN(1.65 0.70 1.09375MEG)', f"SIN(1.65 0.70 {c['fin_str']})")
    with open('xschem/sar_adc/tb_sar_adc_dynamic.sch', 'w') as f:
        f.write(sch_test)
        
    # Netlist and run
    subprocess.run(['xschem', '-x', '-q', '--rcfile', '/foss/designs/chipathon26-SAR_ADC/xschem/xschemrc',
                    '--command', 'set netlist_dir /foss/designs/chipathon26-SAR_ADC/netlist; xschem netlist; exit',
                    'xschem/sar_adc/tb_sar_adc_dynamic.sch'], stdout=subprocess.DEVNULL)
    
    subprocess.run(['ngspice', '-b', 'netlist/tb_sar_adc_dynamic.spice'], stdout=subprocess.DEVNULL)
    
    # Parse raw
    var_map = {}
    with open('tb_sar_adc_dynamic.raw', 'r', errors='ignore') as f:
        reading_vars = False
        for line in f:
            if line.startswith('Variables:'): reading_vars = True; continue
            if line.startswith('Values:'): break
            if reading_vars:
                parts = line.strip().split()
                if len(parts) >= 2: var_map[int(parts[0])] = parts[1]
                
    num_vars = len(var_map)
    target_vars = {'time', 'v(vin)', 'v(x1.vhold)', 'v(x1.vdac)'}
    for b in range(8): target_vars.add(f'v(dout[{b}])')
    idx_to_name = {k: v for k, v in var_map.items() if v in target_vars}
    data = {v: [] for v in idx_to_name.values()}
    
    with open('tb_sar_adc_dynamic.raw', 'r', errors='ignore') as f:
        for line in f:
            if line.startswith('Values:'): break
        val_count = 0
        row = {}
        for line in f:
            parts = line.strip().split()
            if not parts: continue
            if len(parts) == 2:
                val = float(parts[1]); var_idx = 0
            else:
                val = float(parts[0]); var_idx = val_count
            if var_idx in idx_to_name: row[idx_to_name[var_idx]] = val
            val_count += 1
            if val_count == num_vars:
                for k in data: data[k].append(row.get(k, 0.0))
                val_count = 0; row = {}
                
    t_raw = np.array(data['time'])
    N = 64
    codes = []
    for k in range(N):
        t_conv = (k + 0.90) * 100e-9
        idx_c = np.argmin(np.abs(t_raw - t_conv))
        bits = [int(data[f'v(dout[{b}])'][idx_c] > 1.65) for b in range(8)]
        codes.append(sum(bits[b] * (1 << b) for b in range(8)))
        
    codes = np.array(codes)
    v_adc = codes * (3.3 / 256.0)
    
    # 4-Parameter Sine Fit (IEEE 1241)
    t_vec = np.arange(N) * 100e-9
    w = 2 * np.pi * c['fin']
    D = np.column_stack([np.sin(w * t_vec), np.cos(w * t_vec), np.ones(N)])
    params, _, _, _ = np.linalg.lstsq(D, v_adc, rcond=None)
    v_fit = D @ params
    residuals = v_adc - v_fit
    P_sig = (params[0]**2 + params[1]**2) / 2.0
    P_noise = np.mean(residuals**2)
    sndr = 10 * np.log10(P_sig / P_noise)
    enob = (sndr - 1.76) / 6.02
    
    # FFT Spectrum & Harmonics Analysis
    fft_vals = np.fft.fft(codes - np.mean(codes))
    mag = np.abs(fft_vals[:N//2])
    fund_bin = c['M']
    P_sig_fft = mag[fund_bin]**2
    
    # Find Harmonics HD2..HD5 with alias folding
    harm_bins = []
    for h in range(2, 6):
        hb = (h * c['M']) % N
        if hb >= N//2: hb = N - hb
        harm_bins.append(hb)
        
    P_harm = sum(mag[hb]**2 for hb in harm_bins if hb != fund_bin and hb != 0)
    thd = 10 * np.log10(P_harm / P_sig_fft) if P_harm > 0 else -100.0
    
    noise_mask = np.ones(N//2, dtype=bool)
    noise_mask[0] = False
    noise_mask[fund_bin] = False
    for hb in harm_bins: noise_mask[hb] = False
    
    P_noise_pure = np.sum(mag[noise_mask]**2)
    snr = 10 * np.log10(P_sig_fft / (P_noise_pure + 1e-15))
    
    # SFDR (Peak non-fundamental spur)
    mask_nd = np.ones(N//2, dtype=bool)
    mask_nd[0] = False
    mask_nd[fund_bin] = False
    sorted_spurs = np.sort(mag[mask_nd])
    sfdr = 20 * np.log10(mag[fund_bin] / (sorted_spurs[-1] + 1e-15))
    
    mag_db = 20 * np.log10(mag / (N/2) + 1e-12)
    
    res_dict = {
        "name": c["name"],
        "fin": c["fin"],
        "fund_bin": fund_bin,
        "sndr": sndr,
        "enob": enob,
        "snr": snr,
        "thd": thd,
        "sfdr": sfdr,
        "mag_db": mag_db,
        "codes": codes,
        "v_adc": v_adc,
        "v_fit": v_fit,
        "harm_bins": harm_bins
    }
    results.append(res_dict)
    
    print(f"   SNR                   : {snr:.2f} dB")
    print(f"   SNDR / SINAD          : {sndr:.2f} dB")
    print(f"   ENOB                  : {enob:.2f} bits")
    print(f"   THD                   : {thd:.2f} dB")
    print(f"   SFDR                  : {sfdr:.2f} dB")

# 3. Generate Annotated Multi-Panel FFT Spectrum Figure
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(16, 7))
freq_axis = np.arange(32) * (10.0 / 64) # MHz (0 to 5.0 MHz)

for ax, r, col in zip([ax1, ax2], results, ['b', 'darkgreen']):
    ax.plot(freq_axis, r['mag_db'], f'{col}o-', linewidth=1.5, markersize=5, label='FFT Spectrum (64-pt)')
    ax.plot(freq_axis[r['fund_bin']], r['mag_db'][r['fund_bin']], 'ro', markersize=9, label=f"Fundamental ({r['fin']/1e6:.2f} MHz)")
    
    # Annotate Harmonics
    for h_idx, hb in enumerate(r['harm_bins']):
        if 0 < hb < 32:
            ax.plot(freq_axis[hb], r['mag_db'][hb], 'ms', markersize=6)
            ax.annotate(f"HD{h_idx+2}", (freq_axis[hb], r['mag_db'][hb]), textcoords="offset points", xytext=(0,8), ha='center', fontsize=8)
            
    # Text Annotation Box
    info_text = (
        f"Fin: {r['fin']/1e6:.3f} MHz (Fs = 10 MS/s)\n"
        f"SNR:  {r['snr']:.2f} dB\n"
        f"SNDR: {r['sndr']:.2f} dB\n"
        f"ENOB: {r['enob']:.2f} bits\n"
        f"THD:  {r['thd']:.2f} dB\n"
        f"SFDR: {r['sfdr']:.2f} dB"
    )
    ax.text(0.04, 0.94, info_text, transform=ax.transAxes, fontsize=10, verticalalignment='top',
            bbox=dict(boxstyle='round,pad=0.5', facecolor='white', alpha=0.9, edgecolor='gray'))
    
    ax.set_title(f"Dynamic Spectrum: {r['name']}", fontsize=13, fontweight='bold')
    ax.set_xlabel('Frequency (MHz)', fontsize=11)
    ax.set_ylabel('Magnitude (dBFS)', fontsize=11)
    ax.set_ylim(-60, 5)
    ax.grid(True, linestyle=':', alpha=0.6)
    ax.legend(loc='upper right', fontsize=9)

plt.tight_layout()
os.makedirs('docs/images', exist_ok=True)
spec_path = 'docs/images/dynamic_fft_spectra_annotated.png'
plt.savefig(spec_path, dpi=300)
print(f"\n>> Dynamic FFT Spectrum figure successfully generated and saved to: {spec_path}\n")
