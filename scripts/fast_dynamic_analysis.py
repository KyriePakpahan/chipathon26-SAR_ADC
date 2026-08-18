#!/usr/bin/env python3
"""
Fast analysis of 64-point coherent dynamic simulation of SAR ADC.
"""

import sys, os
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

raw_path = 'xschem/sar_adc/tb_sar_adc_dynamic.raw'
if not os.path.exists(raw_path):
    raw_path = 'tb_sar_adc_dynamic.raw'

print(f"Loading {raw_path}...")

with open(raw_path, 'r', errors='ignore') as f:
    lines = f.readlines()

var_start = False
val_start = False
var_names = []
data_start_idx = 0

for i, l in enumerate(lines):
    if l.startswith('Variables:'):
        var_start = True
        continue
    if l.startswith('Values:'):
        var_start = False
        val_start = True
        data_start_idx = i + 1
        break
    if var_start:
        parts = l.strip().split()
        if len(parts) >= 2:
            var_names.append(parts[1].lower())

num_vars = len(var_names)
print(f"Found {num_vars} variables. Parsing rows...")

# Build arrays
time_list = []
vin_list = []
done_list = []
vhold_list = []
vdac_list = []
dout_lists = [[] for _ in range(8)]

idx_time = var_names.index('time')
idx_vin = var_names.index('v(vin)')
idx_done = var_names.index('v(done)') if 'v(done)' in var_names else -1
idx_vhold = var_names.index('v(x1.vhold)') if 'v(x1.vhold)' in var_names else -1
idx_vdac = var_names.index('v(x1.vdac)') if 'v(x1.vdac)' in var_names else -1

idx_douts = []
for b in range(8):
    if f'v(x1.x4.dout[{b}])' in var_names:
        idx_douts.append(var_names.index(f'v(x1.x4.dout[{b}])'))
    elif f'v(dout[{b}])' in var_names:
        idx_douts.append(var_names.index(f'v(dout[{b}])'))
    else:
        idx_douts.append(-1)

row_buffer = []
for l in lines[data_start_idx:]:
    parts = l.strip().split()
    if not parts:
        continue
    if len(parts) == 2 and parts[0].isdigit() and '.' not in parts[0] and 'e' not in parts[0]:
        if len(row_buffer) == num_vars:
            time_list.append(row_buffer[idx_time])
            vin_list.append(row_buffer[idx_vin])
            if idx_done >= 0: done_list.append(row_buffer[idx_done])
            if idx_vhold >= 0: vhold_list.append(row_buffer[idx_vhold])
            if idx_vdac >= 0: vdac_list.append(row_buffer[idx_vdac])
            for b in range(8):
                if idx_douts[b] >= 0:
                    dout_lists[b].append(row_buffer[idx_douts[b]])
        row_buffer = [float(parts[1])]
    else:
        row_buffer.append(float(parts[0]))

if len(row_buffer) == num_vars:
    time_list.append(row_buffer[idx_time])
    vin_list.append(row_buffer[idx_vin])
    if idx_done >= 0: done_list.append(row_buffer[idx_done])
    if idx_vhold >= 0: vhold_list.append(row_buffer[idx_vhold])
    if idx_vdac >= 0: vdac_list.append(row_buffer[idx_vdac])
    for b in range(8):
        if idx_douts[b] >= 0:
            dout_lists[b].append(row_buffer[idx_douts[b]])

time_arr = np.array(time_list)
vin_arr = np.array(vin_list)
vhold_arr = np.array(vhold_list)
vdac_arr = np.array(vdac_list)
dout_arrs = [np.array(d) for d in dout_lists]

print(f"Loaded {len(time_arr)} time points across {time_arr[-1]*1e6:.2f} us simulation.")

# Sample at end of each 100ns cycle (e.g. at 90ns of each period)
N = 64
sample_times = [(k + 0.90) * 100e-9 for k in range(N)]
sampled_codes = []
sampled_vins = []
sampled_vholds = []

for k, t_target in enumerate(sample_times):
    idx = np.argmin(np.abs(time_arr - t_target))
    bits = [int(dout_arrs[b][idx] > 1.65) for b in range(8)]
    code = sum(bits[b] * (1 << b) for b in range(8))
    sampled_codes.append(code)
    sampled_vins.append(vin_arr[idx])
    sampled_vholds.append(vhold_arr[idx] if len(vhold_arr) > 0 else vin_arr[idx])

codes = np.array(sampled_codes)
vins = np.array(sampled_vins)
vholds = np.array(sampled_vholds)

print("\n" + "="*70)
print(f"{'Cycle':>5} {'Time (ns)':>10} {'Vin (V)':>10} {'Vhold (V)':>10} {'ADC Code':>10} {'Hex':>6}")
print("="*70)
for k in range(min(20, N)):
    print(f"{k:5d} {sample_times[k]*1e9:10.1f} {vins[k]:10.4f} {vholds[k]:10.4f} {codes[k]:10d} {hex(codes[k]):>6}")
print("... (showing first 20 of 64 cycles)")

# Compute Dynamic Performance Metrics (IEEE Std 1241)
# 4-parameter sine fit
t_vec = np.arange(N) * 100e-9
f_in = 1.09375e6 # M=7 coherent bin @ 10MS/s
sin_basis = np.sin(2 * np.pi * f_in * t_vec)
cos_basis = np.cos(2 * np.pi * f_in * t_vec)
A = np.vstack([sin_basis, cos_basis, np.ones(N)]).T
v_out = codes * (3.3 / 256.0)
params, _, _, _ = np.linalg.lstsq(A, v_out, rcond=None)
v_fit = A @ params

error = v_out - v_fit
signal_power = (params[0]**2 + params[1]**2) / 2.0
noise_power = np.mean(error**2)
sndr = 10 * np.log10(signal_power / noise_power)
enob = (sndr - 1.76) / 6.02

# FFT calculation
fft_vals = np.fft.fft(codes - np.mean(codes))
mag = np.abs(fft_vals[:N//2])
fund_bin = 7
P_sig_fft = mag[fund_bin]**2
mask = np.ones(N//2, dtype=bool)
mask[0] = False
mask[fund_bin] = False
P_nd_fft = np.sum(mag[mask]**2)
sndr_fft = 10 * np.log10(P_sig_fft / (P_nd_fft + 1e-15))
enob_fft = (sndr_fft - 1.76) / 6.02

sorted_peaks = np.sort(mag[mask])
sfdr = 20 * np.log10(mag[fund_bin] / sorted_peaks[-1]) if len(sorted_peaks) > 0 and sorted_peaks[-1] > 0 else 99.9

print("\n" + "="*70)
print("📊 8-BIT ASYNCHRONOUS SAR ADC PRD & DYNAMIC VERIFICATION RESULTS")
print("="*70)
print(f"Sampling Rate (Fs)        : 10.0 MS/s (Ts = 100 ns, 64 Coherent Cycles)")
print(f"Input Sine Frequency (Fin): {f_in/1e6:.5f} MHz (M=7 / N=64)")
print(f"Input Amplitude           : 2.00 Vpp (Vcm = 1.80 V, Range: 0.80V - 2.80V)")
print(f"Fitted Amplitude          : {np.sqrt(params[0]**2 + params[1]**2)*2:.3f} Vpp")
print(f"Fitted Offset (Vcm)       : {params[2]:.3f} V")
print(f"SNDR / SINAD              : {sndr:.2f} dB (PRD Literature Reference: ~45.2 dB)")
print(f"ENOB (IEEE 1241 Sine Fit) : {enob:.2f} bits (PRD Target: > 7.0 bits)")
print(f"ENOB (64-pt FFT Spectrum) : {enob_fft:.2f} bits")
print(f"SFDR                      : {sfdr:.2f} dB (PRD Literature Reference: ~57.3 dB)")
print("="*70)

# Plot full reconstruction and FFT
fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(10, 8), dpi=150)
ax1.plot(t_vec*1e6, vholds, 'b.-', label='Sampled Vhold (V)', alpha=0.6)
ax1.step(t_vec*1e6, v_out, 'r-', where='mid', label='ADC Reconstructed Vout (V)', linewidth=1.5)
ax1.plot(t_vec*1e6, v_fit, 'g--', label=f'Fitted Sine (ENOB = {enob:.2f} bits)', linewidth=1.2)
ax1.set_title(f'8-Bit Asynchronous SAR ADC Dynamic Response (GF180MCU 3.3V)\nSNDR = {sndr:.2f} dB, ENOB = {enob:.2f} bits, SFDR = {sfdr:.2f} dB', fontsize=12, fontweight='bold')
ax1.set_xlabel('Time (us)')
ax1.set_ylabel('Voltage (V)')
ax1.grid(True, linestyle='--', alpha=0.6)
ax1.legend(loc='upper right')

# Spectrum plot
freqs = np.fft.fftfreq(N, d=100e-9)[:N//2] / 1e6
mag_db = 20 * np.log10(mag / np.max(mag) + 1e-6)
ax2.stem(freqs, mag_db, basefmt='k-')
ax2.set_title('Normalized FFT Spectrum (dBFS)', fontsize=11, fontweight='bold')
ax2.set_xlabel('Frequency (MHz)')
ax2.set_ylabel('Magnitude (dBFS)')
ax2.set_ylim([-60, 5])
ax2.grid(True, linestyle='--', alpha=0.6)

plt.tight_layout()
os.makedirs('docs/images', exist_ok=True)
out_fig = 'docs/images/tb_sar_adc_dynamic_verified.png'
plt.savefig(out_fig)
print(f"Verification plot saved to {out_fig}")
