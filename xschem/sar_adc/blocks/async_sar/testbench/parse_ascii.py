import re

def parse_raw(filename):
    with open(filename, 'r') as f:
        lines = f.readlines()
    
    var_start = -1
    for i, line in enumerate(lines):
        if line.startswith('Variables:'):
            var_start = i + 1
            break
            
    if var_start == -1: return
        
    vars_dict = {}
    i = var_start
    while not lines[i].startswith('Values:'):
        parts = lines[i].strip().split()
        if len(parts) >= 3:
            idx = int(parts[0])
            name = parts[1]
            vars_dict[name] = idx
        i += 1
        
    val_start = i + 1
    time_idx = vars_dict.get('time')
    
    keys = ['v(start)', 'v(done)', 'v(sample_en)'] + [f'v(x1.q{i})' for i in range(8)] + [f'v(dout[{i}])' for i in range(8)] + [f'v(dac_in[{i}])' for i in range(8)]
    idx_map = {k: vars_dict.get(k) for k in keys if vars_dict.get(k) is not None}
    
    data = {k: [] for k in idx_map.keys()}
    data['time'] = []
    
    for line in lines[val_start:]:
        parts = line.strip().split()
        if not parts: continue
        
        if len(parts) == 2 and '\t' in line:
            val_idx = 0
            val = float(parts[1])
        elif len(parts) == 2 and line.startswith(' '):
            val_idx = int(parts[0])
            val = float(parts[1])
        elif len(parts) == 1:
            val = float(parts[0])
            val_idx += 1
        else:
            val_idx = int(parts[0])
            val = float(parts[1])
            
        if val_idx == time_idx: data['time'].append(val)
        for k, v_idx in idx_map.items():
            if val_idx == v_idx: data[k].append(val)
                
    print('Simulation duration:', data['time'][-1])
    
    prev_state = None
    for t_idx, t in enumerate(data['time']):
        state = {}
        for k in keys:
            if k in data and len(data[k]) > t_idx:
                v = data[k][t_idx]
                state[k] = 1 if v > 1.65 else 0
        if state != prev_state:
            q_str = ''.join(str(state.get(f'v(x1.q{i})',0)) for i in range(7,-1,-1))
            dout_str = ''.join(str(state.get(f'v(dout[{i}])',0)) for i in range(7,-1,-1))
            dac_str = ''.join(str(state.get(f'v(dac_in[{i}])',0)) for i in range(7,-1,-1))
            print(f'Time: {t*1e9:.2f} ns | start={state.get("v(start)",0)} done={state.get("v(done)",0)} samp_en={state.get("v(sample_en)",0)} Q={q_str} DOUT={dout_str} DAC={dac_str}')
            prev_state = state

parse_raw('tb_async_sar_ascii.raw')
