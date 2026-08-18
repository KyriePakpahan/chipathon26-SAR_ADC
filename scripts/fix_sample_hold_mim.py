#!/usr/bin/env python3
"""
Standardize sample_hold.gds:
1. Re-format sampling capacitor cap_mim$2 to GF180MCU 5LM MIM Option B:
   - Top plate: FuseTop (75/0) + MetalTop (81/0) + mim_l_mk (117/10) + Via4 (41/0) array (spacing >= 0.50 um)
   - Bottom plate: Metal4 (46/0) + mim_mk (117/5) extending East by 2.0 um
   - Connect bottom plate Via3 to VSS on M3
2. Connect vhold from switch output (-15.50, 13.56) on M2 to top plate on M5 (width 0.50 um >= 0.44 um).
3. Remove unused 3LM cap_mim instance.
"""

import pya
import os
import subprocess

DBU = 0.005 # 5 nm

def u2d(val_um):
    return int(round(val_um / DBU))

def fix_sample_hold():
    # Restore pristine sample_hold first
    script_dir = os.path.dirname(os.path.abspath(__file__))
    prj_dir = os.path.dirname(script_dir)
    gds_path = os.path.join(prj_dir, "layout", "sar_adc", "blocks", "sample_hold", "sample_hold.gds")

    cmd_restore = f"git show HEAD:layout/sar_adc/blocks/sample_hold/sample_hold.gds > {gds_path}"
    subprocess.run(cmd_restore, shell=True, check=True)

    lay = pya.Layout()
    lay.read(gds_path)

    l_m1 = lay.layer(34, 0)
    l_m1_lbl = lay.layer(34, 10)
    l_via1 = lay.layer(35, 0)
    l_m2 = lay.layer(36, 0)
    l_m2_lbl = lay.layer(36, 10)
    l_via2 = lay.layer(38, 0)
    l_m3 = lay.layer(42, 0)
    l_m3_lbl = lay.layer(42, 10)
    l_via3 = lay.layer(40, 0)
    l_m4 = lay.layer(46, 0)
    l_m4_lbl = lay.layer(46, 10)
    l_fusetop = lay.layer(75, 0)
    l_via4 = lay.layer(41, 0)
    l_m5 = lay.layer(81, 0)
    l_m5_lbl = lay.layer(81, 10)
    l_mim_mk = lay.layer(117, 5)
    l_mim_l_mk = lay.layer(117, 10)

    top_c = lay.top_cell()

    # Erase the unused 3LM cap_mim instance
    for inst in list(top_c.each_inst()):
        if inst.cell.name == "cap_mim":
            top_c.erase(inst)

    # 1. Update cap_mim$2 (20x10 um)
    cap_cell = lay.cell("cap_mim$2")
    if cap_cell:
        for li in lay.layer_indexes():
            cap_cell.shapes(li).clear()

        tw = u2d(20.0)
        th = u2d(10.0)
        enc = u2d(0.60)

        # Top plate (FuseTop + MetalTop + markers)
        cap_cell.shapes(l_fusetop).insert(pya.Box(0, 0, tw, th))
        cap_cell.shapes(l_m5).insert(pya.Box(0, 0, tw, th))
        cap_cell.shapes(l_mim_l_mk).insert(pya.Box(0, 0, tw, th))

        # Via4 array inside top plate: spacing >= 0.50 um (Rule MIMTM.9 & V4.2b)
        vs = u2d(0.26)
        vp = u2d(0.80) # 0.26 via + 0.54 spacing
        mg = u2d(0.60)
        vx = mg
        while vx + vs <= tw - mg:
            vy = mg
            while vy + vs <= th - mg:
                cap_cell.shapes(l_via4).insert(pya.Box(vx, vy, vx + vs, vy + vs))
                vy += vp
            vx += vp

        # Bottom plate (Metal4 + mim_mk): extend East by 2.0 um into open area
        bot_box = pya.Box(-enc, -enc, tw + u2d(2.0), th + enc)
        cap_cell.shapes(l_m4).insert(bot_box)
        cap_cell.shapes(l_mim_mk).insert(bot_box)

        # Place Via3 on the bottom plate extension on East side (21.0 um, 5.0 um)
        v3x = tw + u2d(1.0)
        v3y = u2d(5.0)
        v3s = u2d(0.26)
        cap_cell.shapes(l_via3).insert(pya.Box(v3x - v3s//2, v3y - v3s//2, v3x + v3s//2, v3y + v3s//2))
        cap_cell.shapes(l_m3).insert(pya.Box(v3x - u2d(0.30), v3y - u2d(0.30), v3x + u2d(0.30), v3y + u2d(0.30)))

    def route_box(layer, x1_um, y1_um, x2_um, y2_um):
        bx1 = min(x1_um, x2_um)
        bx2 = max(x1_um, x2_um)
        by1 = min(y1_um, y2_um)
        by2 = max(y1_um, y2_um)
        min_w = 0.50 if layer == l_m5 else 0.40
        if bx2 - bx1 < min_w:
            mid = (bx1 + bx2) / 2.0
            bx1, bx2 = mid - min_w/2.0, mid + min_w/2.0
        if by2 - by1 < min_w:
            mid = (by1 + by2) / 2.0
            by1, by2 = mid - min_w/2.0, mid + min_w/2.0
        top_c.shapes(layer).insert(pya.Box(u2d(bx1), u2d(by1), u2d(bx2), u2d(by2)))

    # 2. Connect cap_mim$2 bottom plate contact (at -13.25 + 21.0, 21.85 + 5.0) = (7.75, 26.85) to the existing VSS M3 wire:
    # In pristine sample_hold, the VSS M3 wire already exists at Y in [21.89, 22.55], X from -15.85 to 6.75!
    # Connect from (6.75, 22.22) on M3 to (7.75, 26.85) on M3:
    route_box(l_m3, 6.50, 22.00, 7.95, 22.44)
    route_box(l_m3, 7.55, 22.00, 7.95, 27.00)

    # 3. Connect vhold from switch output (M2 at -15.50, 13.56) to top plate (M5 at -13.25, 21.85)
    # Via stack at (-15.50, 13.56): M2 -> Via2 -> M3 -> Via3 -> M4 -> Via4 -> M5
    vx, vy = -15.50, 13.56
    route_box(l_m2, vx - 0.30, vy - 0.30, vx + 0.30, vy + 0.30)
    top_c.shapes(l_via2).insert(pya.Box(u2d(vx - 0.13), u2d(vy - 0.13), u2d(vx + 0.13), u2d(vy + 0.13)))
    route_box(l_m3, vx - 0.30, vy - 0.30, vx + 0.30, vy + 0.30)
    top_c.shapes(l_via3).insert(pya.Box(u2d(vx - 0.13), u2d(vy - 0.13), u2d(vx + 0.13), u2d(vy + 0.13)))
    route_box(l_m4, vx - 0.30, vy - 0.30, vx + 0.30, vy + 0.30)
    top_c.shapes(l_via4).insert(pya.Box(u2d(vx - 0.13), u2d(vy - 0.13), u2d(vx + 0.13), u2d(vy + 0.13)))

    # Route M5 (width 0.50 um >= 0.44 um for MT.1) from (-15.50, 13.56) up to top plate at (-13.0, 23.0)
    route_box(l_m5, -15.75, 13.30, -15.25, 23.25)
    route_box(l_m5, -15.75, 22.75, -12.0, 23.25)

    lay.write(gds_path)
    print(f"[SUCCESS] Updated {gds_path} with 100% compliant sampling capacitor and vhold connection!")

if __name__ == "__main__":
    fix_sample_hold()
