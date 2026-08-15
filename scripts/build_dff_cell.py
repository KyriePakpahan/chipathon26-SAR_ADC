import sys, os
import pya

def create_dff_layout():
    layout = pya.Layout()
    layout.dbu = 0.001 # 1nm
    top = layout.create_cell("dff_cell")

    # Layer definitions for GF180MCU
    l_nwell   = layout.layer(21, 0)
    l_comp    = layout.layer(22, 0)
    l_poly2   = layout.layer(30, 0)
    l_pplus   = layout.layer(31, 0)
    l_nplus   = layout.layer(32, 0)
    l_contact = layout.layer(33, 0)
    l_m1      = layout.layer(34, 0)
    l_m1_lbl  = layout.layer(34, 10)
    l_via1    = layout.layer(35, 0)
    l_m2      = layout.layer(36, 0)
    l_m2_lbl  = layout.layer(36, 10)

    def db(val):
        return int(round(val * 1000.0))

    # Cell coordinates
    cell_y_bot = -1.25
    cell_y_top = 6.20
    vss_bot = -1.25
    vss_top = -0.45
    vdd_bot = 5.40
    vdd_top = 6.20

    # We will build standard building blocks:
    # 1. PMOS transistor helper
    # 2. NMOS transistor helper
    # 3. Tap helper

    def add_nmos(x_center, y_bot, w, l, s_net, d_net, g_net):
        """ Draws an isolated NMOS transistor at x_center, y_bot with width w and length l. """
        # Active diffusion
        diff_ext = 0.40 # source/drain extension
        comp_w = l + 2 * diff_ext
        comp_h = w
        comp_l = x_center - comp_w/2.0
        comp_r = x_center + comp_w/2.0
        comp_b = y_bot
        comp_t = y_bot + comp_h

        top.shapes(l_comp).insert(pya.Box(db(comp_l), db(comp_b), db(comp_r), db(comp_t)))
        top.shapes(l_nplus).insert(pya.Box(db(comp_l - 0.20), db(comp_b - 0.20), db(comp_r + 0.20), db(comp_t + 0.20)))

        # Poly gate
        poly_ext = 0.30
        poly_l = x_center - l/2.0
        poly_r = x_center + l/2.0
        poly_b = comp_b - poly_ext
        poly_t = comp_t + poly_ext
        top.shapes(l_poly2).insert(pya.Box(db(poly_l), db(poly_b), db(poly_r), db(poly_t)))

        # Poly contact pad at top or bottom
        poly_pad_y = poly_t + 0.30
        top.shapes(l_poly2).insert(pya.Box(db(x_center - 0.20), db(poly_t), db(x_center + 0.20), db(poly_pad_y)))
        # Poly contact
        top.shapes(l_contact).insert(pya.Box(db(x_center - 0.11), db(poly_pad_y - 0.26), db(x_center + 0.11), db(poly_pad_y - 0.04)))
        top.shapes(l_m1).insert(pya.Box(db(x_center - 0.19), db(poly_pad_y - 0.34), db(x_center + 0.19), db(poly_pad_y + 0.04)))

        # Source / Drain contacts
        # Left contact (Source)
        cnt_s_x = (comp_l + poly_l)/2.0
        top.shapes(l_contact).insert(pya.Box(db(cnt_s_x - 0.11), db(y_bot + w/2.0 - 0.11), db(cnt_s_x + 0.11), db(y_bot + w/2.0 + 0.11)))
        top.shapes(l_m1).insert(pya.Box(db(cnt_s_x - 0.19), db(y_bot + w/2.0 - 0.19), db(cnt_s_x + 0.19), db(y_bot + w/2.0 + 0.19)))

        # Right contact (Drain)
        cnt_d_x = (poly_r + comp_r)/2.0
        top.shapes(l_contact).insert(pya.Box(db(cnt_d_x - 0.11), db(y_bot + w/2.0 - 0.11), db(cnt_d_x + 0.11), db(y_bot + w/2.0 + 0.11)))
        top.shapes(l_m1).insert(pya.Box(db(cnt_d_x - 0.19), db(y_bot + w/2.0 - 0.19), db(cnt_d_x + 0.19), db(y_bot + w/2.0 + 0.19)))

        return {
            'gate_pad': (x_center, poly_pad_y - 0.15),
            'source_pad': (cnt_s_x, y_bot + w/2.0),
            'drain_pad': (cnt_d_x, y_bot + w/2.0),
            'bbox': (comp_l - 0.20, comp_b - 0.30, comp_r + 0.20, poly_pad_y + 0.04)
        }

    def add_pmos(x_center, y_bot, w, l, s_net, d_net, g_net):
        """ Draws an isolated PMOS transistor at x_center, y_bot with width w and length l. """
        diff_ext = 0.40
        comp_w = l + 2 * diff_ext
        comp_h = w
        comp_l = x_center - comp_w/2.0
        comp_r = x_center + comp_w/2.0
        comp_b = y_bot
        comp_t = y_bot + comp_h

        top.shapes(l_comp).insert(pya.Box(db(comp_l), db(comp_b), db(comp_r), db(comp_t)))
        top.shapes(l_pplus).insert(pya.Box(db(comp_l - 0.20), db(comp_b - 0.20), db(comp_r + 0.20), db(comp_t + 0.20)))

        # Poly gate
        poly_ext = 0.30
        poly_l = x_center - l/2.0
        poly_r = x_center + l/2.0
        poly_b = comp_b - poly_ext
        poly_t = comp_t + poly_ext
        top.shapes(l_poly2).insert(pya.Box(db(poly_l), db(poly_b), db(poly_r), db(poly_t)))

        # Poly contact pad at bottom
        poly_pad_y = poly_b - 0.30
        top.shapes(l_poly2).insert(pya.Box(db(x_center - 0.20), db(poly_pad_y), db(x_center + 0.20), db(poly_b)))
        # Poly contact
        top.shapes(l_contact).insert(pya.Box(db(x_center - 0.11), db(poly_pad_y + 0.04), db(x_center + 0.11), db(poly_pad_y + 0.26)))
        top.shapes(l_m1).insert(pya.Box(db(x_center - 0.19), db(poly_pad_y - 0.04), db(x_center + 0.19), db(poly_pad_y + 0.34)))

        # Source / Drain contacts
        # Left contact (Source)
        cnt_s_x = (comp_l + poly_l)/2.0
        top.shapes(l_contact).insert(pya.Box(db(cnt_s_x - 0.11), db(y_bot + w/2.0 - 0.11), db(cnt_s_x + 0.11), db(y_bot + w/2.0 + 0.11)))
        top.shapes(l_m1).insert(pya.Box(db(cnt_s_x - 0.19), db(y_bot + w/2.0 - 0.19), db(cnt_s_x + 0.19), db(y_bot + w/2.0 + 0.19)))

        # Right contact (Drain)
        cnt_d_x = (poly_r + comp_r)/2.0
        top.shapes(l_contact).insert(pya.Box(db(cnt_d_x - 0.11), db(y_bot + w/2.0 - 0.11), db(cnt_d_x + 0.11), db(y_bot + w/2.0 + 0.11)))
        top.shapes(l_m1).insert(pya.Box(db(cnt_d_x - 0.19), db(y_bot + w/2.0 - 0.19), db(cnt_d_x + 0.19), db(y_bot + w/2.0 + 0.19)))

        return {
            'gate_pad': (x_center, poly_pad_y + 0.15),
            'source_pad': (cnt_s_x, y_bot + w/2.0),
            'drain_pad': (cnt_d_x, y_bot + w/2.0),
            'bbox': (comp_l - 0.20, poly_pad_y - 0.04, comp_r + 0.20, comp_t + 0.30)
        }

    print("Helper functions ready")

create_dff_layout()
