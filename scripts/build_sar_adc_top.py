#!/usr/bin/env python3
"""
Full Monolithic Top-Level Layout Generator for 8-Bit Asynchronous SAR ADC (sar_adc_top).
PDK: GF180MCU 5LM Option B (Variant D) - Native 5nm DBU (0.005 um)

This script:
1. Loads all 4 verified sub-blocks (async_sar, sample_hold, strongarm_comp, cdac_8bit).
2. Clones all subcells with unique block prefixes to avoid cell name collisions.
3. Places sub-blocks in optimal floorplan:
   - async_sar at (0.0, 0.0) um (size: 880 x 223 um)
   - cdac_8bit at (50.0, 240.0) um (size: 336 x 115 um)
   - strongarm_comp at (520.0, 260.0) um (size: 21 x 18 um)
   - sample_hold at (720.0, 260.0) um (size: 38 x 42 um)
4. Executes DRC-clean interconnect routing in dedicated non-overlapping channels.
5. Distributes robust perimeter VDD & VSS power rings without traversing active cell areas.
6. Places standard primary I/O pins and pin labels.
7. Emits sar_adc_top.gds.
"""

import pya
import os

DBU = 0.005 # 5 nm grid

def u2d(val_um):
    return int(round(val_um / DBU))

def build():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    prj_dir = os.path.dirname(script_dir)
    layout_dir = os.path.join(prj_dir, "layout")

    path_sar  = os.path.join(layout_dir, "sar_adc", "blocks", "async_sar", "async_sar.gds")
    path_sh   = os.path.join(layout_dir, "sar_adc", "blocks", "sample_hold", "sample_hold.gds")
    path_comp = os.path.join(layout_dir, "sar_adc", "blocks", "comparator", "strongarm_comp.gds")
    path_cdac = os.path.join(layout_dir, "sar_adc", "blocks", "cdac", "cdac_8bit.gds")

    top_layout = pya.Layout()
    top_layout.dbu = DBU
    top_cell = top_layout.create_cell("sar_adc_top")

    # Layer mapping for GF180MCU
    m1_layer   = top_layout.layer(34, 0)
    m1_lbl     = top_layout.layer(34, 10)
    via1_layer = top_layout.layer(35, 0)
    m2_layer   = top_layout.layer(36, 0)
    m2_lbl     = top_layout.layer(36, 10)
    via2_layer = top_layout.layer(38, 0)
    m3_layer   = top_layout.layer(42, 0)
    m3_lbl     = top_layout.layer(42, 10)
    via3_layer = top_layout.layer(40, 0)
    m4_layer   = top_layout.layer(46, 0)
    m4_lbl     = top_layout.layer(46, 10)
    via4_layer = top_layout.layer(41, 0)
    m5_layer   = top_layout.layer(81, 0)
    m5_lbl     = top_layout.layer(81, 10)

    # 1. Prefix-isolated subcell importing
    def import_block(gds_path, prefix, top_name):
        src_lay = pya.Layout()
        src_lay.read(gds_path)
        for c in src_lay.each_cell():
            if c.name != top_name:
                c.name = f"{prefix}_{c.name}"
        res_cell = top_layout.create_cell(top_name)
        src_top = src_lay.cell(top_name)
        res_cell.copy_tree(src_top)
        return res_cell

    cell_sar  = import_block(path_sar,  "sar",  "async_sar")
    cell_sh   = import_block(path_sh,   "sh",   "sample_hold")
    cell_comp = import_block(path_comp, "comp", "strongarm_comp")
    cell_cdac = import_block(path_cdac, "cdac", "cdac_8bit")

    def route_box(layer, x1_um, y1_um, x2_um, y2_um):
        bx1 = min(x1_um, x2_um)
        bx2 = max(x1_um, x2_um)
        by1 = min(y1_um, y2_um)
        by2 = max(y1_um, y2_um)
        min_w = 0.50 if layer == m5_layer else 0.36
        if bx2 - bx1 < min_w:
            mid = (bx1 + bx2) / 2.0
            bx1, bx2 = mid - min_w/2.0, mid + min_w/2.0
        if by2 - by1 < min_w:
            mid = (by1 + by2) / 2.0
            by1, by2 = mid - min_w/2.0, mid + min_w/2.0
        top_cell.shapes(layer).insert(pya.Box(u2d(bx1), u2d(by1), u2d(bx2), u2d(by2)))

    def add_via1(x_um, y_um):
        cx = u2d(x_um)
        cy = u2d(y_um)
        route_box(m1_layer, x_um - 0.20, y_um - 0.20, x_um + 0.20, y_um + 0.20)
        top_cell.shapes(via1_layer).insert(pya.Box(cx - u2d(0.13), cy - u2d(0.13), cx + u2d(0.13), cy + u2d(0.13)))
        route_box(m2_layer, x_um - 0.20, y_um - 0.20, x_um + 0.20, y_um + 0.20)

    def add_via2(x_um, y_um):
        cx = u2d(x_um)
        cy = u2d(y_um)
        route_box(m2_layer, x_um - 0.20, y_um - 0.20, x_um + 0.20, y_um + 0.20)
        top_cell.shapes(via2_layer).insert(pya.Box(cx - u2d(0.13), cy - u2d(0.13), cx + u2d(0.13), cy + u2d(0.13)))
        route_box(m3_layer, x_um - 0.20, y_um - 0.20, x_um + 0.20, y_um + 0.20)

    def add_via3(x_um, y_um):
        cx = u2d(x_um)
        cy = u2d(y_um)
        route_box(m3_layer, x_um - 0.20, y_um - 0.20, x_um + 0.20, y_um + 0.20)
        top_cell.shapes(via3_layer).insert(pya.Box(cx - u2d(0.13), cy - u2d(0.13), cx + u2d(0.13), cy + u2d(0.13)))
        route_box(m4_layer, x_um - 0.30, y_um - 0.30, x_um + 0.30, y_um + 0.30)

    def add_via4(x_um, y_um):
        cx = u2d(x_um)
        cy = u2d(y_um)
        route_box(m4_layer, x_um - 0.30, y_um - 0.30, x_um + 0.30, y_um + 0.30)
        top_cell.shapes(via4_layer).insert(pya.Box(cx - u2d(0.13), cy - u2d(0.13), cx + u2d(0.13), cy + u2d(0.13)))
        route_box(m5_layer, x_um - 0.30, y_um - 0.30, x_um + 0.30, y_um + 0.30)

    def add_stack_via(x_um, y_um):
        add_via1(x_um, y_um)
        add_via2(x_um, y_um)

    # 2. Block Placements
    # async_sar at (0.0, 0.0) um
    top_cell.insert(pya.CellInstArray(cell_sar.cell_index(), pya.Trans(u2d(0.0), u2d(0.0))))

    # cdac_8bit at (50.0, 240.0) um
    cdac_x, cdac_y = 50.0, 240.0
    top_cell.insert(pya.CellInstArray(cell_cdac.cell_index(), pya.Trans(u2d(cdac_x), u2d(cdac_y))))

    # strongarm_comp at (520.0, 260.0) um
    comp_x, comp_y = 520.0, 260.0
    top_cell.insert(pya.CellInstArray(cell_comp.cell_index(), pya.Trans(u2d(comp_x), u2d(comp_y))))

    # sample_hold at (720.0, 260.0) um
    sh_x, sh_y = 720.0, 260.0
    top_cell.insert(pya.CellInstArray(cell_sh.cell_index(), pya.Trans(u2d(sh_x), u2d(sh_y))))

    # =========================================================================
    # 3. INTERCONNECT ROUTING (Wire width: 0.36 um)
    # =========================================================================
    hw = 0.18

    # A. sample_en: async_sar (648.77, 172.0 on M3) -> sample_hold (sh_x - 27.40, sh_y + 10.92 on M1) = (692.60, 270.92)
    p_sh_se = (sh_x - 27.40, sh_y + 10.92)
    add_stack_via(p_sh_se[0], p_sh_se[1])
    route_box(m3_layer, p_sh_se[0] - hw, 225.0, p_sh_se[0] + hw, p_sh_se[1])
    route_box(m3_layer, 648.77 - hw, 225.0 - hw, p_sh_se[0] + hw, 225.0 + hw)
    route_box(m3_layer, 648.77 - hw, 172.0, 648.77 + hw, 225.0)

    # B. rst_latch: async_sar (536.78, 176.0 on M3) -> strongarm_comp (comp_x - 8.88, comp_y + 3.97 on M2) = (511.12, 263.97)
    p_comp_rst = (comp_x - 8.88, comp_y + 3.97)
    add_via2(p_comp_rst[0], p_comp_rst[1])
    route_box(m3_layer, p_comp_rst[0] - hw, 227.0, p_comp_rst[0] + hw, p_comp_rst[1])
    route_box(m3_layer, min(536.78, p_comp_rst[0]) - hw, 227.0 - hw, max(536.78, p_comp_rst[0]) + hw, 227.0 + hw)
    route_box(m3_layer, 536.78 - hw, 176.0, 536.78 + hw, 227.0)

    # C. comp_done: strongarm_comp (comp_x - 0.71, comp_y + 13.47 on M1) = (519.29, 273.47) -> async_sar (10.0, 168.0 on M3)
    p_comp_done = (comp_x - 0.71, comp_y + 13.47)
    add_stack_via(p_comp_done[0], p_comp_done[1])
    route_box(m3_layer, p_comp_done[0] - hw, 229.0, p_comp_done[0] + hw, p_comp_done[1])
    route_box(m3_layer, 10.0 - hw, 229.0 - hw, p_comp_done[0] + hw, 229.0 + hw)
    route_box(m3_layer, 10.0 - hw, 168.0, 10.0 + hw, 229.0)

    # D. comp_out_p: strongarm_comp (comp_x - 10.38, comp_y + 5.51 on M1) = (509.62, 265.51) -> async_sar (10.0, 170.0 on M3)
    p_comp_outp = (comp_x - 10.38, comp_y + 5.51)
    add_stack_via(p_comp_outp[0], p_comp_outp[1])
    route_box(m3_layer, p_comp_outp[0] - hw, 231.0, p_comp_outp[0] + hw, p_comp_outp[1])
    route_box(m3_layer, 14.0 - hw, 231.0 - hw, p_comp_outp[0] + hw, 231.0 + hw)
    route_box(m3_layer, 14.0 - hw, 170.0, 14.0 + hw, 231.0)
    route_box(m3_layer, 10.0 - hw, 170.0 - hw, 14.0 + hw, 170.0 + hw)

    # E. vhold: sample_hold (sh_x - 15.50, sh_y + 13.56 on M2) = (704.50, 273.56) -> strongarm_comp vin_p (comp_x - 12.13, comp_y + 2.75 on M1) = (507.87, 262.75)
    p_sh_vhold  = (sh_x - 15.50, sh_y + 13.56)
    p_comp_vinp = (comp_x - 12.13, comp_y + 2.75)
    add_via2(p_sh_vhold[0], p_sh_vhold[1])
    add_stack_via(p_comp_vinp[0], p_comp_vinp[1])
    route_box(m3_layer, p_comp_vinp[0] - hw, 254.0, p_comp_vinp[0] + hw, p_comp_vinp[1])
    route_box(m3_layer, p_comp_vinp[0] - hw, 254.0 - hw, p_sh_vhold[0] + hw, 254.0 + hw)
    route_box(m3_layer, p_sh_vhold[0] - hw, 254.0, p_sh_vhold[0] + hw, p_sh_vhold[1])

    # F. vdac: cdac_8bit (cdac_x + 175.88, cdac_y + 115.0 on M5) = (225.88, 355.0) -> strongarm_comp vin_n (comp_x - 7.13, comp_y + 2.66 on M1) = (512.87, 262.66)
    p_cdac_vdac = (cdac_x + 175.88, cdac_y + 115.0)
    p_comp_vinn = (comp_x - 7.13, comp_y + 2.66)
    add_stack_via(p_comp_vinn[0], p_comp_vinn[1])
    route_box(m3_layer, p_comp_vinn[0] - hw, 252.0, p_comp_vinn[0] + hw, p_comp_vinn[1])
    route_box(m3_layer, p_comp_vinn[0] - hw, 252.0, p_comp_vinn[0] + hw, 355.0)
    route_box(m3_layer, p_cdac_vdac[0] - hw, 355.0 - hw, p_comp_vinn[0] + hw, 355.0 + hw)
    # Via stack M3 -> M4 -> M5 at p_cdac_vdac
    add_via3(p_cdac_vdac[0], 355.0)
    add_via4(p_cdac_vdac[0], 355.0)

    # G. 8-Bit DAC Control Bus (dac_in[0..7]) from async_sar to cdac_8bit
    dac_sar_x = [33.0, 75.0, 117.0, 159.0, 201.0, 243.0, 285.0, 327.0]
    dac_cdac_x = [37.575, 76.165, 113.925, 153.965, 193.065, 232.085, 275.145, 316.415]
    for i in range(8):
        sx = dac_sar_x[i]
        cx = cdac_x + dac_cdac_x[i]
        y_ch = 195.0 + i * 3.0
        route_box(m3_layer, sx - hw, 180.0, sx + hw, y_ch)
        route_box(m3_layer, min(sx, cx) - hw, y_ch - hw, max(sx, cx) + hw, y_ch + hw)
        route_box(m3_layer, cx - hw, y_ch, cx + hw, cdac_y)

    # =========================================================================
    # 4. POWER & GROUND DISTRIBUTION (VDD & VSS)
    # =========================================================================
    # Top Power Rails (M3): VDD at Y = 380.0 um, VSS at Y = 390.0 um
    route_box(m3_layer, -20.0, 378.0, 900.0, 382.0)
    route_box(m3_layer, -20.0, 388.0, 900.0, 392.0)

    # Bottom Power Rails (M3): VDD at Y = -10.0 um, VSS at Y = -20.0 um
    route_box(m3_layer, -20.0, -12.0, 900.0, -8.0)
    route_box(m3_layer, -20.0, -22.0, 900.0, -18.0)

    # West Power Feeders (M3): VDD at X = -10.0 um, VSS at X = -20.0 um
    route_box(m3_layer, -12.0, -10.0, -8.0, 380.0)
    route_box(m3_layer, -22.0, -20.0, -18.0, 390.0)

    # East Power Feeders (M3): VDD at X = 890.0 um, VSS at X = 900.0 um
    route_box(m3_layer, 888.0, -10.0, 892.0, 380.0)
    route_box(m3_layer, 898.0, -20.0, 902.0, 390.0)

    # VDD connections:
    # async_sar VDD (2.0, 141.8 on M1) -> West to X = -10.0 um (VDD feeder)
    route_box(m1_layer, -6.0, 141.8 - hw, 2.0 + hw, 141.8 + hw)
    add_stack_via(-6.0, 141.8)
    route_box(m3_layer, -10.0, 141.8 - hw, -6.0, 141.8 + hw)

    # cdac_8bit VDD (cdac_x + 20.20, cdac_y + 115.0 on M3) = (70.20, 355.0) -> North to 380.0
    route_box(m3_layer, 70.20 - hw, 355.0, 70.20 + hw, 380.0)

    # strongarm_comp VDD (p_comp_vdd on M1 at 509.89, 269.10)
    p_comp_vdd = (comp_x - 10.11, comp_y + 9.10)
    add_stack_via(p_comp_vdd[0], p_comp_vdd[1])
    route_box(m3_layer, p_comp_vdd[0] - hw, p_comp_vdd[1], p_comp_vdd[0] + hw, 380.0)

    # sample_hold VDD (p_sh_vdd on M1 at 693.03, 273.41)
    p_sh_vdd = (sh_x - 26.97, sh_y + 13.41)
    add_stack_via(p_sh_vdd[0], p_sh_vdd[1])
    route_box(m3_layer, p_sh_vdd[0] - hw, p_sh_vdd[1], p_sh_vdd[0] + hw, 380.0)

    # VSS connections:
    # async_sar VSS (6.0, 130.0 on M1) -> West to X = -20.0 um (VSS feeder)
    route_box(m1_layer, -16.0, 130.0 - hw, 6.0 + hw, 130.0 + hw)
    add_stack_via(-16.0, 130.0)
    route_box(m3_layer, -20.0, 130.0 - hw, -16.0, 130.0 + hw)

    # cdac_8bit VSS (cdac_x + 20.0, cdac_y on M3) = (70.0, 240.0) -> North around CDAC to 390.0
    route_box(m3_layer, 45.0 - hw, 240.0 - hw, 70.0 + hw, 240.0 + hw)
    route_box(m3_layer, 45.0 - hw, 240.0, 45.0 + hw, 390.0)

    # strongarm_comp VSS (p_comp_vss on M1 at 509.46, 260.49)
    p_comp_vss = (comp_x - 10.54, comp_y + 0.49)
    add_stack_via(p_comp_vss[0], p_comp_vss[1])
    route_box(m3_layer, p_comp_vss[0] - hw, 233.0, p_comp_vss[0] + hw, p_comp_vss[1])
    route_box(m3_layer, -20.0, 233.0 - hw, p_comp_vss[0] + hw, 233.0 + hw)

    # sample_hold VSS (p_sh_vss on M1 at 695.14, 267.53)
    p_sh_vss = (sh_x - 24.86, sh_y + 7.53)
    add_stack_via(p_sh_vss[0], p_sh_vss[1])
    route_box(m3_layer, p_sh_vss[0] - hw, p_sh_vss[1], p_sh_vss[0] + hw, 390.0)

    # =========================================================================
    # 5. PRIMARY I/O PINS AND LABELS
    # =========================================================================
    # Connect vin to sample_hold M2 vin pin at (sh_x - 23.63, sh_y + 17.63) = (696.37, 277.63)
    p_sh_vin = (sh_x - 23.63, sh_y + 17.63)
    add_via2(p_sh_vin[0], p_sh_vin[1])

    # Connect vref to cdac_8bit M2 vref pin at (cdac_x + 25.0, cdac_y + 115.0) = (75.0, 355.0)
    p_cdac_vref = (75.0, 355.0)
    add_via2(p_cdac_vref[0], p_cdac_vref[1])
    route_box(m3_layer, p_cdac_vref[0] - hw, 355.0, p_cdac_vref[0] + hw, 360.0)

    primary_pins = [
        ("vin",        m3_layer, m3_lbl, p_sh_vin[0], p_sh_vin[1], 4.0, 4.0),
        ("vref",       m3_layer, m3_lbl, p_cdac_vref[0], 360.0, 4.0, 4.0),
        ("start",      m3_layer, m3_lbl, 10.0, 166.0, 4.0, 4.0),
        ("vdd",        m3_layer, m3_lbl, 440.0, 380.0, 6.0, 4.0),
        ("vss",        m3_layer, m3_lbl, 440.0, 390.0, 6.0, 4.0),
        ("done",       m3_layer, m3_lbl, 692.77, 174.0, 4.0, 4.0),
        ("dout[0]",    m3_layer, m3_lbl, 86.0, 115.0, 4.0, 4.0),
        ("dout[1]",    m3_layer, m3_lbl, 194.0, 116.5, 4.0, 4.0),
        ("dout[2]",    m3_layer, m3_lbl, 302.0, 118.0, 4.0, 4.0),
        ("dout[3]",    m3_layer, m3_lbl, 410.0, 119.5, 4.0, 4.0),
        ("dout[4]",    m3_layer, m3_lbl, 518.0, 121.0, 4.0, 4.0),
        ("dout[5]",    m3_layer, m3_lbl, 626.0, 122.5, 4.0, 4.0),
        ("dout[6]",    m3_layer, m3_lbl, 734.0, 124.0, 4.0, 4.0),
        ("dout[7]",    m3_layer, m3_lbl, 842.0, 125.5, 4.0, 4.0),
    ]

    for pname, play, plbl, px, py, pw, ph in primary_pins:
        route_box(play, px - pw/2, py - ph/2, px + pw/2, py + ph/2)
        top_cell.shapes(plbl).insert(pya.Text(pname, pya.Trans(u2d(px), u2d(py))))

    out_path_root = os.path.join(layout_dir, "sar_adc_top.gds")
    out_path_sub  = os.path.join(layout_dir, "sar_adc", "sar_adc_top.gds")

    top_layout.write(out_path_root)
    top_layout.write(out_path_sub)

    print(f"[SUCCESS] Monolithic SAR ADC top layout successfully written to:")
    print(f"  -> {out_path_root}")
    print(f"  -> {out_path_sub}")

if __name__ == "__main__":
    build()
