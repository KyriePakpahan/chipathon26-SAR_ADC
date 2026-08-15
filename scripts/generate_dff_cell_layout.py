import sys, os
import pya

def generate_dff_cell():
    layout = pya.Layout()
    layout.dbu = 0.001 # 1 nm
    top = layout.create_cell("dff_cell")

    # Layer mapping for GF180MCU
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

    def db(v):
        return int(round(v * 1000.0))

    def add_box(layer, x1, y1, x2, y2):
        top.shapes(layer).insert(pya.Box(db(min(x1, x2)), db(min(y1, y2)), db(max(x1, x2)), db(max(y1, y2))))

    def add_label(layer, text, x, y):
        top.shapes(layer).insert(pya.Text(text, db(x), db(y)))

    # Global Dimensions
    cell_x_left  = -0.50
    cell_x_right = 36.50
    vss_y_bot    = -1.25
    vss_y_top    = -0.45
    vdd_y_bot    = 6.50
    vdd_y_top    = 7.30

    # N-well spans full width across top PMOS region
    add_box(l_nwell, cell_x_left - 0.50, 3.80, cell_x_right + 0.50, 7.50)

    # Power Rails
    # VDD Rail
    add_box(l_m1, cell_x_left, vdd_y_bot, cell_x_right, vdd_y_top)
    add_label(l_m1_lbl, "VDD", (cell_x_left + cell_x_right)/2.0, 6.90)

    # VSS / 0 Rail
    add_box(l_m1, cell_x_left, vss_y_bot, cell_x_right, vss_y_top)
    add_label(l_m1_lbl, "0", (cell_x_left + cell_x_right)/2.0, -0.85)

    # Tap helper
    def add_tap(x_center):
        # VDD Tap (N+ in Nwell)
        add_box(l_comp, x_center - 0.35, 5.1, x_center + 0.35, 6.1)
        add_box(l_nplus, x_center - 0.55, 4.9, x_center + 0.55, 6.3)
        add_box(l_contact, x_center - 0.11, 5.49, x_center + 0.11, 5.71)
        add_box(l_m1, x_center - 0.18, 5.40, x_center + 0.18, vdd_y_top)

        # VSS Tap (P+ in Substrate)
        add_box(l_comp, x_center - 0.35, 0.0, x_center + 0.35, 0.5)
        add_box(l_pplus, x_center - 0.55, -0.2, x_center + 0.55, 0.7)
        add_box(l_contact, x_center - 0.11, 0.14, x_center + 0.11, 0.36)
        add_box(l_m1, x_center - 0.18, vss_y_bot, x_center + 0.18, 0.45)

    add_tap(0.60)
    add_tap(35.50)

    # Transistor generator primitives
    def draw_pmos(x_c, w=1.0, l=0.28, y_bot=5.1):
        diff_ext = 0.55
        comp_w = l + 2 * diff_ext
        comp_l = x_c - comp_w/2.0
        comp_r = x_c + comp_w/2.0
        comp_b = y_bot
        comp_t = y_bot + w
        add_box(l_comp, comp_l, comp_b, comp_r, comp_t)
        add_box(l_pplus, comp_l - 0.20, comp_b - 0.20, comp_r + 0.20, comp_t + 0.20)

        poly_l = x_c - l/2.0
        poly_r = x_c + l/2.0
        add_box(l_poly2, poly_l, comp_b - 0.30, poly_r, comp_t + 0.30)

        # Poly contact pad at bottom (Y = 4.30 .. 4.80)
        pad_b = comp_b - 0.80
        pad_t = comp_b - 0.30
        add_box(l_poly2, x_c - 0.18, pad_b, x_c + 0.18, pad_t)
        add_box(l_contact, x_c - 0.11, pad_b + 0.10, x_c + 0.11, pad_b + 0.32)
        add_box(l_m1, x_c - 0.15, pad_b + 0.04, x_c + 0.15, pad_b + 0.38)

        # Source contact (left)
        s_x = x_c - l/2.0 - diff_ext/2.0
        s_y = comp_b + w/2.0
        add_box(l_contact, s_x - 0.11, s_y - 0.11, s_x + 0.11, s_y + 0.11)
        add_box(l_m1, s_x - 0.15, s_y - 0.15, s_x + 0.15, s_y + 0.15)

        # Drain contact (right)
        d_x = x_c + l/2.0 + diff_ext/2.0
        d_y = comp_b + w/2.0
        add_box(l_contact, d_x - 0.11, d_y - 0.11, d_x + 0.11, d_y + 0.11)
        add_box(l_m1, d_x - 0.15, d_y - 0.15, d_x + 0.15, d_y + 0.15)

        return {
            'gate': (x_c, pad_b + 0.21),
            'source': (s_x, s_y),
            'drain': (d_x, d_y),
            'top': comp_t,
            'bot': pad_b
        }

    def draw_nmos(x_c, w=0.5, l=0.28, y_bot=0.0):
        diff_ext = 0.55
        comp_w = l + 2 * diff_ext
        comp_l = x_c - comp_w/2.0
        comp_r = x_c + comp_w/2.0
        comp_b = y_bot
        comp_t = y_bot + w
        add_box(l_comp, comp_l, comp_b, comp_r, comp_t)
        add_box(l_nplus, comp_l - 0.20, comp_b - 0.20, comp_r + 0.20, comp_t + 0.20)

        poly_l = x_c - l/2.0
        poly_r = x_c + l/2.0
        add_box(l_poly2, poly_l, comp_b - 0.30, poly_r, comp_t + 0.30)

        # Poly contact pad at top (Y = 0.80 .. 1.30)
        pad_b = comp_t + 0.30
        pad_t = comp_t + 0.80
        add_box(l_poly2, x_c - 0.18, pad_b, x_c + 0.18, pad_t)
        add_box(l_contact, x_c - 0.11, pad_b + 0.10, x_c + 0.11, pad_b + 0.32)
        add_box(l_m1, x_c - 0.15, pad_b + 0.04, x_c + 0.15, pad_b + 0.38)

        # Source contact (left)
        s_x = x_c - l/2.0 - diff_ext/2.0
        s_y = comp_b + w/2.0
        add_box(l_contact, s_x - 0.11, s_y - 0.11, s_x + 0.11, s_y + 0.11)
        add_box(l_m1, s_x - 0.15, s_y - 0.15, s_x + 0.15, s_y + 0.15)

        # Drain contact (right)
        d_x = x_c + l/2.0 + diff_ext/2.0
        d_y = comp_b + w/2.0
        add_box(l_contact, d_x - 0.11, d_y - 0.11, d_x + 0.11, d_y + 0.11)
        add_box(l_m1, d_x - 0.15, d_y - 0.15, d_x + 0.15, d_y + 0.15)

        return {
            'gate': (x_c, pad_b + 0.21),
            'source': (s_x, s_y),
            'drain': (d_x, d_y),
            'top': pad_t,
            'bot': comp_b
        }

    # Transistor instantiations with adequate pitch
    p_m1  = draw_pmos(2.2, w=1.0, l=0.28)
    n_m2  = draw_nmos(2.2, w=0.5, l=0.28)

    p_m19 = draw_pmos(5.0, w=1.0, l=0.28)
    n_m20 = draw_nmos(5.0, w=0.5, l=0.28)

    p_m3  = draw_pmos(7.8, w=1.0, l=0.28)
    n_m4  = draw_nmos(7.8, w=0.5, l=0.28)

    p_m5  = draw_pmos(10.6, w=1.0, l=0.28)
    n_m6  = draw_nmos(10.6, w=0.5, l=0.28)

    p_m7  = draw_pmos(14.0, w=0.30, l=2.00, y_bot=5.1)
    n_m8  = draw_nmos(14.0, w=0.22, l=2.40, y_bot=0.0)

    p_m9  = draw_pmos(18.0, w=1.0, l=0.28)
    n_m10 = draw_nmos(18.0, w=0.5, l=0.28)

    p_m11 = draw_pmos(21.0, w=1.0, l=0.28)
    p_m12 = draw_pmos(23.8, w=1.0, l=0.28)
    n_m13 = draw_nmos(21.0, w=0.5, l=0.28)
    n_m14 = draw_nmos(23.8, w=0.5, l=0.28)

    p_m15 = draw_pmos(26.6, w=1.0, l=0.28)
    n_m16 = draw_nmos(26.6, w=0.5, l=0.28)

    p_m17 = draw_pmos(30.0, w=0.30, l=2.00, y_bot=5.1)
    n_m18 = draw_nmos(30.0, w=0.22, l=2.40, y_bot=0.0)

    # 1. Connect VDD to Sources: M1, M19, M5, M7, M11, M12, M15, M17
    for p in [p_m1, p_m19, p_m5, p_m7, p_m11, p_m12, p_m15, p_m17]:
        sx, sy = p['source']
        add_box(l_m1, sx - 0.14, sy, sx + 0.14, vdd_y_top)

    # 2. Connect 0 (VSS) to Sources: M2, M20, M6, M8, M14, M16, M18
    for n in [n_m2, n_m20, n_m6, n_m8, n_m14, n_m16, n_m18]:
        sx, sy = n['source']
        add_box(l_m1, sx - 0.14, vss_y_bot, sx + 0.14, sy)

    # Routing Helper: Connect M1 column at x to M2 track at y_track with a Via1
    def connect_m1_to_m2(x, y_m1_start, y_m1_end, y_track):
        # Vertical M1 trace
        add_box(l_m1, x - 0.14, min(y_m1_start, y_m1_end, y_track), x + 0.14, max(y_m1_start, y_m1_end, y_track))
        # M1 landing pad for Via1
        add_box(l_m1, x - 0.19, y_track - 0.19, x + 0.19, y_track + 0.19)
        # Via1
        add_box(l_via1, x - 0.13, y_track - 0.13, x + 0.13, y_track + 0.13)
        # M2 landing pad
        add_box(l_m2, x - 0.19, y_track - 0.15, x + 0.19, y_track + 0.15)

    # Dedicated Horizontal Metal2 Routing Tracks
    T_CLK  = 1.40
    T_CLKN = 2.00
    T_DINT = 2.60
    T_M    = 3.20
    T_MBAR = 3.80
    T_S    = 4.40

    T_QBAR = 1.40
    T_Q    = 2.60

    # ==================== NET ROUTING ====================

    # 1. NET: clk (Input Pin: M1 gate, M2 gate, M3 gate, M10 gate)
    connect_m1_to_m2(2.2, n_m2['gate'][1], p_m1['gate'][1], T_CLK)
    add_label(l_m1_lbl, "clk", 2.2, 2.70)
    connect_m1_to_m2(7.8, p_m3['gate'][1], p_m3['gate'][1], T_CLK)
    connect_m1_to_m2(18.0, n_m10['gate'][1], n_m10['gate'][1], T_CLK)
    # M2 Horizontal Track for clk (X = 2.2 .. 18.0)
    add_box(l_m2, 2.2 - 0.19, T_CLK - 0.15, 18.0 + 0.19, T_CLK + 0.15)

    # 2. NET: clk_n (Internal Node: M1 drain, M2 drain, M4 gate, M9 gate)
    dx1, dy1 = p_m1['drain']
    dx2, dy2 = n_m2['drain']
    connect_m1_to_m2(dx1, dy2, dy1, T_CLKN)
    connect_m1_to_m2(7.8, n_m4['gate'][1], n_m4['gate'][1], T_CLKN)
    connect_m1_to_m2(18.0, p_m9['gate'][1], p_m9['gate'][1], T_CLKN)
    # M2 Horizontal Track for clk_n (X = dx1 .. 18.0)
    add_box(l_m2, dx1 - 0.19, T_CLKN - 0.15, 18.0 + 0.19, T_CLKN + 0.15)

    # 3. NET: D (Input Pin: M19 gate, M20 gate at x = 5.0)
    add_box(l_m1, 5.0 - 0.14, n_m20['gate'][1], 5.0 + 0.14, p_m19['gate'][1])
    add_label(l_m1_lbl, "D", 5.0, 2.70)

    # 4. NET: D_int (Internal Node: M19 drain, M20 drain, M3 source, M4 drain)
    dx19, dy19 = p_m19['drain']
    dx20, dy20 = n_m20['drain']
    connect_m1_to_m2(dx19, dy20, dy19, T_DINT)
    sx3, sy3 = p_m3['source']
    connect_m1_to_m2(sx3, T_DINT, sy3, T_DINT)
    dx4, dy4 = n_m4['drain']
    connect_m1_to_m2(dx4, dy4, T_DINT, T_DINT)
    add_box(l_m2, dx19 - 0.19, T_DINT - 0.15, max(sx3, dx4) + 0.19, T_DINT + 0.15)

    # 5. NET: M (Master Node: M3 drain, M4 source, M5 gate, M6 gate, M7 drain, M8 drain)
    dx3, dy3 = p_m3['drain']
    sx4, sy4 = n_m4['source']
    connect_m1_to_m2(dx3, sy4, dy3, T_M)
    connect_m1_to_m2(10.6, n_m6['gate'][1], p_m5['gate'][1], T_M)
    dx7, dy7 = p_m7['drain']
    dx8, dy8 = n_m8['drain']
    connect_m1_to_m2(dx7, dy8, dy7, T_M)
    add_box(l_m2, dx3 - 0.19, T_M - 0.15, dx7 + 0.19, T_M + 0.15)

    # 6. NET: M_bar (Internal Node: M5 drain, M6 drain, M7 gate, M8 gate, M9 source, M10 drain)
    dx5, dy5 = p_m5['drain']
    dx6, dy6 = n_m6['drain']
    connect_m1_to_m2(dx5, dy6, dy5, T_MBAR)
    connect_m1_to_m2(14.0, n_m8['gate'][1], p_m7['gate'][1], T_MBAR)
    sx9, sy9 = p_m9['source']
    dx10, dy10 = n_m10['drain']
    connect_m1_to_m2(sx9, dy10, sy9, T_MBAR)
    add_box(l_m2, dx5 - 0.19, T_MBAR - 0.15, sx9 + 0.19, T_MBAR + 0.15)

    # 7. NET: S (Slave Node: M9 drain, M10 source, M11 gate, M13 gate, M17 drain, M18 drain)
    dx9, dy9 = p_m9['drain']
    sx10, sy10 = n_m10['source']
    connect_m1_to_m2(dx9, sy10, dy9, T_S)
    connect_m1_to_m2(21.0, n_m13['gate'][1], p_m11['gate'][1], T_S)
    dx17, dy17 = p_m17['drain']
    dx18, dy18 = n_m18['drain']
    connect_m1_to_m2(dx17, dy18, dy17, T_S)
    add_box(l_m2, dx9 - 0.19, T_S - 0.15, dx17 + 0.19, T_S + 0.15)

    # 8. NET: rst_n (Input Pin: M12 gate, M14 gate at x = 23.8)
    add_box(l_m1, 23.8 - 0.14, n_m14['gate'][1], 23.8 + 0.14, p_m12['gate'][1])
    add_label(l_m1_lbl, "rst_n", 23.8, 2.70)

    # 9. NET: net1 (Internal Series Stack: M13 source to M14 drain)
    sx13, sy13 = n_m13['source']
    dx14, dy14 = n_m14['drain']
    add_box(l_m1, sx13 - 0.14, sy13 - 0.14, dx14 + 0.14, dy14 + 0.14)

    # 10. NET: Q_bar (Internal Node: M11 drain, M12 drain, M13 drain, M15 gate, M16 gate, M17 gate, M18 gate)
    dx11, dy11 = p_m11['drain']
    dx12, dy12 = p_m12['drain']
    dx13, dy13 = n_m13['drain']
    add_box(l_m1, dx11 - 0.14, dy11 - 0.14, dx12 + 0.14, dy12 + 0.14)
    connect_m1_to_m2(dx11, T_QBAR, dy11, T_QBAR)
    connect_m1_to_m2(dx13, dy13, T_QBAR, T_QBAR)
    connect_m1_to_m2(26.6, n_m16['gate'][1], p_m15['gate'][1], T_QBAR)
    connect_m1_to_m2(30.0, n_m18['gate'][1], p_m17['gate'][1], T_QBAR)
    add_box(l_m2, min(dx11, dx13) - 0.19, T_QBAR - 0.15, 30.0 + 0.19, T_QBAR + 0.15)

    # 11. NET: Q (Output Pin: M15 drain, M16 drain at x = 26.6)
    dx15, dy15 = p_m15['drain']
    dx16, dy16 = n_m16['drain']
    add_box(l_m1, dx15 - 0.14, dy16, dx15 + 0.14, dy15)
    add_label(l_m1_lbl, "Q", dx15, 2.70)

    out_gds = "/foss/designs/chipathon26-SAR_ADC/layout/dff_cell.gds"
    os.makedirs(os.path.dirname(out_gds), exist_ok=True)
    layout.write(out_gds)
    print(f"Successfully generated clean DFF cell layout at: {out_gds}")

generate_dff_cell()
