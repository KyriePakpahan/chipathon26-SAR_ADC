import sys
sys.path.insert(0, '/foss/designs/chipathon26-SAR_ADC/scripts')
from debug_lvs_nets import parse_flat

# Parse layout
layout_devs = parse_flat('/foss/designs/chipathon26-SAR_ADC/scripts/lvs_async_sar_final30/async_sar.cir')

# Parse schematic
with open('/foss/designs/chipathon26-SAR_ADC/scripts/async_sar_hierarchical.spice') as f:
    text = f.read()

lines = text.split('\n')
subckts = {}
cur_name = None
cur_pins = []
cur_elements = []

full_lines = []
curr = ''
for l in lines:
    l = l.strip()
    if not l or l.startswith('*'): continue
    if l.startswith('+'): curr += ' ' + l[1:].strip()
    else:
        if curr: full_lines.append(curr)
        curr = l
if curr: full_lines.append(curr)

for l in full_lines:
    t = l.split()
    if t[0].lower() == '.subckt':
        cur_name = t[1]
        cur_pins = t[2:]
        cur_elements = []
    elif t[0].lower() == '.ends':
        subckts[cur_name] = {'pins': cur_pins, 'elements': cur_elements}
        cur_name = None
    elif cur_name:
        cur_elements.append(t)

def flatten(cell_name, pin_map, prefix):
    devs = []
    for elem in subckts[cell_name]['elements']:
        if elem[0].upper().startswith('M'):
            d = pin_map.get(elem[1], f'{prefix}_{elem[1]}')
            g = pin_map.get(elem[2], f'{prefix}_{elem[2]}')
            s = pin_map.get(elem[3], f'{prefix}_{elem[3]}')
            b = pin_map.get(elem[4], f'{prefix}_{elem[4]}')
            devs.append({'name': f'{prefix}_{elem[0]}', 'd': d.lower(), 'g': g.lower(), 's': s.lower(), 'b': b.lower(), 'model': elem[5].lower()})
        elif elem[0].upper().startswith('X'):
            inst_name = elem[0]
            sub_cell = elem[-1]
            inst_pins = elem[1:-1]
            def_pins = subckts[sub_cell]['pins']
            sub_map = {}
            for dp, ip in zip(def_pins, inst_pins):
                sub_map[dp] = pin_map.get(ip, f'{prefix}_{ip}')
            devs.extend(flatten(sub_cell, sub_map, f'{prefix}_{inst_name}'))
    return devs

top_map = {p: p for p in subckts['async_sar']['pins']}
sch_devs = flatten('async_sar', top_map, 'top')

# Build net degrees for schematic
sch_nets = {}
for d in sch_devs:
    for n in (d['d'], d['g'], d['s'], d['b']):
        sch_nets.setdefault(n, []).append(d)

layout_nets = {}
for d in layout_devs:
    for n in (d['d'], d['g'], d['s'], d['b']):
        layout_nets.setdefault(n, []).append(d)

print(f'Schematic distinct nets: {len(sch_nets)}, Layout distinct nets: {len(layout_nets)}')

# Top-level named nets comparison:
for name in ['vdd', 'vss', 'start', 'comp_done', 'comp_out_p', 'rst_n_int', 'comp_done_b', 'sample_en', 'done', 'rst_latch'] + [f'dout[{i}]' for i in range(8)] + [f'dac_in[{i}]' for i in range(8)]:
    sch_len = len(sch_nets.get(name, []))
    lay_len = len(layout_nets.get(name, []))
    print(f'  Pin {name:15s}: Sch pins = {sch_len:3d}, Lay pins = {lay_len:3d}  {"OK" if sch_len==lay_len else "MISMATCH!"}')
