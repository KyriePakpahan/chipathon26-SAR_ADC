#!/usr/bin/env python3
"""
Analyze top-level SAR ADC simulation results against PRD specifications.
"""

import os
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

def parse_raw_file(raw_path):
    with open(raw_path, 'r') as f:
        lines = f.readlines()
    
    # Locate Variables section
    var_names = []
    idx = 0
    while idx < len(lines):
        if lines[idx].startswith("Variables:"):
            idx += 1
            while idx < len(lines) and not lines[idx].startswith("Values:"):
                parts = lines[idx].strip().split()
                if len(parts) >= 2:
                    var_names.append(parts[1])
                idx += 1
            break
        idx += 1
    
    # Locate Values section
    data = {v: [] for v in var_names}
    if idx < len(lines) and lines[idx].startswith("Values:"):
        idx += 1
        curr_row = {}
        for l in lines[idx:]:
            parts = l.strip().split()
            if len(parts) == 2: # point_num, time
                val = float(parts[1])
                data[var_names[0]].append(val)
                curr_var_idx = 1
            elif len(parts) == 1:
                val = float(parts[0])
                if curr_var_idx < len(var_names):
                    data[var_names[curr_var_idx]].append(val)
                    curr_var_idx += 1

    return {k: np.array(v) for k, v in data.items()}

def main():
    raw_path = "tb_sar_adc_top.raw"
    if not os.path.exists(raw_path):
        print(f"Error: {raw_path} not found!")
        return

    data = parse_raw_file(raw_path)
    time = data.get('time', np.array([])) * 1e9 # in ns
    
    vin = data.get('v(vin)', np.zeros_like(time))
    done = data.get('v(done)', np.zeros_like(time))
    start = data.get('v(start)', np.zeros_like(time))
    vhold = data.get('v(x1.vhold)', np.zeros_like(time))
    vdac = data.get('v(x1.vdac)', np.zeros_like(time))
    
    douts = [data.get(f'v(dout[{i}])', np.zeros_like(time)) for i in range(8)]
    
    # Find conversion completion time (when done rises to > 2.0V)
    done_idx = np.where(done > 2.0)[0]
    if len(done_idx) > 0:
        t_done = time[done_idx[0]]
        t_start = 5.0 # start pulse falls at 5ns
        t_conv = t_done - t_start
        final_bits = [int(douts[i][done_idx[0]] > 1.65) for i in range(8)]
        code = sum(final_bits[i] * (1 << i) for i in range(8))
    else:
        t_done = time[-1]
        t_conv = time[-1] - 5.0
        final_bits = [int(douts[i][-1] > 1.65) for i in range(8)]
        code = sum(final_bits[i] * (1 << i) for i in range(8))
        
    print("=" * 70)
    print("TOP-LEVEL SAR ADC TRANSIENT SIMULATION RESULTS & PRD COMPARISON")
    print("=" * 70)
    print(f"Input Voltage (Vin)       : {vin[-1]:.4f} V (Target: 1.65 V / Midscale)")
    print(f"Reference Voltage (Vref)  : 3.3000 V")
    print(f"Sampled Hold Voltage      : {vhold[-1]:.4f} V")
    print(f"Final DAC Voltage (Vdac)  : {vdac[-1]:.4f} V")
    print(f"Conversion Done Time      : {t_done:.2f} ns (Start: 5.0 ns)")
    print(f"Total Conversion Time     : {t_conv:.2f} ns")
    print(f"Effective Sampling Speed  : {1000.0/t_conv:.2f} MS/s (Target: 20 - 50 MS/s)")
    print(f"Output Digital Code (Dec) : {code} (Expected: 128 / 0x80)")
    print(f"Output Digital Code (Bin) : {''.join(str(b) for b in reversed(final_bits))}")
    print("=" * 70)
    
    # Plot waveforms
    fig, axs = plt.subplots(4, 1, figsize=(10, 8), sharex=True)
    
    axs[0].plot(time, start, 'r', label='start')
    axs[0].plot(time, done, 'g', label='done (EOC)')
    axs[0].set_ylabel('Control [V]')
    axs[0].grid(True)
    axs[0].legend(loc='upper right')
    axs[0].set_title('Top-Level SAR ADC Functional Verification Waveforms')
    
    axs[1].plot(time, vhold, 'b', label='vhold (Sampled Vin)')
    axs[1].plot(time, vdac, 'm', label='vdac (CDAC output)')
    axs[1].set_ylabel('Analog [V]')
    axs[1].grid(True)
    axs[1].legend(loc='upper right')
    
    for i in [7, 6, 5, 4]:
        axs[2].plot(time, douts[i], label=f'dout[{i}]')
    axs[2].set_ylabel('MSB Bits [V]')
    axs[2].grid(True)
    axs[2].legend(loc='upper right')
    
    for i in [3, 2, 1, 0]:
        axs[3].plot(time, douts[i], label=f'dout[{i}]')
    axs[3].set_ylabel('LSB Bits [V]')
    axs[3].set_xlabel('Time [ns]')
    axs[3].grid(True)
    axs[3].legend(loc='upper right')
    
    plt.tight_layout()
    os.makedirs('docs/images', exist_ok=True)
    out_img = 'docs/images/tb_sar_adc_top_verified.png'
    plt.savefig(out_img, dpi=150)
    print(f"Waveform plot saved to {out_img}")

if __name__ == '__main__':
    main()
