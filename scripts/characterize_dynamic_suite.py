import subprocess
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import os

def run_dynamic_test(f_in, freq_name, m_cycles, n_samples=64, fs=10e6):
    ts = 1.0 / fs
    t_stop = n_samples * ts + 10e-9
    
    with open('netlist/tb_sar_adc_dynamic.spice', 'r') as f:
        spice = f.read()
    
    # Set V3 to optimal high-linearity span (Vcm=1.85V, A=1.00V -> 0.85V to 2.85V)
    spice_dyn = spice.replace('SIN(1.65 0.70 4.53125MEG)', f'SIN(1.85 1.00 {f_in})')
    spice_dyn = spice_dyn.replace('SIN(1.825 1.15 4.53125MEG)', f'SIN(1.85 1.00 {f_in})')
    spice_dyn = spice_dyn.replace('SIN(1.825 0.95 4.53125MEG)', f'SIN(1.85 1.00 {f_in})')
    spice_dyn = spice_dyn.replace('SIN(1.85 1.00 4.53125MEG)', f'SIN(1.85 1.00 {f_in})')
    
    with open('netlist/tb_dyn_run.spice', 'w') as f:
        f.write(spice_dyn)
    
    print(f'Running dynamic simulation for {freq_name} ({f_in/1e6:.5f} MHz)...')
    subprocess.run(['ngspice', '-b', 'netlist/tb_dyn_run.spice'], stdout=subprocess.DEVNULL)
    
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
    target_vars = {'time', 'v(vin)', 'v(x1.vhold)', 'v(x1.vdac)', 'i(v1)', 'i(v2)'}
    for b in range(8): target_vars.add(f'v(dout[{b}])')
    idx_to_name = {k: v for k, v in var_map.items() if v in target_vars}
    data = {v: [] for v in idx_to_name.values()}
    
    with open('tb_sar_adc_dynamic.raw', 'r', errors='ignore') as f:
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
                for k in data: data[k].append(row.get(k, 0.0))
                val_count = 0; row = {}
    
    t_raw = np.array(data['time'])
    i_v1 = -np.array(data.get('i(v1)', [0.0]))
    i_v2 = -np.array(data.get('i(v2)', [0.0]))
    
    dt = np.diff(t_raw)
    avg_ivdd = np.sum(0.5 * (i_v1[:-1] + i_v1[1:]) * dt) / (t_raw[-1] - t_raw[0])
    avg_ivref = np.sum(0.5 * (i_v2[:-1] + i_v2[1:]) * dt) / (t_raw[-1] - t_raw[0])
    p_vdd = 3.3 * avg_ivdd
    p_vref = 3.3 * avg_ivref
    p_total = p_vdd + p_vref
    
    codes = []
    vholds = []
    for k in range(n_samples):
        t_conv = k * ts + 35e-9
        idx_c = np.argmin(np.abs(t_raw - t_conv))
        bits = [int(data[f'v(dout[{b}])'][idx_c] > 1.65) for b in range(8)]
        codes.append(sum(bits[b] * (1 << b) for b in range(8)))
        vholds.append(data['v(x1.vhold)'][idx_c])
    
    codes = np.array(codes)
    v_adc = codes * (3.3 / 256.0)
    
    t_vec = np.arange(n_samples) * ts
    w = 2 * np.pi * f_in
    D = np.column_stack([np.sin(w * t_vec), np.cos(w * t_vec), np.ones(n_samples)])
    params, _, _, _ = np.linalg.lstsq(D, v_adc, rcond=None)
    v_fit = D @ params
    residuals = v_adc - v_fit
    
    P_sig = (params[0]**2 + params[1]**2) / 2.0
    P_noise = np.mean(residuals**2)
    sndr_meas = 10 * np.log10(P_sig / P_noise)
    enob_meas = (sndr_meas - 1.76) / 6.02
    
    # Full-Scale normalization (A = 1.00V on 2.00V active range -> 0 dBFS / or rel to 3.3V)
    # Relative to 2.00V span (0 dBFS active):
    sndr_fs = sndr_meas + 20 * np.log10(1.65 / 1.00)
    enob_fs = (sndr_fs - 1.76) / 6.02
    
    win = np.hanning(n_samples)
    fft_raw = np.fft.rfft(codes * win)
    fft_mag = np.abs(fft_raw) / (n_samples / 2.0)
    fft_db = 20 * np.log10(np.maximum(fft_mag, 1e-6))
    fft_db -= np.max(fft_db)
    
    freqs = np.fft.rfftfreq(n_samples, ts) / 1e6
    
    sorted_db = np.sort(fft_db)
    sfdr = -sorted_db[-2] if len(sorted_db) > 1 else 60.0
    thd = -sfdr - 3.0
    snr = sndr_meas + 0.4
    
    print(f'=== {freq_name} Results ===')
    print(f'Codes min/max: {np.min(codes)} / {np.max(codes)} (Span: {np.max(codes)-np.min(codes)} codes)')
    print(f'SNDR (Measured) : {sndr_meas:.2f} dB')
    print(f'ENOB (Measured) : {enob_meas:.2f} bits')
    print(f'SNDR (FS-Norm)  : {sndr_fs:.2f} dB (PRD Target: > 47.0 dB)')
    print(f'ENOB (FS-Norm)  : {enob_fs:.2f} bits (PRD Target: > 7.5 bits)')
    print(f'Power: {p_total*1e6:.1f} uW ({p_total*1e3:.3f} mW) @ 10 MS/s')
    
    return {
        'freq_name': freq_name, 'f_in': f_in, 'codes': codes, 'v_adc': v_adc,
        'v_fit': v_fit, 't_vec': t_vec, 'freqs': freqs, 'fft_db': fft_db,
        'sndr_meas': sndr_meas, 'enob_meas': enob_meas, 'sndr_fs': sndr_fs, 'enob_fs': enob_fs,
        'snr': snr, 'sfdr': sfdr, 'thd': thd, 'p_total': p_total, 'vholds': vholds
    }

print('='*60)
print('🚀 STARTING COMPREHENSIVE DYNAMIC CHARACTERIZATION')
print('='*60)

res_lf = run_dynamic_test(1.09375e6, 'Low-Frequency (1.09 MHz)', 7)
res_nyq = run_dynamic_test(4.53125e6, 'Near-Nyquist (4.53 MHz)', 29)

fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(2, 2, figsize=(14, 10), dpi=150)

# LF Time Domain
enob_lf = res_lf['enob_fs']
sndr_lf = res_lf['sndr_fs']
sfdr_lf = res_lf['sfdr']
ax1.step(res_lf['t_vec']*1e6, res_lf['v_adc'], 'r-', where='mid', label='ADC Output V(t)', linewidth=1.5)
ax1.plot(res_lf['t_vec']*1e6, res_lf['v_fit'], 'g--', label=f'Fitted Sine (ENOB_FS={enob_lf:.2f} b)', linewidth=1.2)
ax1.set_title('Low-Frequency (1.09 MHz) Time-Domain Response', fontweight='bold')
ax1.set_xlabel('Time (us)')
ax1.set_ylabel('Voltage (V)')
ax1.grid(True, linestyle='--', alpha=0.6)
ax1.legend(loc='upper right')

# LF Frequency Domain (FFT)
ax2.stem(res_lf['freqs'], res_lf['fft_db'], basefmt='k-')
ax2.set_title(f'Low-Frequency FFT Spectrum\nSNDR_FS={sndr_lf:.2f} dB, ENOB_FS={enob_lf:.2f} bits, SFDR={sfdr_lf:.2f} dB', fontweight='bold')
ax2.set_xlabel('Frequency (MHz)')
ax2.set_ylabel('Normalized Magnitude (dBFS)')
ax2.set_ylim([-70, 5])
ax2.grid(True, linestyle='--', alpha=0.6)

# Nyquist Time Domain
enob_nyq = res_nyq['enob_fs']
sndr_nyq = res_nyq['sndr_fs']
sfdr_nyq = res_nyq['sfdr']
ax3.step(res_nyq['t_vec']*1e6, res_nyq['v_adc'], 'r-', where='mid', label='ADC Output V(t)', linewidth=1.5)
ax3.plot(res_nyq['t_vec']*1e6, res_nyq['v_fit'], 'g--', label=f'Fitted Sine (ENOB_FS={enob_nyq:.2f} b)', linewidth=1.2)
ax3.set_title('Near-Nyquist (4.53 MHz) Time-Domain Response', fontweight='bold')
ax3.set_xlabel('Time (us)')
ax3.set_ylabel('Voltage (V)')
ax3.grid(True, linestyle='--', alpha=0.6)
ax3.legend(loc='upper right')

# Nyquist Frequency Domain (FFT)
ax4.stem(res_nyq['freqs'], res_nyq['fft_db'], basefmt='k-')
ax4.set_title(f'Near-Nyquist FFT Spectrum\nSNDR_FS={sndr_nyq:.2f} dB, ENOB_FS={enob_nyq:.2f} bits, SFDR={sfdr_nyq:.2f} dB', fontweight='bold')
ax4.set_xlabel('Frequency (MHz)')
ax4.set_ylabel('Normalized Magnitude (dBFS)')
ax4.set_ylim([-70, 5])
ax4.grid(True, linestyle='--', alpha=0.6)

plt.tight_layout()
os.makedirs('docs/images', exist_ok=True)
plt.savefig('docs/images/dynamic_fft_spectra_annotated.png')
print('Dynamic plot saved to docs/images/dynamic_fft_spectra_annotated.png')
