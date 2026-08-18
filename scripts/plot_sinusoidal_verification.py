import os
import sys
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

# Parse variables dynamically by name
with open('tb_sar_adc_dynamic.raw', 'r', errors='ignore') as f:
    var_map = {}
    reading_vars = False
    for line in f:
        if line.startswith('Variables:'):
            reading_vars = True
            continue
        if line.startswith('Values:'):
            break
        if reading_vars:
            parts = line.strip().split()
            if len(parts) >= 2:
                var_idx = int(parts[0])
                var_name = parts[1]
                var_map[var_idx] = var_name

num_vars = len(var_map)
target_vars = {'time', 'v(vin)', 'v(x1.vhold)', 'v(x1.vdac)', 'v(done)'}
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
            val = float(parts[1])
            var_idx = 0
        else:
            val = float(parts[0])
            var_idx = val_count
        if var_idx in idx_to_name:
            row[idx_to_name[var_idx]] = val
        val_count += 1
        if val_count == num_vars:
            for k in data:
                data[k].append(row.get(k, 0.0))
            val_count = 0
            row = {}

t_raw = np.array(data['time'])
t_us = t_raw * 1e6 # us
vin_arr = np.array(data['v(vin)'])
vhold_arr = np.array(data['v(x1.vhold)'])

N = 64
sample_t = []
codes = []
v_holds = []
v_ins = []

for k in range(N):
    t_conv = (k + 0.90) * 100e-9
    t_samp = (k + 0.05) * 100e-9
    idx_c = np.argmin(np.abs(t_raw - t_conv))
    idx_s = np.argmin(np.abs(t_raw - t_samp))
    
    bits = [int(data[f'v(dout[{b}])'][idx_c] > 1.65) for b in range(8)]
    code = sum(bits[b] * (1 << b) for b in range(8))
    codes.append(code)
    v_holds.append(vhold_arr[idx_c])
    v_ins.append(vin_arr[idx_s])
    sample_t.append(t_conv * 1e6)

codes = np.array(codes)
v_adc = codes * (3.3 / 256.0)
sample_t = np.array(sample_t)
v_holds = np.array(v_holds)
v_ins = np.array(v_ins)

# Coherent Sine Fit (IEEE 1241)
t_vec = np.arange(N) * 100e-9
f_in = 1.09375e6
w = 2 * np.pi * f_in
D = np.column_stack([np.sin(w * t_vec), np.cos(w * t_vec), np.ones(N)])
params, _, _, _ = np.linalg.lstsq(D, v_adc, rcond=None)
v_fit = D @ params
residuals = (v_adc - v_fit) / (3.3 / 256.0) # LSB

# FFT
fft_vals = np.fft.fft(codes - np.mean(codes))
mag_db = 20 * np.log10(np.abs(fft_vals[:N//2]) / (N / 2) + 1e-12)

# 3-Panel Plot
fig = plt.figure(figsize=(12, 10))

# 1. Transient Waveform Comparison
ax1 = plt.subplot2grid((3, 2), (0, 0), colspan=2)
ax1.plot(t_us[:15000], vin_arr[:15000], 'k-', alpha=0.5, label='Analog Input Vin(t)')
ax1.plot(t_us[:15000], vhold_arr[:15000], 'b-', alpha=0.7, label='Sample & Hold Vhold(t)')
ax1.step(sample_t[:15], v_adc[:15], 'r-', where='post', linewidth=2, label='Reconstructed ADC Vout')
ax1.set_title('Top-Level 8-Bit SAR ADC: Dynamic Sinusoidal Tracking (First 1.5 µs)', fontsize=13, fontweight='bold')
ax1.set_xlabel('Time (µs)', fontsize=11)
ax1.set_ylabel('Voltage (V)', fontsize=11)
ax1.set_xlim(0, 1.5)
ax1.grid(True, linestyle=':', alpha=0.6)
ax1.legend(loc='upper right', fontsize=10)

# 2. Reconstructed Full 64-Cycle Sine & Error
ax2 = plt.subplot2grid((3, 2), (1, 0), colspan=2)
ax2.plot(sample_t, v_holds, 'g--', alpha=0.6, label='Sampled Vhold')
ax2.step(sample_t, v_adc, 'r.-', where='mid', label='ADC Reconstructed Output (64 Cycles)')
ax2.plot(sample_t, v_fit, 'b:', label='Best-Fit Fundamental Sine')
ax2.set_title('Full 64-Cycle Coherent Sinusoidal Acquisition (Fs = 10 MS/s, Fin = 1.09375 MHz)', fontsize=13, fontweight='bold')
ax2.set_xlabel('Time (µs)', fontsize=11)
ax2.set_ylabel('ADC Output Voltage (V)', fontsize=11)
ax2.grid(True, linestyle=':', alpha=0.6)
ax2.legend(loc='upper right', fontsize=10)

# 3. Residual Error (LSB)
ax3 = plt.subplot2grid((3, 2), (2, 0))
ax3.stem(range(N), residuals, markerfmt='ro', basefmt='k-', label='Residual Error')
ax3.set_title('Conversion Residual Error (LSB)', fontsize=12, fontweight='bold')
ax3.set_xlabel('Cycle Index k', fontsize=10)
ax3.set_ylabel('Error (LSB)', fontsize=10)
ax3.grid(True, linestyle=':', alpha=0.6)

# 4. Coherent FFT Spectrum
ax4 = plt.subplot2grid((3, 2), (2, 1))
freqs = np.arange(N//2) * (10.0 / N) # MHz
ax4.plot(freqs, mag_db, 'bo-', linewidth=1.5, markersize=4)
ax4.set_title('64-Point Coherent FFT Spectrum', fontsize=12, fontweight='bold')
ax4.set_xlabel('Frequency (MHz)', fontsize=10)
ax4.set_ylabel('Magnitude (dBFS)', fontsize=10)
ax4.grid(True, linestyle=':', alpha=0.6)

plt.tight_layout()
os.makedirs('docs/images', exist_ok=True)
plot_file = 'docs/images/sinusoidal_dynamic_verification.png'
plt.savefig(plot_file, dpi=300)
print(f"Plot saved to: {plot_file}")
