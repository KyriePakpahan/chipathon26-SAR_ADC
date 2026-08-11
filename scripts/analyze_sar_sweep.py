#!/usr/bin/env python3
import os, sys, glob, re
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

def parse_raw_binary(raw_path):
    with open(raw_path, 'rb') as f:
        header = b''
        while True:
            line = f.readline()
            header += line
            if line.startswith(b'Binary:'):
                break
                
    header_str = header.decode('latin1')
    n_vars = int(re.search(r'No\. Variables:\s+(\d+)', header_str).group(1))
    n_pts = int(re.search(r'No\. Points:\s+(\d+)', header_str).group(1))
    
    var_names = []
    for m in re.finditer(r'Variables:\s*\n((?:\s+\d+\s+[\w\.\(\)\[\]#]+\s+[\w\.\(\)\[\]#]+\n)+)', header_str):
        for vline in m.group(1).strip().splitlines():
            parts = vline.strip().split()
            var_names.append(parts[1])
            
    data = np.fromfile(raw_path, dtype=np.float64, offset=len(header))
    if len(data) != n_vars * n_pts:
        return None, None
        
    data = data.reshape((n_pts, n_vars))
    time = data[:, 0]
    traces = {var_names[i]: data[:, i] for i in range(n_vars)}
    return time, traces

def analyze_all_sweep_results():
    raw_files = sorted(glob.glob('/tmp/tb_vin_*.raw'))
    if not raw_files:
        print('No sweep raw files found yet.')
        return
        
    vref = 3.3
    n_bits = 8
    lsb_volts = vref / (2**n_bits)
    
    results = []
    
    for rf in raw_files:
        time_arr, traces = parse_raw_binary(rf)
        if time_arr is None:
            continue
            
        vin_val = np.mean(traces.get('v(vin)', traces.get('vin', np.array([0]))))
        v_done = traces.get('v(done)', traces.get('done', np.zeros_like(time_arr)))
        v_start = traces.get('v(start)', traces.get('start', np.zeros_like(time_arr)))
        
        # Find conversion end time (rising edge of done > 1.65V)
        done_idx = np.where(v_done > 1.65)[0]
        if len(done_idx) > 0:
            t_done = time_arr[done_idx[0]]
            sample_idx = done_idx[0]
        else:
            t_done = time_arr[-1]
            sample_idx = -1
            
        # Digital output bits at conversion end
        bits = []
        for b in range(8):
            b_name = f'v(dout[{b}])'
            if b_name not in traces:
                b_name = f'dout[{b}]'
            v_b = traces[b_name][sample_idx]
            bits.append(1 if v_b > 1.65 else 0)
            
        # Compute integer digital code: dout[7]*128 + ... + dout[0]*1
        actual_code = sum(bits[b] * (2**b) for b in range(8))
        ideal_code = int(np.clip(np.floor(vin_val / lsb_volts), 0, 255))
        reconstructed_analog = actual_code * lsb_volts
        
        # Conversion time from start falling edge (sample end) to done rising
        start_fall = np.where(v_start < 1.65)[0]
        if len(start_fall) > 0 and len(done_idx) > 0:
            t_start_fall = time_arr[start_fall[0]]
            t_conv = (t_done - t_start_fall) * 1e9 # in ns
        else:
            t_conv = t_done * 1e9
            
        # Average power consumption
        i_vdd = traces.get('v1#branch', np.zeros_like(time_arr))
        p_inst = np.abs(i_vdd) * vref
        p_avg = np.mean(p_inst) * 1e6 # in uW
        
        results.append({
            'vin': vin_val,
            'ideal_code': ideal_code,
            'actual_code': actual_code,
            'bits': bits,
            'reconstructed_analog': reconstructed_analog,
            'error_lsb': actual_code - ideal_code,
            't_conv_ns': t_conv,
            'p_avg_uW': p_avg
        })
        
    print(f'Successfully analyzed {len(results)} points!')
    return results

if __name__ == '__main__':
    analyze_all_sweep_results()
