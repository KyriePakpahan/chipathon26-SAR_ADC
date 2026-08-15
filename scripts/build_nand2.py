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

def build_nand2():
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
    top = layout.create_cell('async_nand2')

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

    col_pitch = 6000
    pmos_y = 6000
    nmos_y = 0
    total_w = 2 * col_pitch + 4000

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
    configs = [
        (1.0, 0.28, "Bulk Tie", 0.5, 0.28, "None"),     # Col 0: input_A (M3 pfet / M4 nfet)
        (1.0, 0.28, "Bulk Tie", 0.5, 0.28, "Bulk Tie"), # Col 1: input_B (M1 pfet / M2 nfet)
    ]

    for i, (wp, lp, bp, wn, ln, bn) in enumerate(configs):
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
    # PMOS Sources & Bulks tied to VDD (both Col 0 and Col 1)
    for c in cols:
        add_box(l_m1, c['p_source'][0] - 180, c['p_source'][1], c['p_source'][0] + 180, vdd_y2)
        if c['p_bulk']:
            add_box(l_m1, c['p_bulk'][0] - 180, c['p_bulk'][1], c['p_bulk'][0] + 180, vdd_y2)

    # Col 1 NMOS Source & Bulk tied to VSS
    c0 = cols[0]
    c1 = cols[1]
    add_box(l_m1, c1['n_source'][0] - 180, vss_y1, c1['n_source'][0] + 180, c1['n_source'][1])
    add_box(l_m1, c1['n_bulk'][0] - 180, vss_y1, c1['n_bulk'][0] + 180, c1['n_bulk'][1])

    # Internal node: net1 (Col 0 NMOS Source to Col 1 NMOS Drain)
    add_box(l_m1, c0['n_source'][0] - 130, c0['n_source'][1] - 130, c1['n_drain'][0] + 130, c0['n_source'][1] + 130)

    # Output node: (Col 0 PMOS Drain, Col 1 PMOS Drain, Col 0 NMOS Drain)
    # Route output on M2 track at Y = 3000
    T_OUT = 3000
    def connect_m1_to_m2(x, y1, y2):
        add_box(l_m1, x - 130, min(y1, y2), x + 130, max(y1, y2))
        add_box(l_m1, x - 140, y2 - 140, x + 140, y2 + 140)
        add_box(l_via1, x - 130, y2 - 130, x + 130, y2 + 130)
        add_box(l_m2, x - 160, y2 - 140, x + 160, y2 + 140)

    connect_m1_to_m2(c0['p_drain'][0], c0['p_drain'][1], T_OUT)
    connect_m1_to_m2(c1['p_drain'][0], c1['p_drain'][1], T_OUT)
    connect_m1_to_m2(c0['n_drain'][0], c0['n_drain'][1], T_OUT)
    add_box(l_m2, c0['p_drain'][0] - 160, T_OUT - 140, c1['p_drain'][0] + 160, T_OUT + 140)
    add_label(l_m1_lbl, "output", c0['p_drain'][0], T_OUT)

    # Input_A (Col 0 Gates)
    add_box(l_m1, c0['p_gate'][0] - 130, c0['n_gate'][1], c0['p_gate'][0] + 130, c0['p_gate'][1])
    add_label(l_m1_lbl, "input_A", c0['p_gate'][0], (pmos_y + nmos_y)/2)

    # Input_B (Col 1 Gates)
    add_box(l_m1, c1['p_gate'][0] - 130, c1['n_gate'][1], c1['p_gate'][0] + 130, c1['p_gate'][1])
    add_label(l_m1_lbl, "input_B", c1['p_gate'][0], (pmos_y + nmos_y)/2)

    opt = pya.SaveLayoutOptions()
    out_gds = "/foss/designs/chipathon26-SAR_ADC/layout/async_nand2.gds"
    layout.write(out_gds, opt)
    print(f"Generated {out_gds} successfully!")

build_nand2()
