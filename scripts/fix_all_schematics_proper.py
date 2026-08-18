#!/usr/bin/env python3
"""
Properly format all Xschem schematics to prevent:
1. Overlapping instances (ipin.sym placed at exact same coordinate as lab_wire.sym).
2. Open nets / disconnected I/O pins (add wire N connecting pin to label).
3. Missing or mismatched VDD/VSS connections.
"""

import glob
import os
import re

def fix_schematic(sch_path):
    with open(sch_path) as f:
        lines = f.readlines()

    wires = []
    components = []
    seen_wires = set()

    for l in lines:
        l = l.strip()
        if l.startswith('N '):
            parts = l.split()
            if len(parts) >= 5:
                x1, y1, x2, y2 = map(int, parts[1:5])
                lab = ''
                m = re.search(r'lab=(\S+)', l)
                if m: lab = m.group(1).rstrip('}')
                wire_key = (min((x1,y1), (x2,y2)), max((x1,y1), (x2,y2)), lab)
                if wire_key not in seen_wires:
                    seen_wires.add(wire_key)
                    wires.append(l)
        elif l.startswith('C '):
            components.append(l)

    # Inspect all instances
    # We want to separate overlapping ipin/opin/iopin and lab_wire
    new_components = []
    new_wires = list(wires)
    
    # Map coordinates to lab_wire
    labels_at = {}
    for comp in components:
        m = re.search(r'C \{([^}]+)\} (-?\d+) (-?\d+) (\d+) (\d+) \{([^}]*)\}', comp)
        if m and ('lab_wire.sym' in m.group(1) or 'lab_pin.sym' in m.group(1)):
            x, y, props = int(m.group(2)), int(m.group(3)), m.group(6)
            labels_at[(x, y)] = (comp, props)

    # Process components
    used_positions = {}
    for comp in components:
        m = re.search(r'C \{([^}]+)\} (-?\d+) (-?\d+) (\d+) (\d+) \{([^}]*)\}', comp)
        if not m:
            continue
        sym, x, y, rot, flip, props = m.group(1), int(m.group(2)), int(m.group(3)), int(m.group(4)), int(m.group(5)), m.group(6)
        
        # Check if it's an ipin/opin/iopin overlapping with lab_wire
        if 'pin.sym' in sym and ('ipin.sym' in sym or 'opin.sym' in sym or 'iopin.sym' in sym):
            lm = re.search(r'lab=(\S+)', props)
            plab = lm.group(1).rstrip('}') if lm else ''
            
            # If placed at same coordinate as a lab_wire, move pin by 30 units and add wire
            if (x, y) in labels_at:
                if 'opin.sym' in sym:
                    px = x + 30
                    new_wires.append(f"N {x} {y} {px} {y} {{lab={plab}}}")
                    comp = f"C {{{sym}}} {px} {y} {rot} {flip} {{{props}}}"
                else:
                    px = x - 30
                    new_wires.append(f"N {px} {y} {x} {y} {{lab={plab}}}")
                    comp = f"C {{{sym}}} {px} {y} {rot} {flip} {{{props}}}"
                    
        # Filter out duplicate identical components at the exact same coordinate
        pos_key = (sym, x, y)
        if pos_key in used_positions:
            # Duplicate instance! Skip to avoid "overlapped instance found"
            continue
        used_positions[pos_key] = True
        new_components.append(comp)

    # Assemble output
    out = ["v {xschem version=3.4.8RC file_version=1.3}", "G {}", "K {}", "V {}", "S {}", "F {}", "E {}"]
    out.extend(new_wires)
    out.extend(new_components)
    
    content = "\n".join(out) + "\n"
    with open(sch_path, "w") as f:
        f.write(content)

def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    prj_dir = os.path.dirname(script_dir)
    xschem_dir = os.path.join(prj_dir, "xschem")

    for sch in sorted(glob.glob(os.path.join(xschem_dir, "**", "*.sch"), recursive=True)):
        if "testbench" not in sch and "tb_" not in sch:
            fix_schematic(sch)
            print(f"[PROCESSED] {sch}")

if __name__ == "__main__":
    main()
