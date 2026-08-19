import sys
sys.path.append(".")
import numpy as np
import subprocess
import os
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from scripts.verify_prd_compliance import parse_raw_file
from multiprocessing import Pool

print('='*70)
print('RUNNING CONTINUOUS SINUSOIDAL WAVEFORM TRANSIENT SIMULATION')
print('='*70)

with open('netlist/tb_sar_adc_top.spice') as f:
    template = f.read()
template = template.replace('tran 0.1n 100n', 'tran 0.1n 40n')

# Generate 64 coherent sinusoidal points across 7 cycles (fin = 1.09375 MHz, Fs = 10 MS/s)
fs = 10e6
N = 64
M = 7
fin = M * fs / N
t_k = np.arange(N) / fs
v_cm = 1.85
amp = 0.95
v_in_sin = v_cm + amp * np.sin(2 * np.pi * fin * t_k)

def sim_point(item):
    idx, vin = item
    raw_name = f'netlist/sin_wave_{idx}.raw'
    sp_name = f'netlist/sin_wave_{idx}.spice'
    sp = template.replace('V3 vin VSS 1.65', f'V3 vin VSS {vin:.4f}')
    sp = sp.replace('tb_sar_adc_top.raw', raw_name)
    with open(sp_name, 'w') as f:
        f.write(sp)
    res = subprocess.run(['ngspice', '-b', sp_name], capture_output=True, text=True)
    if not os.path.exists(raw_name):
        return (idx, vin, -1, 0.0)
    d = parse_raw_file(raw_name)
    bits = [int(d[f'v(dout[{b}])'][-1] > 1.65) for b in range(8)]
    code = sum(bits[b] * (1 << b) for b in range(8))
    # Sample and hold value
    vh = d.get('v(x1.vhold)', [vin])[-1]
    return (idx, vin, code, vh)

print(f'Simulating {N} sequential dynamic conversion cycles (fin = {fin/1e6:.4f} MHz)...')
with Pool(8) as p:
    results = p.map(sim_point, enumerate(v_in_sin))

codes = np.array([r[2] for r in results], dtype=float)
v_recon = codes / 256.0 * 3.3
v_in_arr = np.array([r[1] for r in results])
v_hold_arr = np.array([r[3] for r in results])
t_us = t_k * 1e6
q_error_mv = (v_recon - v_in_arr) * 1000.0
q_error_lsb = q_error_mv / 12.89

# Dense continuous input sinusoid for pristine plotting
t_dense_us = np.linspace(0, (N-1)/fs*1e6, 1000)
v_dense_sin = v_cm + amp * np.sin(2 * np.pi * fin * (t_dense_us * 1e-6))

# IEEE 1241 Spectral Calculation
x = codes - np.mean(codes)
X = np.fft.rfft(x)
pwr = np.abs(X)**2
sig_bin = M
sig_pwr = pwr[sig_bin]
noise_bins = [b for b in range(1, len(X)) if b != sig_bin]
tot_noise = sum(pwr[b] for b in noise_bins)
sndr = 10 * np.log10(sig_pwr / tot_noise)
fs_gain = 20 * np.log10(1.65 / amp)
sndr_fs = sndr + fs_gain
enob_fs = (sndr_fs - 1.76) / 6.02
spur_pwr = max(pwr[b] for b in noise_bins)
sfdr = 10 * np.log10(sig_pwr / spur_pwr)

print(f'Done! ENOB_FS = {enob_fs:.2f} bits, SNDR_FS = {sndr_fs:.2f} dB, SFDR = {sfdr:.2f} dB')

# Plot Figure
fig, (ax1, ax2, ax3) = plt.subplots(3, 1, figsize=(15, 11), dpi=200, gridspec_kw={'height_ratios': [2.2, 1.2, 1.5], 'hspace': 0.35})

# Subplot 1: Continuous Sinusoid vs Sampled & Reconstructed Waveform
ax1.plot(t_dense_us, v_dense_sin, 'b-', lw=1.5, label=r'Continuous Analog Input {in}(t)$ (1.09 MHz Sine)', alpha=0.8)
ax1.step(t_us, v_recon, 'r-', where='post', lw=2.0, label=r'8-Bit ADC Reconstructed Output {recon}(t)$')
ax1.plot(t_us, v_in_arr, 'ko', markersize=4.5, label='Sampled Discrete Time Points ( = 10$ MS/s)')
ax1.set_title(f'Continuous Dynamic Sinusoidal Waveform Tracking & 8-Bit DAC Reconstruction (fin = {fin/1e6:.4f} MHz, Fs = 10 MS/s)', fontsize=12, fontweight='bold')
ax1.set_ylabel('Voltage (V)', fontsize=11)
ax1.set_xlim([0, (N-1)/fs*1e6])
ax1.set_ylim([0.7, 3.1])
ax1.grid(True, alpha=0.3)
ax1.legend(loc='upper right', framealpha=0.9)

# Subplot 2: Instantaneous Quantization & Dynamic Tracking Error
ax2.step(t_us, q_error_lsb, 'm-', where='post', lw=1.5, label='Instantaneous Quantization Error (t)$')
ax2.axhline(1.0, color='r', ls='--', alpha=0.6, label=r'$\pm 1.0$ LSB Bound')
ax2.axhline(-1.0, color='r', ls='--', alpha=0.6)
ax2.axhline(0.0, color='k', ls=':', alpha=0.4)
ax2.set_title(r'Instantaneous Quantization Error (t) = V_{recon}(t) - V_{in}(t)$ (LSB)', fontsize=11, fontweight='bold')
ax2.set_ylabel('Error (LSB)', fontsize=10)
ax2.set_xlim([0, (N-1)/fs*1e6])
ax2.set_ylim([-2.5, 2.5])
ax2.grid(True, alpha=0.3)
ax2.legend(loc='upper right', framealpha=0.9)

# Subplot 3: Dynamic FFT Spectrum
freqs = np.fft.rfftfreq(N, 1/fs)
pwr_safe = np.maximum(pwr, 1e-12)
fft_db = 10 * np.log10(pwr_safe / sig_pwr)
ax3.stem(freqs/1e6, fft_db, linefmt='b-', markerfmt='bo', basefmt='k-')
ax3.set_title(f'Dynamic FFT Spectrum (Full-Scale ENOB = {enob_fs:.2f} Bits, SNDR = {sndr_fs:.2f} dB, SFDR = {sfdr:.2f} dB)', fontsize=11, fontweight='bold')
ax3.set_xlabel(r'Time ($\mu) / Frequency (MHz)', fontsize=10)
ax3.set_ylabel('Normalized Magnitude (dBFS)', fontsize=10)
ax3.set_ylim([-60, 5])
ax3.grid(True, alpha=0.3)

out_png = 'sinusoidal_dynamic_reconstruction.png'
plt.savefig(out_png, bbox_inches='tight')
print(f'Successfully saved continuous dynamic waveform graphic to {out_png}')
