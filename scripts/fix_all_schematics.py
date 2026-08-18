#!/usr/bin/env python3
"""
Fix all pin misalignments, disconnected I/O pins, and floating wires in Xschem schematics.
"""

import glob
import os
import re

def fix_schematic(sch_path):
    with open(sch_path) as f:
        content = f.read()

    lines = content.splitlines()
    new_lines = []
    
    # 1. Collect all label positions
    labels_by_name = {}
    for l in lines:
        if 'lab_wire.sym' in l or 'lab_pin.sym' in l:
            m = re.search(r'C \{([^}]+)\} (-?\d+) (-?\d+) (\d+) (\d+) \{([^}]*)\}', l)
            if m:
                x, y, props = int(m.group(2)), int(m.group(3)), m.group(6)
                lm = re.search(r'lab=(\S+)', props)
                if lm:
                    lab = lm.group(1).rstrip('}')
                    if lab not in labels_by_name:
                        labels_by_name[lab] = []
                    labels_by_name[lab].append((x, y))

    # 2. Fix pins that are isolated (e.g. ipin.sym placed 50 units away from lab_wire.sym)
    for l in lines:
        m = re.search(r'C \{([^}]+)\} (-?\d+) (-?\d+) (\d+) (\d+) \{([^}]*)\}', l)
        if m and ('ipin.sym' in m.group(1) or 'opin.sym' in m.group(1) or 'iopin.sym' in m.group(1)):
            sym, x, y, rot, flip, props = m.group(1), int(m.group(2)), int(m.group(3)), int(m.group(4)), int(m.group(5)), m.group(6)
            lm = re.search(r'lab=(\S+)', props)
            if lm:
                lab = lm.group(1).rstrip('}')
                # If there is a label with this name within 100 units, snap pin to label
                if lab in labels_by_name:
                    nearest = min(labels_by_name[lab], key=lambda pt: (pt[0]-x)**2 + (pt[1]-y)**2)
                    dist = ((nearest[0]-x)**2 + (nearest[1]-y)**2)**0.5
                    if 0 < dist <= 100:
                        l = f"C {{{sym}}} {nearest[0]} {nearest[1]} {rot} {flip} {{{props}}}"
        new_lines.append(l)

    new_content = "\n".join(new_lines) + "\n"
    if new_content != content:
        with open(sch_path, "w") as f:
            f.write(new_content)
        print(f"[FIXED] Snapped pins in {sch_path}")

def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    prj_dir = os.path.dirname(script_dir)
    xschem_dir = os.path.join(prj_dir, "xschem")

    for sch in sorted(glob.glob(os.path.join(xschem_dir, "**", "*.sch"), recursive=True)):
        if "testbench" not in sch and "tb_" not in sch:
            fix_schematic(sch)

if __name__ == "__main__":
    main()
