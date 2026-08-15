import pya
import os
import subprocess

def generate_bulk_tie_inverter():
    layout = pya.Layout()
    layout.dbu = 0.001
    top = layout.create_cell("async_inverter")

    l_nwell   = layout.layer(21, 0)
    l_comp    = layout.layer(22, 0)
    l_poly2   = layout.layer(30, 0)
    l_pplus   = layout.layer(31, 0)
    l_nplus   = layout.layer(32, 0)
    l_contact = layout.layer(33, 0)
    l_m1      = layout.layer(34, 0)
    l_m1_lbl  = layout.layer(34, 10)

    def db(v): return int(round(v * 1000.0))
    def add_box(layer, x1, y1, x2, y2):
        top.shapes(layer).insert(pya.Box(db(min(x1, x2)), db(min(y1, y2)), db(max(x1, x2)), db(max(y1, y2))))
    def add_label(layer, text, x, y):
        top.shapes(layer).insert(pya.Text(text, db(x), db(y)))

    cell_w = 4.8
    vss_y_bot = -1.6
    vss_y_top = -0.8
    vdd_y_bot = 7.4
    vdd_y_top = 8.2

    # N-well across top PMOS region
    add_box(l_nwell, -0.6, 2.7, cell_w + 0.6, 8.5)

    # Power rails (M1)
    add_box(l_m1, -0.5, vdd_y_bot, cell_w + 0.5, vdd_y_top)
    add_label(l_m1_lbl, "VDD", cell_w/2.0, 7.8)

    add_box(l_m1, -0.5, vss_y_bot, cell_w + 0.5, vss_y_top)
    add_label(l_m1_lbl, "VSS", cell_w/2.0, -1.2)

    # 1. PMOS Bulk Tie (N+ Well Tap) along VDD rail
    add_box(l_comp, 0.4, 6.0, 1.2, 7.0)
    add_box(l_nplus, 0.2, 5.8, 1.4, 7.2)
    add_box(l_contact, 0.69, 6.39, 0.91, 6.61)
    add_box(l_m1, 0.64, 6.30, 0.96, vdd_y_top)

    # 2. NMOS Bulk Tie (P+ Substrate Tap) along VSS rail
    add_box(l_comp, 0.4, -0.4, 1.2, 0.6)
    add_box(l_pplus, 0.2, -0.6, 1.4, 0.8)
    add_box(l_contact, 0.69, -0.01, 0.91, 0.21)
    add_box(l_m1, 0.64, vss_y_bot, 0.96, 0.30)

    # 3. PMOS Transistor: W=0.80um, L=0.28um at x=3.0, y=5.6
    p_xc = 3.0
    p_w = 0.80
    p_l = 0.28
    p_yb = 5.6
    p_ext = 0.95
    p_cw = p_l + 2 * p_ext
    add_box(l_comp, p_xc - p_cw/2.0, p_yb, p_xc + p_cw/2.0, p_yb + p_w)
    add_box(l_pplus, p_xc - p_cw/2.0 - 0.20, p_yb - 0.20, p_xc + p_cw/2.0 + 0.20, p_yb + p_w + 0.20)
    add_box(l_poly2, p_xc - p_l/2.0, p_yb - 0.30, p_xc + p_l/2.0, p_yb + p_w + 0.30)

    # PMOS Gate pad (bottom)
    add_box(l_poly2, p_xc - 0.18, p_yb - 0.80, p_xc + 0.18, p_yb - 0.30)
    add_box(l_contact, p_xc - 0.11, p_yb - 0.70, p_xc + 0.11, p_yb - 0.48)
    add_box(l_m1, p_xc - 0.13, p_yb - 0.76, p_xc + 0.13, p_yb - 0.42)

    # PMOS Source (left) -> VDD
    ps_x = p_xc - p_l/2.0 - p_ext/2.0
    ps_y = p_yb + p_w/2.0
    add_box(l_contact, ps_x - 0.11, ps_y - 0.11, ps_x + 0.11, ps_y + 0.11)
    add_box(l_m1, ps_x - 0.13, ps_y - 0.13, ps_x + 0.13, vdd_y_top)

    # PMOS Drain (right) -> out
    pd_x = p_xc + p_l/2.0 + p_ext/2.0
    pd_y = p_yb + p_w/2.0
    add_box(l_contact, pd_x - 0.11, pd_y - 0.11, pd_x + 0.11, pd_y + 0.11)

    # 4. NMOS Transistor: W=0.42um, L=0.28um at x=3.0, y=-0.2
    n_xc = 3.0
    n_w = 0.42
    n_l = 0.28
    n_yb = -0.2
    n_ext = 0.95
    n_cw = n_l + 2 * n_ext
    add_box(l_comp, n_xc - n_cw/2.0, n_yb, n_xc + n_cw/2.0, n_yb + n_w)
    add_box(l_nplus, n_xc - n_cw/2.0 - 0.20, n_yb - 0.20, n_xc + n_cw/2.0 + 0.20, n_yb + n_w + 0.20)
    add_box(l_poly2, n_xc - n_l/2.0, n_yb - 0.30, n_xc + n_l/2.0, n_yb + n_w + 0.30)

    # NMOS Gate pad (top)
    add_box(l_poly2, n_xc - 0.18, n_yb + n_w + 0.30, n_xc + 0.18, n_yb + n_w + 0.80)
    add_box(l_contact, n_xc - 0.11, n_yb + n_w + 0.40, n_xc + 0.11, n_yb + n_w + 0.62)
    add_box(l_m1, n_xc - 0.13, n_yb + n_w + 0.34, n_xc + 0.13, n_yb + n_w + 0.68)

    # NMOS Source (left) -> VSS
    ns_x = n_xc - n_l/2.0 - n_ext/2.0
    ns_y = n_yb + n_w/2.0
    add_box(l_contact, ns_x - 0.11, ns_y - 0.11, ns_x + 0.11, ns_y + 0.11)
    add_box(l_m1, ns_x - 0.13, vss_y_bot, ns_x + 0.13, ns_y + 0.13)

    # NMOS Drain (right) -> out
    nd_x = n_xc + n_l/2.0 + n_ext/2.0
    nd_y = n_yb + n_w/2.0
    add_box(l_contact, nd_x - 0.11, nd_y - 0.11, nd_x + 0.11, nd_y + 0.11)

    # 5. Routing:
    # Common Gate (input): Connect NMOS Gate pad (y=0.5) to PMOS Gate pad (y=5.0)
    add_box(l_m1, n_xc - 0.13, n_yb + n_w + 0.40, n_xc + 0.13, p_yb - 0.50)
    add_label(l_m1_lbl, "input", n_xc, 2.70)

    # Common Drain (out): Connect NMOS Drain to PMOS Drain
    add_box(l_m1, pd_x - 0.13, nd_y - 0.13, pd_x + 0.13, pd_y + 0.13)
    add_label(l_m1_lbl, "out", pd_x, 2.70)

    out_gds = "/foss/designs/chipathon26-SAR_ADC/layout/async_inverter.gds"
    layout.write(out_gds)
    print(f"Generated bulk-tie async_inverter.gds at {out_gds}")

generate_bulk_tie_inverter()
