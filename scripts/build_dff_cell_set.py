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

def build_dff_cell_set():
    lib = pya.Library.library_by_name("gf180mcu")
    if lib is None:
        lib = gf180mcu()

    pcell_decl_p = lib.layout().pcell_declaration('pfet')
    pcell_decl_n = lib.layout().pcell_declaration('nfet')

    def get_pcell_id(layout, decl, params):
        pv = [params.get(p.name, p.default) for p in decl.get_parameters()]
        return layout.add_pcell_variant(lib, decl.id(), pv)

    def snap(val, g=10):
        return int(round(val / g)) * g

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
    top = layout.create_cell('dff_cell_set')

    l_nw = layout.layer(21, 0)
    l_m1 = layout.layer(34, 0)
    l_m1_lbl = layout.layer(34, 10)
    l_via1 = layout.layer(35, 0)
    l_m2 = layout.layer(36, 0)
    l_m2_lbl = layout.layer(36, 10)

    def add_box(layer, x1, y1, x2, y2):
        top.shapes(layer).insert(pya.Box(snap(x1), snap(y1), snap(x2), snap(y2)))

    def add_label_m1(text, x, y):
        top.shapes(l_m1_lbl).insert(pya.Text(text, snap(x), snap(y)))
        top.shapes(l_m1).insert(pya.Text(text, snap(x), snap(y)))

    def add_label_m2(text, x, y):
        top.shapes(l_m2_lbl).insert(pya.Text(text, snap(x), snap(y)))
        top.shapes(l_m2).insert(pya.Text(text, snap(x), snap(y)))

    col_configs = [
        # Col 0: x_inv_d (XM5 / XM6: 0.80u / 0.42u, Bulk Tie)
        (0.80, 0.28, 'Bulk Tie', 0.42, 0.28, 'Bulk Tie'),
        # Col 1 (dff col 0: XM1 / XM2)
        (1.00, 0.28, 'Bulk Tie', 0.50, 0.28, 'Bulk Tie'),
        # Col 2 (dff col 1: XM19 / XM20)
        (1.00, 0.28, 'Bulk Tie', 0.50, 0.28, 'Bulk Tie'),
        # Col 3 (dff col 2: XM3 / XM4)
        (1.00, 0.28, 'None',     0.50, 0.28, 'None'),
        # Col 4 (dff col 3: XM5 / XM6)
        (1.00, 0.28, 'Bulk Tie', 0.50, 0.28, 'Bulk Tie'),
        # Col 5 (dff col 4: XM7 / XM8)
        (0.42, 2.00, 'Bulk Tie', 0.42, 2.40, 'Bulk Tie'),
        # Col 6 (dff col 5: XM9 / XM10)
        (1.00, 0.28, 'None',     0.50, 0.28, 'None'),
        # Col 7 (dff col 6: XM11 / XM13)
        (1.00, 0.28, 'Bulk Tie', 0.50, 0.28, 'None'),
        # Col 8 (dff col 7: XM12 / XM14)
        (1.00, 0.28, 'Bulk Tie', 0.50, 0.28, 'Bulk Tie'),
        # Col 9 (dff col 8: XM15 / XM16)
        (1.00, 0.28, 'Bulk Tie', 0.50, 0.28, 'Bulk Tie'),
        # Col 10 (dff col 9: XM17 / XM18)
        (0.42, 2.00, 'Bulk Tie', 0.42, 2.40, 'Bulk Tie'),
        # Col 11: x_inv_q (XM5 / XM6: 0.80u / 0.42u, Bulk Tie)
        (0.80, 0.28, 'Bulk Tie', 0.42, 0.28, 'Bulk Tie'),
    ]

    col_pitch = 6000
    pmos_row_y = 7800
    nmos_row_y = 0
    total_w = len(col_configs) * col_pitch + 4000

    vdd_y1 = pmos_row_y + 2500
    vdd_y2 = pmos_row_y + 3500
    vss_y1 = nmos_row_y - 2500
    vss_y2 = nmos_row_y - 1500

    add_box(l_nw, 0, pmos_row_y - 1500, total_w, vdd_y2 + 500)
    add_box(l_m1, 0, vdd_y1, total_w, vdd_y2)
    add_label_m1('VDD', total_w/2, vdd_y1 + 500)
    add_box(l_m1, 0, vss_y1, total_w, vss_y2)
    add_label_m1('VSS', total_w/2, vss_y1 + 500)

    cols = []
    for i, (wp, lp, bp, wn, ln, bn) in enumerate(col_configs):
        xc = 3000 + i * col_pitch
        pid_p = get_pcell_id(layout, pcell_decl_p, {'volt': '3.3V', 'w_gate': wp, 'l_gate': lp, 'bulk': bp, 'gate_con_pos': 'bottom'})
        pid_n = get_pcell_id(layout, pcell_decl_n, {'volt': '3.3V', 'w_gate': wn, 'l_gate': ln, 'bulk': bn, 'gate_con_pos': 'top'})

        top.insert(pya.CellInstArray(pid_p, pya.Trans(xc, pmos_row_y)))
        top.insert(pya.CellInstArray(pid_n, pya.Trans(xc, nmos_row_y)))

        p_pins = extract_pins(layout.cell(pid_p), l_m1, bp == 'Bulk Tie', True)
        n_pins = extract_pins(layout.cell(pid_n), l_m1, bn == 'Bulk Tie', False)

        cols.append({
            'xc': xc,
            'bp': bp,
            'bn': bn,
            'p_drain': (xc + snap(p_pins['drain'].center().x), pmos_row_y + snap(p_pins['drain'].center().y)),
            'p_source': (xc + snap(p_pins['source'].center().x), pmos_row_y + snap(p_pins['source'].center().y)),
            'p_bulk': (xc + snap(p_pins['bulk'].center().x), pmos_row_y + snap(p_pins['bulk'].center().y)) if p_pins['bulk'] else None,
            'p_gate': (xc + snap(p_pins['gate'].center().x), pmos_row_y + snap(p_pins['gate'].center().y)),
            'n_drain': (xc + snap(n_pins['drain'].center().x), nmos_row_y + snap(n_pins['drain'].center().y)),
            'n_source': (xc + snap(n_pins['source'].center().x), nmos_row_y + snap(n_pins['source'].center().y)),
            'n_bulk': (xc + snap(n_pins['bulk'].center().x), nmos_row_y + snap(n_pins['bulk'].center().y)) if n_pins['bulk'] else None,
            'n_gate': (xc + snap(n_pins['gate'].center().x), nmos_row_y + snap(n_pins['gate'].center().y)),
        })

    # Bulks & Rails
    for c in cols:
        if c['p_bulk']:
            add_box(l_m1, c['p_bulk'][0] - 120, c['p_bulk'][1], c['p_bulk'][0] + 120, vdd_y2)
        if c['n_bulk']:
            add_box(l_m1, c['n_bulk'][0] - 120, vss_y1, c['n_bulk'][0] + 120, c['n_bulk'][1])

    # PMOS sources to VDD: 0, 1, 2, 4, 5, 7, 8, 9, 10, 11
    for idx in [0, 1, 2, 4, 5, 7, 8, 9, 10, 11]:
        c = cols[idx]
        add_box(l_m1, c['p_source'][0] - 120, c['p_source'][1], c['p_source'][0] + 120, vdd_y2)

    # NMOS sources to VSS: 0, 1, 2, 4, 5, 8, 9, 10, 11
    for idx in [0, 1, 2, 4, 5, 8, 9, 10, 11]:
        c = cols[idx]
        add_box(l_m1, c['n_source'][0] - 120, vss_y1, c['n_source'][0] + 120, c['n_source'][1])

    # Track pitch = 700nm
    T_NET1 = 200
    T_CLK  = 1000
    T_CLKN = 1700
    T_DB   = 2400
    T_DINT = 3100
    T_M    = 3800
    T_MBAR = 4500
    T_S    = 5200
    T_QBAR = 5900
    T_QINT = 6600

    def connect_pin_to_m2(x_pin, y_pin, y_track):
        add_box(l_m1, x_pin - 120, min(y_pin, y_track), x_pin + 120, max(y_pin, y_track))
        add_box(l_m1, x_pin - 190, y_track - 190, x_pin + 190, y_track + 190)
        add_box(l_via1, x_pin - 130, y_track - 130, x_pin + 130, y_track + 130)
        add_box(l_m2, x_pin - 190, y_track - 190, x_pin + 190, y_track + 190)
        return x_pin

    def connect_col_drains_to_m2(c, y_track):
        xd = snap((c['p_drain'][0] + c['n_drain'][0]) / 2.0)
        add_box(l_m1, xd - 120, c['n_drain'][1], xd + 120, c['p_drain'][1])
        add_box(l_m1, xd - 190, y_track - 190, xd + 190, y_track + 190)
        add_box(l_via1, xd - 130, y_track - 130, xd + 130, y_track + 130)
        add_box(l_m2, xd - 190, y_track - 190, xd + 190, y_track + 190)
        return xd

    def connect_col_gates_to_m2(c, y_track):
        xg = snap((c['p_gate'][0] + c['n_gate'][0]) / 2.0)
        add_box(l_m1, xg - 120, c['n_gate'][1], xg + 120, c['p_gate'][1])
        add_box(l_m1, xg - 190, y_track - 190, xg + 190, y_track + 190)
        add_box(l_via1, xg - 130, y_track - 130, xg + 130, y_track + 130)
        add_box(l_m2, xg - 190, y_track - 190, xg + 190, y_track + 190)
        return xg

    def connect_col_sources_to_m2(c, y_track):
        xs = snap((c['p_source'][0] + c['n_source'][0]) / 2.0)
        add_box(l_m1, xs - 120, c['n_source'][1], xs + 120, c['p_source'][1])
        add_box(l_m1, xs - 190, y_track - 190, xs + 190, y_track + 190)
        add_box(l_via1, xs - 130, y_track - 130, xs + 130, y_track + 130)
        add_box(l_m2, xs - 190, y_track - 190, xs + 190, y_track + 190)
        return xs

    def route_m2(y_track, x_list):
        add_box(l_m2, min(x_list) - 190, y_track - 140, max(x_list) + 190, y_track + 140)

    # 1. NET: D (Col 0 Gates)
    xg0 = snap((cols[0]['p_gate'][0] + cols[0]['n_gate'][0]) / 2.0)
    add_box(l_m1, xg0 - 120, cols[0]['n_gate'][1], xg0 + 120, cols[0]['p_gate'][1])
    add_label_m1('D', xg0, (pmos_row_y + nmos_row_y)/2)

    # 2. NET: D_b (Col 0 Drains to Col 2 Gates)
    xd0 = connect_col_drains_to_m2(cols[0], T_DB)
    xg2 = connect_col_gates_to_m2(cols[2], T_DB)
    route_m2(T_DB, [xd0, xg2])

    # 3. NET: clk (Col 1 Gates, Col 3 NMOS gate, Col 6 PMOS gate via M1 stem to y=2500 and M2 corridor)
    p6_gate_x = cols[6]['p_gate'][0]
    p6_gate_y = cols[6]['p_gate'][1]
    jog_x = p6_gate_x + 2000
    Y_BRIDGE = 2500
    # M1 stem straight down between drain and source to y=2500
    add_box(l_m1, p6_gate_x - 120, Y_BRIDGE, p6_gate_x + 120, p6_gate_y)
    # Via1 at (p6_gate_x, Y_BRIDGE)
    add_box(l_m1, p6_gate_x - 190, Y_BRIDGE - 190, p6_gate_x + 190, Y_BRIDGE + 190)
    add_box(l_via1, p6_gate_x - 130, Y_BRIDGE - 130, p6_gate_x + 130, Y_BRIDGE + 130)
    add_box(l_m2, p6_gate_x - 190, Y_BRIDGE - 190, p6_gate_x + 190, Y_BRIDGE + 190)
    # M2 horizontal bridge at y=2500 to corridor
    add_box(l_m2, p6_gate_x - 140, Y_BRIDGE - 140, jog_x + 140, Y_BRIDGE + 140)
    # M2 vertical stem in corridor down to T_CLK
    add_box(l_m2, jog_x - 140, T_CLK - 140, jog_x + 140, Y_BRIDGE + 140)

    xg1 = connect_col_gates_to_m2(cols[1], T_CLK)
    xg3_n = connect_pin_to_m2(cols[3]['n_gate'][0], cols[3]['n_gate'][1], T_CLK)
    route_m2(T_CLK, [xg1, xg3_n, jog_x])
    add_label_m1('clk', xg1, T_CLK)

    # 4. NET: clk_n (Col 1 Drains, Col 3 PMOS gate, Col 6 NMOS gate)
    xd1 = connect_col_drains_to_m2(cols[1], T_CLKN)
    xg3_p = connect_pin_to_m2(cols[3]['p_gate'][0], cols[3]['p_gate'][1], T_CLKN)
    xg6_n = connect_pin_to_m2(cols[6]['n_gate'][0], cols[6]['n_gate'][1], T_CLKN)
    route_m2(T_CLKN, [xd1, xg3_p, xg6_n])

    # 5. NET: D_int (Col 2 Drains, Col 3 Sources)
    xd2 = connect_col_drains_to_m2(cols[2], T_DINT)
    xs3 = connect_col_sources_to_m2(cols[3], T_DINT)
    route_m2(T_DINT, [xd2, xs3])

    # 6. NET: M (Col 3 Drains, Col 4 Gates, Col 5 Drains)
    xd3 = connect_col_drains_to_m2(cols[3], T_M)
    xg4 = connect_col_gates_to_m2(cols[4], T_M)
    xd5 = connect_col_drains_to_m2(cols[5], T_M)
    route_m2(T_M, [xd3, xg4, xd5])

    # 7. NET: M_bar (Col 4 Drains, Col 5 Gates, Col 6 Sources)
    xd4 = connect_col_drains_to_m2(cols[4], T_MBAR)
    xg5 = connect_col_gates_to_m2(cols[5], T_MBAR)
    xs6 = connect_col_sources_to_m2(cols[6], T_MBAR)
    route_m2(T_MBAR, [xd4, xg5, xs6])

    # 8. NET: S (Col 6 Drains, Col 7 PMOS gate, Col 7 NMOS gate, Col 10 Drains)
    xd6 = connect_col_drains_to_m2(cols[6], T_S)
    xg7_p = connect_pin_to_m2(cols[7]['p_gate'][0], cols[7]['p_gate'][1], T_S)
    xg7_n = connect_pin_to_m2(cols[7]['n_gate'][0], cols[7]['n_gate'][1], T_S)
    xd10 = connect_col_drains_to_m2(cols[10], T_S)
    route_m2(T_S, [xd6, xg7_p, xg7_n, xd10])

    # 9. NET: net1 (Col 7 NMOS source to Col 8 NMOS drain)
    xs7_n = connect_pin_to_m2(cols[7]['n_source'][0], cols[7]['n_source'][1], T_NET1)
    xd8_n = connect_pin_to_m2(cols[8]['n_drain'][0], cols[8]['n_drain'][1], T_NET1)
    route_m2(T_NET1, [xs7_n, xd8_n])

    # 10. NET: rst_n (Col 8 Gates)
    xg8_p = connect_pin_to_m2(cols[8]['p_gate'][0], cols[8]['p_gate'][1], (pmos_row_y + nmos_row_y)/2)
    xg8_n = connect_pin_to_m2(cols[8]['n_gate'][0], cols[8]['n_gate'][1], (pmos_row_y + nmos_row_y)/2)
    route_m2((pmos_row_y + nmos_row_y)/2, [xg8_p, xg8_n])
    add_label_m1('rst_n', xg8_p, (pmos_row_y + nmos_row_y)/2)

    # 11. NET: Q_bar (Col 7 drains, Col 8 PMOS drain, Col 9 Gates, Col 10 Gates)
    xd7 = connect_col_drains_to_m2(cols[7], T_QBAR)
    xd8_p = connect_pin_to_m2(cols[8]['p_drain'][0], cols[8]['p_drain'][1], T_QBAR)
    xg9 = connect_col_gates_to_m2(cols[9], T_QBAR)
    xg10 = connect_col_gates_to_m2(cols[10], T_QBAR)
    route_m2(T_QBAR, [xd7, xd8_p, xg9, xg10])

    # 12. NET: Q_int (Col 9 Drains to Col 11 Inverter Gates)
    xd9 = connect_col_drains_to_m2(cols[9], T_QINT)
    xg11 = connect_col_gates_to_m2(cols[11], T_QINT)
    route_m2(T_QINT, [xd9, xg11])

    # 13. NET: Q (Col 11 Inverter Drains)
    xd11 = snap((cols[11]['p_drain'][0] + cols[11]['n_drain'][0]) / 2.0)
    add_box(l_m1, xd11 - 120, cols[11]['n_drain'][1], xd11 + 120, cols[11]['p_drain'][1])
    add_label_m1('Q', xd11, (pmos_row_y + nmos_row_y)/2)

    # Flatten top cell
    top.flatten(-1, True)

    # Snap all shapes to 5nm grid
    grid = 5
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

    out_gds = "/foss/designs/chipathon26-SAR_ADC/layout/dff_cell_set.gds"
    layout.write(out_gds)
    print(f"Generated clean {out_gds} successfully!")

if __name__ == '__main__':
    build_dff_cell_set()
