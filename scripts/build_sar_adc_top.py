#!/usr/bin/env python3
"""
Top-Level Layout Generator for SAR ADC (sar_adc_top.gds)
Assembles the constituent blocks (async_sar, strongarm_comp, sample_hold, and CDAC placeholder)
into a unified top-level cell 'sar_adc_top'.
"""

import os
import sys
import pya

def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    proj_root = os.path.dirname(script_dir) if os.path.basename(script_dir) == "scripts" else script_dir

    layout_dir = os.path.join(proj_root, "layout")
    sar_adc_blocks = os.path.join(layout_dir, "sar_adc", "blocks")

    async_sar_gds = os.path.join(sar_adc_blocks, "async_sar", "async_sar.gds")
    comp_gds = os.path.join(sar_adc_blocks, "comparator", "strongarm_comp.gds")
    sh_gds = os.path.join(sar_adc_blocks, "sample_hold", "sample_hold.gds")

    top_layout = pya.Layout()
    top_layout.dbu = 0.001  # 1 nm

    top_cell = top_layout.create_cell("sar_adc_top")

    # Layer mapping for GF180MCU
    # Metal1 (34/0), Metal2 (36/0), Metal3 (42/0), Metal4 (46/0), Metal5 (81/0)
    # Pin / Label layers (e.g. Metal1 label 34/10, Metal2 label 36/10, etc.)
    m1_layer = top_layout.layer(34, 0)
    m1_lbl = top_layout.layer(34, 10)
    m2_layer = top_layout.layer(36, 0)
    m2_lbl = top_layout.layer(36, 10)

    # 1. Load and place async_sar
    if os.path.exists(async_sar_gds):
        lay_sar = pya.Layout()
        lay_sar.read(async_sar_gds)
        sar_src_cell = lay_sar.top_cell()
        sar_cell = top_layout.create_cell(sar_src_cell.name)
        sar_cell.copy_tree(sar_src_cell)
        # Place at (0, 0)
        top_cell.insert(pya.CellInstArray(sar_cell.cell_index(), pya.Trans(0, 0)))
        print(f"[INFO] Loaded and placed '{sar_src_cell.name}' at (0, 0)")

    # 2. Load and place comparator
    if os.path.exists(comp_gds):
        lay_comp = pya.Layout()
        lay_comp.read(comp_gds)
        comp_src_cell = lay_comp.top_cell()
        comp_cell = top_layout.create_cell(comp_src_cell.name)
        comp_cell.copy_tree(comp_src_cell)
        # Place above logic or at offset
        top_cell.insert(pya.CellInstArray(comp_cell.cell_index(), pya.Trans(pya.Point(0, 160000))))
        print(f"[INFO] Loaded and placed '{comp_src_cell.name}' at (0, 160 um)")

    # 3. Load and place sample_hold
    if os.path.exists(sh_gds):
        lay_sh = pya.Layout()
        lay_sh.read(sh_gds)
        sh_src_cell = lay_sh.top_cell()
        sh_cell = top_layout.create_cell(sh_src_cell.name)
        sh_cell.copy_tree(sh_src_cell)
        # Place next to comparator
        top_cell.insert(pya.CellInstArray(sh_cell.cell_index(), pya.Trans(pya.Point(200000, 160000))))
        print(f"[INFO] Loaded and placed '{sh_src_cell.name}' at (200 um, 160 um)")

    # 4. CDAC placeholder cell
    cdac_cell = top_layout.create_cell("cdac_8bit")
    # Draw placeholder boundary on metal1
    cdac_box = pya.Box(0, 0, 300000, 150000) # 300 x 150 um
    cdac_cell.shapes(m1_layer).insert(cdac_box)
    cdac_cell.shapes(m1_lbl).insert(pya.Text("CDAC_8BIT_PLACEHOLDER", pya.Trans(pya.Point(50000, 75000))))
    top_cell.insert(pya.CellInstArray(cdac_cell.cell_index(), pya.Trans(pya.Point(450000, 160000))))
    print(f"[INFO] Created CDAC placeholder cell 'cdac_8bit' at (450 um, 160 um)")

    # 5. Add Top-Level Pin Labels
    pins = [
        ("vin", 200000, 160000),
        ("vref", 450000, 160000),
        ("start", 0, 0),
        ("vdd", 0, 140000),
        ("vss", 0, -10000),
        ("done", 850000, 0),
        ("dout[7]", 850000, 20000),
        ("dout[6]", 850000, 30000),
        ("dout[5]", 850000, 40000),
        ("dout[4]", 850000, 50000),
        ("dout[3]", 850000, 60000),
        ("dout[2]", 850000, 70000),
        ("dout[1]", 850000, 80000),
        ("dout[0]", 850000, 90000),
    ]
    for pin_name, px, py in pins:
        top_cell.shapes(m2_lbl).insert(pya.Text(pin_name, pya.Trans(pya.Point(px, py))))
        top_cell.shapes(m2_layer).insert(pya.Box(px, py, px + 2000, py + 2000))

    # Save to both layout/sar_adc_top.gds and layout/sar_adc/sar_adc_top.gds
    out_path_root = os.path.join(layout_dir, "sar_adc_top.gds")
    out_path_sub = os.path.join(layout_dir, "sar_adc", "sar_adc_top.gds")

    top_layout.write(out_path_root)
    top_layout.write(out_path_sub)

    print(f"[SUCCESS] Top-level layout generated at:")
    print(f"  -> {out_path_root}")
    print(f"  -> {out_path_sub}")

if __name__ == "__main__":
    main()
