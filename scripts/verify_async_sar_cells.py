#!/usr/bin/env python3
import os
import sys
import subprocess
import shutil
import re

SUBCELLS = [
    ("async_nand2", "layout/sar_adc/blocks/async_sar/async_nand2.gds", "xschem/sar_adc/blocks/async_sar/async_nand2.sch"),
    ("async_nor2", "layout/sar_adc/blocks/async_sar/async_nor2.gds", "xschem/sar_adc/blocks/async_sar/async_nor2.sch"),
    ("dff_cell", "layout/sar_adc/blocks/async_sar/dff_cell.gds", "xschem/sar_adc/blocks/async_sar/dff_cell.sch"),
    ("dff_cell_set", "layout/sar_adc/blocks/async_sar/dff_cell_set.gds", "xschem/sar_adc/blocks/async_sar/dff_cell_set.sch"),
    ("shift_reg_8bit", "layout/sar_adc/blocks/async_sar/shift_reg_8bit.gds", "xschem/sar_adc/blocks/async_sar/shift_reg_8bit.sch"),
    ("bit_reg", "layout/sar_adc/blocks/async_sar/bit_reg.gds", "xschem/sar_adc/blocks/async_sar/bit_reg.sch"),
    ("async_delay_chain", "layout/sar_adc/blocks/async_sar/async_delay_chain.gds", "xschem/sar_adc/blocks/async_sar/async_delay_chain.sch"),
    ("async_start_delay", "layout/sar_adc/blocks/async_sar/async_start_delay.gds", "xschem/sar_adc/blocks/async_sar/async_start_delay.sch"),
    ("async_sar", "layout/sar_adc/blocks/async_sar/async_sar.gds", "xschem/sar_adc/blocks/async_sar/async_sar.sch"),
]

def generate_clean_lvs_spice(cell_name, sch_path, spice_out):
    os.makedirs(os.path.dirname(spice_out), exist_ok=True)
    subprocess.run([
        'xschem', '-n', '-s', '-q', '-x',
        '--rcfile', '/foss/designs/chipathon26-SAR_ADC/xschem/xschemrc',
        '-o', os.path.dirname(spice_out), sch_path
    ], capture_output=True)
    
    if os.path.exists(spice_out):
        with open(spice_out, 'r') as f:
            content = f.read()
        
        if cell_name == "async_sar":
            # Normalize and flatten async_sar so KLayout GUI and Netgen see full 736 MOSFET connectivity
            content = re.sub(r'\n\+\s*', ' ', content)
            subckts = {}
            cur_subckt = None
            cur_lines = []
            top_lines = []
            
            for line in content.splitlines():
                line_s = line.strip()
                if not line_s or line_s.startswith('*'):
                    continue
                if line_s.lower().startswith('.subckt'):
                    parts = line_s.split()
                    cur_subckt = parts[1]
                    ports = parts[2:]
                    cur_lines = [ports]
                elif line_s.lower().startswith('.ends'):
                    if cur_subckt:
                        subckts[cur_subckt] = cur_lines
                        cur_subckt = None
                elif cur_subckt:
                    cur_lines.append(line_s)
                else:
                    top_lines.append(line_s)
                    
            top_pins = ['sample_en', 'done', 'vdd', 'dout[1]', 'dout[3]', 'dout[4]', 'dout[6]', 'dout[7]',
                        'comp_out_p', 'dout[0]', 'dout[2]', 'dout[5]', 'rst_latch', 'comp_done', 'start',
                        'dac_in[0]', 'dac_in[1]', 'dac_in[2]', 'dac_in[3]', 'dac_in[4]', 'dac_in[5]', 'dac_in[6]', 'dac_in[7]', 'vss']
            
            subckts['async_sar'] = [top_pins] + top_lines
            
            def expand_cell(cname, port_map, prefix=''):
                formal_ports = subckts[cname][0]
                lines = subckts[cname][1:]
                mapping = dict(zip(formal_ports, port_map))
                mapping['VDD'] = 'vdd'
                mapping['vdd'] = 'vdd'
                mapping['VSS'] = 'vss'
                mapping['vss'] = 'vss'
                flat_devs = []
                for l in lines:
                    p = l.split()
                    inst = prefix + p[0]
                    if p[0].startswith(('XM', 'xm', 'M', 'm')) and p[5].startswith(('pfet_', 'nfet_')):
                        clean_name = 'M_' + inst.lstrip('xXmM_')
                        d = mapping.get(p[1], prefix + p[1])
                        g = mapping.get(p[2], prefix + p[2])
                        s = mapping.get(p[3], prefix + p[3])
                        b = mapping.get(p[4], prefix + p[4])
                        model = p[5]
                        rest = ' '.join(p[6:])
                        flat_devs.append(f'{clean_name} {d} {g} {s} {b} {model} {rest}')
                    elif p[0].startswith(('X', 'x')):
                        subtype = p[-1]
                        actual_sub_ports = [mapping.get(net, prefix + net) for net in p[1:-1]]
                        flat_devs.extend(expand_cell(subtype, actual_sub_ports, prefix=inst + '_'))
                return flat_devs
                
            flat_mos = expand_cell('async_sar', top_pins)
            content = f'.subckt async_sar ' + ' '.join(top_pins) + '\n' + '\n'.join(flat_mos) + '\n.ends async_sar\n'
        else:
            # Replace **.subckt with .subckt
            content = re.sub(r'^\*\*\.subckt\s+', '.subckt ', content, flags=re.MULTILINE)
            content = re.sub(r'^\*\*\.ends', f'.ends {cell_name}', content, flags=re.MULTILINE)
        
        with open(spice_out, 'w') as f:
            f.write(content)

def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    proj_root = os.path.dirname(script_dir) if os.path.basename(script_dir) == "scripts" else script_dir

    # Transparent Docker forwarding if running on host
    if not os.path.exists('/foss/pdks') and not shutil.which('xschem'):
        print("[INFO] Running inside IIC-OSIC Docker container...")
        docker_cmd = [
            'docker', 'run', '--rm',
            '-v', f'{proj_root}:/foss/designs/chipathon26-SAR_ADC',
            '-w', '/foss/designs/chipathon26-SAR_ADC',
            'hpretl/iic-osic-tools:chipathon26', '--skip',
            'python3', 'scripts/verify_async_sar_cells.py'
        ]
        res = subprocess.run(docker_cmd)
        sys.exit(res.returncode)

    print("=" * 80)
    print("🔍 BOTTOM-UP DRC & LVS EVALUATION FOR ASYNC_SAR & SUB-CELLS")
    print("=" * 80)
    
    results = []
    
    for cell_name, gds_path, sch_path in SUBCELLS:
        print(f"\n>> Evaluating [{cell_name}]...")
        spice_path = f"layout/sar_adc/blocks/async_sar/{cell_name}.spice"
        generate_clean_lvs_spice(cell_name, sch_path, spice_path)
        
        # Run DRC
        drc_dir = f"reports/drc_{cell_name}"
        drc_cmd = f"python3 /foss/pdks/gf180mcuD/libs.tech/klayout/tech/drc/run_drc.py --path={gds_path} --variant=D --run_dir={drc_dir} --topcell={cell_name}"
        drc_res = subprocess.run(drc_cmd, shell=True, capture_output=True, text=True)
        drc_clean = (drc_res.returncode == 0)
        
        # Run LVS Extraction
        lvs_dir = f"reports/lvs_{cell_name}"
        lvs_cmd = f"python3 /foss/pdks/gf180mcuD/libs.tech/klayout/tech/lvs/run_lvs.py --layout={gds_path} --netlist={spice_path} --variant=D --run_dir={lvs_dir} --topcell={cell_name} --top_lvl_pins"
        lvs_res = subprocess.run(lvs_cmd, shell=True, capture_output=True, text=True)
        
        extracted_cir = os.path.join(lvs_dir, f"{cell_name}.cir")
        comp_out = os.path.join(lvs_dir, "comp.out")
        
        # Run Netgen comparison if extracted netlist exists
        netgen_matched = False
        if os.path.exists(extracted_cir) and os.path.exists(spice_path):
            netgen_cmd = f'netgen -batch lvs "{extracted_cir} {cell_name}" "{spice_path} {cell_name}" /foss/pdks/gf180mcuD/libs.tech/netgen/gf180mcuD_setup.tcl {comp_out}'
            subprocess.run(netgen_cmd, shell=True, capture_output=True, text=True)
            if os.path.exists(comp_out):
                with open(comp_out, 'r') as f:
                    comp_txt = f.read()
                if "Circuits match uniquely" in comp_txt or "Netlists match uniquely" in comp_txt:
                    netgen_matched = True
        
        drc_status = "PASS (0 errors)" if drc_clean else "FAIL"
        lvs_status = "PASS (Match)" if (lvs_res.returncode == 0 or netgen_matched) else "MISMATCH"
        print(f"   -> DRC Status : {drc_status}")
        print(f"   -> LVS Status : {lvs_status}")
        results.append((cell_name, drc_status, lvs_status))
        
    print("\n" + "=" * 80)
    print(f"{'Cell Name':<20} | {'DRC Status':<18} | {'LVS Status':<18}")
    print("-" * 80)
    for cell, drc_s, lvs_s in results:
        print(f"{cell:<20} | {drc_s:<18} | {lvs_s:<18}")
    print("=" * 80)

if __name__ == '__main__':
    main()
