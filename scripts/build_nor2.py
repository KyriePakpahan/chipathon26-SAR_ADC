import sys
import os
import types

sys.path.insert(0, '/foss/pdks/gf180mcuD/libs.tech/klayout/tech/pymacros')
from cells.layers_def import layer
import gdsfactory as gf

gf180 = types.ModuleType('gf180mcuD')
gf180.PDK = gf.Pdk(name='gf180mcuD')
sys.modules['gf180mcuD'] = gf180

import pya
from cells import gf180mcu

def snap_to_grid(layout, grid=5):
    for cell in layout.each_cell():
        for l_idx in layout.layer_indexes():
            shapes = cell.shapes(l_idx)
            new_boxes = []
            new_polygons = []
            new_texts = []
            for s in shapes.each():
                if s.is_box():
                    b = s.box
                    l = int(round(b.left / grid)) * grid
                    b_val = int(round(b.bottom / grid)) * grid
                    r = int(round(b.right / grid)) * grid
                    t = int(round(b.top / grid)) * grid
                    new_boxes.append(pya.Box(l, b_val, r, t))
                elif s.is_polygon():
                    pts = [pya.Point(int(round(p.x / grid)) * grid, int(round(p.y / grid)) * grid) for p in s.polygon.each_point()]
                    new_polygons.append(pya.Polygon(pts))
                elif s.is_text():
                    t = s.text
                    new_texts.append(pya.Text(t.string, int(round(t.x / grid)) * grid, int(round(t.y / grid)) * grid))
            shapes.clear()
            for b in new_boxes: shapes.insert(b)
            for poly in new_polygons: shapes.insert(poly)
            for txt in new_texts: shapes.insert(txt)

def build_nor2():
    lib = pya.Library.library_by_name("gf180mcu")
    if lib is None:
        lib = gf180mcu()

    pcell_decl_p = lib.layout().pcell_declaration('pfet')
    pcell_decl_n = lib.layout().pcell_declaration('nfet')

    def get_pcell_id(layout, decl, params):
        pv = [params.get(p.name, p.default) for p in decl.get_parameters()]
        return layout.add_pcell_variant(lib, decl.id(), pv)

    def extract_pins(cell, l_m1, has_bulk=True, is_pmos=True):
        m1_boxes = [s.box for s in cell.shapes(l_m1).each()]
        if is_pmos:
            gate_box = min(m1_boxes, key=lambda b: b.bottom)
        else:
            gate_box = max(m1_boxes, key=lambda b: b.top)
        
        sd_boxes = [b for b in m1_boxes if b != gate_box]
        sd_boxes.sort(key=lambda b: b.left)
        if has_bulk:
            return {
                'drain': sd_boxes[0],
                'source': sd_boxes[1],
                'bulk': sd_boxes[2],
                'gate': gate_box
            }
        else:
            return {
                'drain': sd_boxes[0],
                'source': sd_boxes[1],
                'bulk': None,
                'gate': gate_box
            }

    layout = pya.Layout()
    layout.dbu = 0.001
    top = layout.create_cell('async_nor2')

    l_nw = layout.layer(21, 0)
    l_m1 = layout.layer(34, 0)
    l_m1_lbl = layout.layer(34, 10)
    l_via1 = layout.layer(35, 0)
    l_m2 = layout.layer(36, 0)
    l_m2_lbl = layout.layer(36, 10)

    def add_box(layer, x1, y1, x2, y2):
        top.shapes(layer).insert(pya.Box(int(round(x1)), int(round(y1)), int(round(x2)), int(round(y2))))
    def add_label(layer, text, x, y):
        top.shapes(layer).insert(pya.Text(text, int(round(x)), int(round(y))))
        top.shapes(l_m1).insert(pya.Text(text, int(round(x)), int(round(y))))

    col_pitch = 6000
    pmos_y = 6000
    nmos_y = 0

    # 5 Columns:
    # Col 0: Inverter A (XM5 / XM6)
    # Col 1: Inverter B (XM5 / XM6)
    # Col 2: NAND2 Input A (XM3 / XM4)
    # Col 3: NAND2 Input B (XM1 / XM2)
    # Col 4: Inverter Y (XM5 / XM6)
    col_configs = [
        # (W_p, L_p, bulk_p, W_n, L_n, bulk_n)
        (0.80, 0.28, "Bulk Tie", 0.42, 0.28, "Bulk Tie"), # Col 0: Inv A
        (0.80, 0.28, "Bulk Tie", 0.42, 0.28, "Bulk Tie"), # Col 1: Inv B
        (1.00, 0.28, "Bulk Tie", 0.50, 0.28, "None"),     # Col 2: NAND A (M3 pfet / M4 nfet)
        (1.00, 0.28, "Bulk Tie", 0.50, 0.28, "Bulk Tie"), # Col 3: NAND B (M1 pfet / M2 nfet)
        (0.80, 0.28, "Bulk Tie", 0.42, 0.28, "Bulk Tie"), # Col 4: Inv Y
    ]

    total_w = len(col_configs) * col_pitch + 4000

    vdd_y1 = pmos_y + 2500
    vdd_y2 = pmos_y + 3500
    vss_y1 = nmos_y - 2500
    vss_y2 = nmos_y - 1500

    # N-Well
    add_box(l_nw, 0, pmos_y - 1500, total_w, vdd_y2 + 500)

    # Power rails
    add_box(l_m1, 0, vdd_y1, total_w, vdd_y2)
    add_label(l_m1_lbl, "VDD", total_w/2, vdd_y1 + 500)

    add_box(l_m1, 0, vss_y1, total_w, vss_y2)
    add_label(l_m1_lbl, "VSS", total_w/2, vss_y1 + 500)

    cols = []
    for i, (wp, lp, bp, wn, ln, bn) in enumerate(col_configs):
        xc = 3000 + i * col_pitch
        pid_p = get_pcell_id(layout, pcell_decl_p, {'volt': '3.3V', 'w_gate': wp, 'l_gate': lp, 'bulk': bp, 'gate_con_pos': 'bottom'})
        pid_n = get_pcell_id(layout, pcell_decl_n, {'volt': '3.3V', 'w_gate': wn, 'l_gate': ln, 'bulk': bn, 'gate_con_pos': 'top'})

        top.insert(pya.CellInstArray(pid_p, pya.Trans(xc, pmos_y)))
        top.insert(pya.CellInstArray(pid_n, pya.Trans(xc, nmos_y)))

        p_pins = extract_pins(layout.cell(pid_p), l_m1, bp == "Bulk Tie", True)
        n_pins = extract_pins(layout.cell(pid_n), l_m1, bn == "Bulk Tie", False)

        cols.append({
            'xc': xc,
            'p_drain': (xc + p_pins['drain'].center().x, pmos_y + p_pins['drain'].center().y),
            'p_source': (xc + p_pins['source'].center().x, pmos_y + p_pins['source'].center().y),
            'p_bulk': (xc + p_pins['bulk'].center().x, pmos_y + p_pins['bulk'].center().y) if p_pins['bulk'] else None,
            'p_gate': (xc + p_pins['gate'].center().x, pmos_y + p_pins['gate'].center().y),
            'n_drain': (xc + n_pins['drain'].center().x, nmos_y + n_pins['drain'].center().y),
            'n_source': (xc + n_pins['source'].center().x, nmos_y + n_pins['source'].center().y),
            'n_bulk': (xc + n_pins['bulk'].center().x, nmos_y + n_pins['bulk'].center().y) if n_pins['bulk'] else None,
            'n_gate': (xc + n_pins['gate'].center().x, nmos_y + n_pins['gate'].center().y),
        })

    # Bulk ties & Rail connections:
    # PMOS Sources & Bulks tied to VDD (all 5 columns)
    for c in cols:
        add_box(l_m1, c['p_source'][0] - 180, c['p_source'][1], c['p_source'][0] + 180, vdd_y2)
        if c['p_bulk']:
            add_box(l_m1, c['p_bulk'][0] - 180, c['p_bulk'][1], c['p_bulk'][0] + 180, vdd_y2)

    # NMOS Sources & Bulks tied to VSS (Cols 0, 1, 3, 4)
    for idx in [0, 1, 3, 4]:
        c = cols[idx]
        add_box(l_m1, c['n_source'][0] - 180, vss_y1, c['n_source'][0] + 180, c['n_source'][1])
        if c['n_bulk']:
            add_box(l_m1, c['n_bulk'][0] - 180, vss_y1, c['n_bulk'][0] + 180, c['n_bulk'][1])

    # NAND internal series connection: Col 2 NMOS Source to Col 3 NMOS Drain
    add_box(l_m1, cols[2]['n_source'][0] - 130, cols[2]['n_source'][1] - 130, cols[3]['n_drain'][0] + 130, cols[2]['n_source'][1] + 130)

    # Metal 2 Routing Tracks
    T_AB  = 2000
    T_BB  = 3000
    T_NET = 4000

    def connect_m1_to_m2(x, y_track):
        # M1 enclosure: 0.28 wide in X (x - 140 to x + 140), 0.38 in Y (y - 190 to y + 190)
        add_box(l_m1, x - 140, y_track - 190, x + 140, y_track + 190)
        # Via1: 0.26 x 0.26
        add_box(l_via1, x - 130, y_track - 130, x + 130, y_track + 130)
        # M2 enclosure: 0.38 wide in X (x - 190 to x + 190), 0.28 in Y (y - 140 to y + 140)
        add_box(l_m2, x - 190, y_track - 140, x + 190, y_track + 140)

    def route_m2_track(y_track, x_list):
        for x in x_list:
            connect_m1_to_m2(x, y_track)
        add_box(l_m2, min(x_list) - 190, y_track - 140, max(x_list) + 190, y_track + 140)

    c0, c1, c2, c3, c4 = cols

    # Connect PMOS and NMOS drains on Metal 1 for Inverter A (Col 0)
    add_box(l_m1, c0['p_drain'][0] - 140, c0['n_drain'][1], c0['p_drain'][0] + 140, c0['p_drain'][1])

    # Connect PMOS and NMOS drains on Metal 1 for Inverter B (Col 1)
    add_box(l_m1, c1['p_drain'][0] - 140, c1['n_drain'][1], c1['p_drain'][0] + 140, c1['p_drain'][1])

    # Connect PMOS and NMOS gates on Metal 1 for NAND Input A (Col 2)
    add_box(l_m1, c2['p_gate'][0] - 140, c2['n_gate'][1], c2['p_gate'][0] + 140, c2['p_gate'][1])

    # Connect PMOS and NMOS gates on Metal 1 for NAND Input B (Col 3)
    add_box(l_m1, c3['p_gate'][0] - 140, c3['n_gate'][1], c3['p_gate'][0] + 140, c3['p_gate'][1])

    # Connect PMOS and NMOS gates on Metal 1 for Inverter Y (Col 4)
    add_box(l_m1, c4['p_gate'][0] - 140, c4['n_gate'][1], c4['p_gate'][0] + 140, c4['p_gate'][1])

    # Connect Col 2 PMOS and NMOS drains on Metal 1
    add_box(l_m1, c2['p_drain'][0] - 140, c2['n_drain'][1], c2['p_drain'][0] + 140, c2['p_drain'][1])

    # Connect Col 3 PMOS drain down to T_NET on Metal 1
    add_box(l_m1, c3['p_drain'][0] - 140, T_NET - 190, c3['p_drain'][0] + 140, c3['p_drain'][1])

    # 1. Input A (Col 0 Gates)
    add_box(l_m1, c0['p_gate'][0] - 140, c0['n_gate'][1], c0['p_gate'][0] + 140, c0['p_gate'][1])
    add_label(l_m1_lbl, "A", c0['p_gate'][0], (pmos_y + nmos_y)/2)

    # 2. Input B (Col 1 Gates)
    add_box(l_m1, c1['p_gate'][0] - 140, c1['n_gate'][1], c1['p_gate'][0] + 140, c1['p_gate'][1])
    add_label(l_m1_lbl, "B", c1['p_gate'][0], (pmos_y + nmos_y)/2)

    # 3. Net A_b (Col 0 PMOS/NMOS Drains to Col 2 PMOS/NMOS Gates)
    route_m2_track(T_AB, [c0['p_drain'][0], c2['p_gate'][0]])

    # 4. Net B_b (Col 1 PMOS/NMOS Drains to Col 3 PMOS/NMOS Gates)
    route_m2_track(T_BB, [c1['p_drain'][0], c3['p_gate'][0]])

    # 5. Net net1 (Col 2 Drains, Col 3 PMOS Drain to Col 4 PMOS/NMOS Gates)
    route_m2_track(T_NET, [c2['p_drain'][0], c3['p_drain'][0], c4['p_gate'][0]])

    # 6. Output Y (Col 4 PMOS/NMOS Drains)
    add_box(l_m1, c4['p_drain'][0] - 140, c4['n_drain'][1], c4['p_drain'][0] + 140, c4['p_drain'][1])
    add_label(l_m1_lbl, "Y", c4['p_drain'][0], (pmos_y + nmos_y)/2)

    top.flatten(-1, True)
    snap_to_grid(layout, 5)

    opt = pya.SaveLayoutOptions()
    out_gds = "/foss/designs/chipathon26-SAR_ADC/layout/async_nor2.gds"
    layout.write(out_gds, opt)
    print(f"Generated {out_gds} successfully!")

if __name__ == '__main__':
    build_nor2()
