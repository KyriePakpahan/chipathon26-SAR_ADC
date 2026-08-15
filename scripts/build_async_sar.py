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

def snap(val, g=10):
    return int(round(val / g)) * g

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

def build_async_sar():
    layout = pya.Layout()
    layout.dbu = 0.001

    # Load verified standard and subcell GDS files
    layout.read('/foss/designs/chipathon26-SAR_ADC/layout/async_inverter.gds')
    layout.read('/foss/designs/chipathon26-SAR_ADC/layout/async_nand2.gds')
    layout.read('/foss/designs/chipathon26-SAR_ADC/layout/async_nor2.gds')
    layout.read('/foss/designs/chipathon26-SAR_ADC/layout/shift_reg_8bit.gds')
    layout.read('/foss/designs/chipathon26-SAR_ADC/layout/bit_reg.gds')
    layout.read('/foss/designs/chipathon26-SAR_ADC/layout/async_delay_chain.gds')
    layout.read('/foss/designs/chipathon26-SAR_ADC/layout/async_start_delay.gds')

    cell_inv       = layout.cell('async_inverter')
    cell_nand      = layout.cell('async_nand2')
    cell_nor       = layout.cell('async_nor2')
    cell_sr8       = layout.cell('shift_reg_8bit')
    cell_bit_reg   = layout.cell('bit_reg')
    cell_del       = layout.cell('async_delay_chain')
    cell_start_del = layout.cell('async_start_delay')

    top = layout.create_cell('async_sar')

    l_nw = layout.layer(21, 0)
    l_m1 = layout.layer(34, 0)
    l_m1_lbl = layout.layer(34, 10)
    l_via1 = layout.layer(35, 0)
    l_m2 = layout.layer(36, 0)
    l_m2_lbl = layout.layer(36, 10)
    l_via2 = layout.layer(38, 0)
    l_m3 = layout.layer(42, 0)
    l_m3_lbl = layout.layer(42, 10)
    l_via3 = layout.layer(40, 0)
    l_m4 = layout.layer(46, 0)
    l_m4_lbl = layout.layer(46, 10)

    # Clear text from child cells
    for cell in layout.each_cell():
        if cell.name != 'async_sar':
            for l_idx in layout.layer_indexes():
                shapes = cell.shapes(l_idx)
                for s in list(shapes.each()):
                    if s.is_text():
                        shapes.erase(s)

    def add_box(layer, x1, y1, x2, y2):
        top.shapes(layer).insert(pya.Box(snap(x1), snap(y1), snap(x2), snap(y2)))
    def add_label_m1(text, x, y):
        top.shapes(l_m1_lbl).insert(pya.Text(text, snap(x), snap(y)))
        top.shapes(l_m1).insert(pya.Text(text, snap(x), snap(y)))
    def add_label_m3(text, x, y):
        top.shapes(l_m3_lbl).insert(pya.Text(text, snap(x), snap(y)))
        top.shapes(l_m3).insert(pya.Text(text, snap(x), snap(y)))

    # Exact standard DRC stacks
    def connect_m1_to_m4(x, y):
        add_box(l_m1, x - 140, y - 190, x + 140, y + 190)
        add_box(l_via1, x - 130, y - 130, x + 130, y + 130)
        add_box(l_m2, x - 190, y - 190, x + 190, y + 190)
        add_box(l_via2, x - 130, y - 130, x + 130, y + 130)
        add_box(l_m3, x - 190, y - 190, x + 190, y + 190)
        add_box(l_via3, x - 130, y - 130, x + 130, y + 130)
        add_box(l_m4, x - 180, y - 180, x + 180, y + 180)

    def connect_m2_to_m4(x, y):
        add_box(l_m2, x - 190, y - 190, x + 190, y + 190)
        add_box(l_via2, x - 130, y - 130, x + 130, y + 130)
        add_box(l_m3, x - 190, y - 190, x + 190, y + 190)
        add_box(l_via3, x - 130, y - 130, x + 130, y + 130)
        add_box(l_m4, x - 180, y - 180, x + 180, y + 180)

    def connect_m3_to_m4(x, y):
        add_box(l_m3, x - 190, y - 190, x + 190, y + 190)
        add_box(l_via3, x - 130, y - 130, x + 130, y + 130)
        add_box(l_m4, x - 180, y - 180, x + 180, y + 180)

    def route_h_m3(y, x1, x2):
        add_box(l_m3, min(x1, x2) - 190, y - 180, max(x1, x2) + 190, y + 180)

    def route_v_m4(x, y1, y2):
        add_box(l_m4, x - 180, min(y1, y2) - 180, x + 180, max(y1, y2) + 180)

    row_y = [0, 30000, 70000, 102000, 132000]
    total_w = 880000
    bus_end_x = total_w - 5000 # 875000

    # 1. Continuous Rails & N-Well for each row
    for ry in row_y:
        add_box(l_m1, 0, ry + 6800 + 2500, total_w, ry + 6800 + 3500)
        add_box(l_m1, 0, ry - 2500, total_w, ry - 1500)
        add_box(l_nw, 0, ry + 6800 - 1500, total_w, ry + 6800 + 4000)

    # Vertical Power distribution on Metal 4
    for x_pwr in [2000, total_w - 6000]:
        add_box(l_m4, x_pwr - 1000, -3000, x_pwr + 1000, 220000)
        for ry in row_y:
            connect_m1_to_m4(x_pwr, ry + 9800)
    add_label_m1('vdd', 2000, row_y[4] + 9800)

    for x_pwr in [6000, total_w - 2000]:
        add_box(l_m4, x_pwr - 1000, -3000, x_pwr + 1000, 220000)
        for ry in row_y:
            connect_m1_to_m4(x_pwr, ry - 2000)
    add_label_m1('vss', 6000, row_y[4] - 2000)

    # ROW 0: shift_reg_8bit + Inverters / Gates
    x_sr8_pos = 10000
    top.insert(pya.CellInstArray(cell_sr8.cell_index(), pya.Trans(x_sr8_pos, row_y[0])))

    # Tie Shift Register serial_in directly to VSS on Metal 1 vertically at X = x_sr8_pos + 3330:
    x_sr_si = x_sr8_pos + 3330
    add_box(l_m1, x_sr_si - 120, row_y[0] - 2000, x_sr_si + 120, row_y[0] + 900)

    # Clean Row 0 gate placements (past shift_reg_8bit boundary at X = 602000)
    x_isrc_pos = 610000
    x_irst_pos = 622000
    x_ise1_pos = 634000
    x_ise2_pos = 646000
    x_ndn_pos  = 670000
    x_idn_pos  = 690000

    top.insert(pya.CellInstArray(cell_inv.cell_index(),  pya.Trans(x_isrc_pos, row_y[0])))
    top.insert(pya.CellInstArray(cell_inv.cell_index(),  pya.Trans(x_irst_pos, row_y[0])))
    top.insert(pya.CellInstArray(cell_inv.cell_index(),  pya.Trans(x_ise1_pos, row_y[0])))
    top.insert(pya.CellInstArray(cell_inv.cell_index(),  pya.Trans(x_ise2_pos, row_y[0])))
    top.insert(pya.CellInstArray(cell_nand.cell_index(), pya.Trans(x_ndn_pos,  row_y[0])))
    top.insert(pya.CellInstArray(cell_inv.cell_index(),  pya.Trans(x_idn_pos,  row_y[0])))

    # ROW 1: 8 Bit Registers
    bit_pos = [10000 + i * 108000 for i in range(8)]
    for i in range(8):
        top.insert(pya.CellInstArray(cell_bit_reg.cell_index(), pya.Trans(bit_pos[i], row_y[1])))

    # ROW 2: Handshake & Timing Logic
    x_icd_pos   = 10000
    x_del_pos   = 20000
    x_stdel_pos = 160000
    x_idnv_pos  = 435000
    x_nset_pos  = 450000
    x_nctl_pos  = 480000
    x_nrst_pos  = 510000

    top.insert(pya.CellInstArray(cell_inv.cell_index(),       pya.Trans(x_icd_pos,   row_y[2])))
    top.insert(pya.CellInstArray(cell_del.cell_index(),       pya.Trans(x_del_pos,   row_y[2])))
    top.insert(pya.CellInstArray(cell_start_del.cell_index(), pya.Trans(x_stdel_pos, row_y[2])))
    top.insert(pya.CellInstArray(cell_inv.cell_index(),       pya.Trans(x_idnv_pos,  row_y[2])))
    top.insert(pya.CellInstArray(cell_nand.cell_index(),      pya.Trans(x_nset_pos,  row_y[2])))
    top.insert(pya.CellInstArray(cell_nand.cell_index(),      pya.Trans(x_nctl_pos,  row_y[2])))
    top.insert(pya.CellInstArray(cell_nor.cell_index(),       pya.Trans(x_nrst_pos,  row_y[2])))

    # ROW 3: DAC First Stage NORs (Pitch = 42um)
    nor_dq_pos = [10000 + i * 42000 for i in range(8)]
    for i in range(8):
        top.insert(pya.CellInstArray(cell_nor.cell_index(), pya.Trans(nor_dq_pos[i], row_y[3])))

    # ROW 4: DAC Second Stage NORs (Pitch = 42um)
    nor_st_pos = [10000 + i * 42000 for i in range(8)]
    for i in range(8):
        top.insert(pya.CellInstArray(cell_nor.cell_index(), pya.Trans(nor_st_pos[i], row_y[4])))

    # GLOBAL BUSES on Metal 3 at Y >= 166000 (extended across full width to bus_end_x = 875000!)
    BUS_START  = 166000
    BUS_CDONE  = 168000
    BUS_COMP_P = 170000
    route_h_m3(BUS_START, 9000, bus_end_x)
    add_label_m3('start', 10000, BUS_START)

    route_h_m3(BUS_CDONE, 9000, bus_end_x)
    add_label_m3('comp_done', 10000, BUS_CDONE)

    route_h_m3(BUS_COMP_P, 9000, bus_end_x)
    add_label_m3('comp_out_p', 10000, BUS_COMP_P)

    # 1. START connections:
    # x_inv_rst In (tap at Y=2000, dogleg on M2 to +6000)
    x_irst_in_pin = x_irst_pos + 3330
    x_irst_in     = x_irst_pos + 6000
    add_box(l_m1, x_irst_in_pin - 140, row_y[0] + 2000 - 190, x_irst_in_pin + 140, row_y[0] + 2000 + 190)
    add_box(l_via1, x_irst_in_pin - 130, row_y[0] + 2000 - 130, x_irst_in_pin + 130, row_y[0] + 2000 + 130)
    add_box(l_m2, x_irst_in_pin - 190, row_y[0] + 2000 - 140, x_irst_in + 190, row_y[0] + 2000 + 140)
    connect_m2_to_m4(x_irst_in, row_y[0] + 2000)
    route_v_m4(x_irst_in, row_y[0] + 2000, BUS_START)
    connect_m3_to_m4(x_irst_in, BUS_START)

    # x_inv_se1 In (tap at Y=2000, dogleg on M2 to +6000)
    x_ise1_in_pin = x_ise1_pos + 3330
    x_ise1_in     = x_ise1_pos + 6000
    add_box(l_m1, x_ise1_in_pin - 140, row_y[0] + 2000 - 190, x_ise1_in_pin + 140, row_y[0] + 2000 + 190)
    add_box(l_via1, x_ise1_in_pin - 130, row_y[0] + 2000 - 130, x_ise1_in_pin + 130, row_y[0] + 2000 + 130)
    add_box(l_m2, x_ise1_in_pin - 190, row_y[0] + 2000 - 140, x_ise1_in + 190, row_y[0] + 2000 + 140)
    connect_m2_to_m4(x_ise1_in, row_y[0] + 2000)
    route_v_m4(x_ise1_in, row_y[0] + 2000, BUS_START)
    connect_m3_to_m4(x_ise1_in, BUS_START)

    # x_start_del In (tap at Y=2000 on M1, dogleg to x_stdel_pos - 2000 = 158000 on M2 into empty space!)
    x_stdel_pin = x_stdel_pos + 3330
    x_stdel_in  = x_stdel_pos - 2000 # 158000
    add_box(l_m1, x_stdel_pin - 140, row_y[2] + 2000 - 190, x_stdel_pin + 140, row_y[2] + 2000 + 190)
    add_box(l_via1, x_stdel_pin - 130, row_y[2] + 2000 - 130, x_stdel_pin + 130, row_y[2] + 2000 + 130)
    add_box(l_m2, x_stdel_in - 190, row_y[2] + 2000 - 140, x_stdel_pin + 190, row_y[2] + 2000 + 140)
    connect_m2_to_m4(x_stdel_in, row_y[2] + 2000)
    route_v_m4(x_stdel_in, row_y[2] + 2000, BUS_START)
    connect_m3_to_m4(x_stdel_in, BUS_START)

    # 8x x_nor_st In B (dogleg to nor_st_pos[k] + 12000 on M2!)
    for k in range(8):
        x_st_b_pin = nor_st_pos[k] + 9330
        x_st_b     = nor_st_pos[k] + 12000
        add_box(l_m1, x_st_b_pin - 140, row_y[4] + 4000 - 190, x_st_b_pin + 140, row_y[4] + 4000 + 190)
        add_box(l_via1, x_st_b_pin - 130, row_y[4] + 4000 - 130, x_st_b_pin + 130, row_y[4] + 4000 + 130)
        add_box(l_m2, x_st_b_pin - 190, row_y[4] + 4000 - 140, x_st_b + 190, row_y[4] + 4000 + 140)
        connect_m2_to_m4(x_st_b, row_y[4] + 4000)
        route_v_m4(x_st_b, row_y[4] + 4000, BUS_START)
        connect_m3_to_m4(x_st_b, BUS_START)

    # 2. COMP_DONE connections:
    # x_inv_srclk In (tap at Y=2000, dogleg on M2 to +6000)
    x_isrc_in_pin = x_isrc_pos + 3330
    x_isrc_in     = x_isrc_pos + 6000
    add_box(l_m1, x_isrc_in_pin - 140, row_y[0] + 2000 - 190, x_isrc_in_pin + 140, row_y[0] + 2000 + 190)
    add_box(l_via1, x_isrc_in_pin - 130, row_y[0] + 2000 - 130, x_isrc_in_pin + 130, row_y[0] + 2000 + 130)
    add_box(l_m2, x_isrc_in_pin - 190, row_y[0] + 2000 - 140, x_isrc_in + 190, row_y[0] + 2000 + 140)
    connect_m2_to_m4(x_isrc_in, row_y[0] + 2000)
    route_v_m4(x_isrc_in, row_y[0] + 2000, BUS_CDONE)
    connect_m3_to_m4(x_isrc_in, BUS_CDONE)

    # x_inv_cd In (tap at Y=980, dogleg to +6000 on M2)
    x_icd_pin = x_icd_pos + 3330
    x_icd_in  = x_icd_pos + 6000
    add_box(l_m1, x_icd_pin - 140, row_y[2] + 2000 - 190, x_icd_pin + 140, row_y[2] + 2000 + 190)
    add_box(l_via1, x_icd_pin - 130, row_y[2] + 2000 - 130, x_icd_pin + 130, row_y[2] + 2000 + 130)
    add_box(l_m2, x_icd_pin - 190, row_y[2] + 2000 - 140, x_icd_in + 190, row_y[2] + 2000 + 140)
    connect_m2_to_m4(x_icd_in, row_y[2] + 2000)
    route_v_m4(x_icd_in, row_y[2] + 2000, BUS_CDONE)
    connect_m3_to_m4(x_icd_in, BUS_CDONE)

    # x_del In (tap at Y=2000 on M1, dogleg to x_del_pos - 2000 = 18000 on M2)
    x_del_in_pin = x_del_pos + 3330
    x_del_in     = x_del_pos - 2000 # 18000
    add_box(l_m1, x_del_in_pin - 140, row_y[2] + 2000 - 190, x_del_in_pin + 140, row_y[2] + 2000 + 190)
    add_box(l_via1, x_del_in_pin - 130, row_y[2] + 2000 - 130, x_del_in_pin + 130, row_y[2] + 2000 + 130)
    add_box(l_m2, x_del_in - 190, row_y[2] + 2000 - 140, x_del_in_pin + 190, row_y[2] + 2000 + 140)
    connect_m2_to_m4(x_del_in, row_y[2] + 2000)
    route_v_m4(x_del_in, row_y[2] + 2000, BUS_CDONE)
    connect_m3_to_m4(x_del_in, BUS_CDONE)

    # x_nand_done In B: tap at Y = 4500
    connect_m1_to_m4(x_ndn_pos + 9330, row_y[0] + 4500)
    route_v_m4(x_ndn_pos + 9330, row_y[0] + 4500, BUS_CDONE)
    connect_m3_to_m4(x_ndn_pos + 9330, BUS_CDONE)

    # 3. COMP_OUT_P connections to 8x bit_reg comp_out (native pin at bit_pos[k] + 9330, tap at Y = 980):
    for k in range(8):
        x_b_co = bit_pos[k] + 9330
        connect_m1_to_m4(x_b_co, row_y[1] + 980)
        route_v_m4(x_b_co, row_y[1] + 980, BUS_COMP_P)
        connect_m3_to_m4(x_b_co, BUS_COMP_P)

    # 4. RST_N_INT (Channel 1, Y = 16000, extended across full width!):
    BUS_RST_INT = 16000
    x_irst_out = x_irst_pos + 2770
    connect_m1_to_m4(x_irst_out, row_y[0] + 980)
    route_v_m4(x_irst_out, row_y[0] + 980, BUS_RST_INT)
    connect_m3_to_m4(x_irst_out, BUS_RST_INT)
    route_h_m3(BUS_RST_INT, 9000, bus_end_x)

    # to x_sr8 rst_n (M2 at x_sr8_pos + 5000 = 15000, row_y[0] + 13000)
    connect_m2_to_m4(x_sr8_pos + 5000, row_y[0] + 13000)
    route_v_m4(x_sr8_pos + 5000, row_y[0] + 13000, BUS_RST_INT)
    connect_m3_to_m4(x_sr8_pos + 5000, BUS_RST_INT)

    # to 8x bit_reg rst_n (M1 at bit_pos[k] + 3330, tap at Y = 980)
    for k in range(8):
        x_b_rst = bit_pos[k] + 3330
        connect_m1_to_m4(x_b_rst, row_y[1] + 980)
        route_v_m4(x_b_rst, BUS_RST_INT, row_y[1] + 980)
        connect_m3_to_m4(x_b_rst, BUS_RST_INT)

    # 5. COMP_DONE_B (Channel 1, Y = 18000, extended across full width!):
    BUS_CDONE_B = 18000
    x_isrc_out = x_isrc_pos + 2770
    connect_m1_to_m4(x_isrc_out, row_y[0] + 980)
    route_v_m4(x_isrc_out, row_y[0] + 980, BUS_CDONE_B)
    connect_m3_to_m4(x_isrc_out, BUS_CDONE_B)
    route_h_m3(BUS_CDONE_B, 9000, bus_end_x)

    # to x_sr8 clk (M2 at x_sr8_pos + 2000 = 12000, row_y[0] + 12000)
    connect_m2_to_m4(x_sr8_pos + 2000, row_y[0] + 12000)
    route_v_m4(x_sr8_pos + 2000, row_y[0] + 12000, BUS_CDONE_B)
    connect_m3_to_m4(x_sr8_pos + 2000, BUS_CDONE_B)

    # 6. Q0..Q7 from shift_reg_8bit:
    q_xs = [x_sr8_pos + 77060,
            x_sr8_pos + 138060,
            x_sr8_pos + 202060,
            x_sr8_pos + 266060,
            x_sr8_pos + 330060,
            x_sr8_pos + 394060,
            x_sr8_pos + 458060,
            x_sr8_pos + 522060]

    for k in range(8):
        qx = q_xs[k]
        connect_m2_to_m4(qx, row_y[0] + 14000)

        bit_k = 7 - k
        # Everything routed in Channel 2 at Y = 49000 + k * 2000
        y_q = 49000 + k * 2000
        
        # bit_reg en in Row 1 (M1 at bit_pos[bit_k] + 15330, tap at Y = 980)
        x_ben = bit_pos[bit_k] + 15330
        connect_m1_to_m4(x_ben, row_y[1] + 980)
        route_v_m4(x_ben, row_y[1] + 980, y_q)
        connect_m3_to_m4(x_ben, y_q)

        # nor_dq In B in Row 3 (dogleg to nor_dq_pos[bit_k] + 10000 on M2 to clear dout_1!)
        x_dq_b_pin = nor_dq_pos[bit_k] + 9330
        x_dq_b     = nor_dq_pos[bit_k] + 10000
        add_box(l_m1, x_dq_b_pin - 140, row_y[3] + 4000 - 190, x_dq_b_pin + 140, row_y[3] + 4000 + 190)
        add_box(l_via1, x_dq_b_pin - 130, row_y[3] + 4000 - 130, x_dq_b_pin + 130, row_y[3] + 4000 + 130)
        add_box(l_m2, x_dq_b_pin - 190, row_y[3] + 4000 - 140, x_dq_b + 190, row_y[3] + 4000 + 140)
        connect_m2_to_m4(x_dq_b, row_y[3] + 4000)
        route_v_m4(x_dq_b, y_q, row_y[3] + 4000)
        connect_m3_to_m4(x_dq_b, y_q)

        # Single horizontal M3 track connecting Q[k], bit_reg en, and nor_dq In B:
        route_h_m3(y_q, min(qx, x_ben, x_dq_b), max(qx, x_ben, x_dq_b))
        connect_m3_to_m4(qx, y_q)

        # Vertical trunk for Q[k] from Row 0 to Channel 2
        route_v_m4(qx, row_y[0] + 14000, y_q)

    # Q7 to x_nand_done In A (M1 at x_ndn_pos + 3330, row_y[0] + 4500)
    BUS_Q7_DONE = 20000
    connect_m1_to_m4(x_ndn_pos + 3330, row_y[0] + 4500)
    route_v_m4(x_ndn_pos + 3330, row_y[0] + 4500, BUS_Q7_DONE)
    connect_m3_to_m4(x_ndn_pos + 3330, BUS_Q7_DONE)
    route_h_m3(BUS_Q7_DONE, min(q_xs[7], x_ndn_pos + 3330), max(q_xs[7], x_ndn_pos + 3330))
    connect_m3_to_m4(q_xs[7], BUS_Q7_DONE)

    # 7. DOUT[7:0]: bit_reg bit_out (M2 at Y=15000, tapped at bit_pos[k] + 76000) -> x_nor_dq[k] In A (tap directly at native gate contact X=3330, Y=900!)
    # Routed in Channel 3 (Y = 115000 + k * 1500)
    for k in range(8):
        x_bo_tap = bit_pos[k] + 76000
        x_dq_a   = nor_dq_pos[k] + 3330
        y_dout   = 115000 + k * 1500 # In Channel 3

        connect_m2_to_m4(x_bo_tap, row_y[1] + 15000)
        route_v_m4(x_bo_tap, row_y[1] + 15000, y_dout)
        connect_m3_to_m4(x_bo_tap, y_dout)

        connect_m1_to_m4(x_dq_a, row_y[3] + 900)
        route_v_m4(x_dq_a, y_dout, row_y[3] + 900)
        connect_m3_to_m4(x_dq_a, y_dout)

        route_h_m3(y_dout, min(x_bo_tap, x_dq_a), max(x_bo_tap, x_dq_a))

        # Port label for dout[k]
        add_label_m3(f'dout[{k}]', x_bo_tap, y_dout)

    # 8. DAC_N[7:0]: x_nor_dq[k] Out (M1 at Y=3000) -> x_nor_st[k] In A (M1 at Y=3000)
    # Routed in Channel 4 (Y = 145000 + k * 1500) between Row 3 and Row 4!
    for k in range(8):
        x_dq_out = nor_dq_pos[k] + 26780
        x_st_a   = nor_st_pos[k] + 3330
        y_dacn   = 145000 + k * 1500

        connect_m1_to_m4(x_dq_out, row_y[3] + 3000)
        route_v_m4(x_dq_out, row_y[3] + 3000, y_dacn)
        connect_m3_to_m4(x_dq_out, y_dacn)

        connect_m1_to_m4(x_st_a, row_y[4] + 3000)
        route_v_m4(x_st_a, y_dacn, row_y[4] + 3000)
        connect_m3_to_m4(x_st_a, y_dacn)

        route_h_m3(y_dacn, min(x_dq_out, x_st_a), max(x_dq_out, x_st_a))

    # 9. DAC_IN[7:0]: x_nor_st[k] Out on Metal 1 (Y=3000)
    # Doglegged on M2 to nor_st_pos[k] + 23000 to clear dac_n[k] trunk!
    # Routed upwards from Row 4 to Y = 180000 + k * 1500
    for k in range(8):
        x_st_out_pin = nor_st_pos[k] + 26780
        x_st_out     = nor_st_pos[k] + 23000
        add_box(l_m1, x_st_out_pin - 140, row_y[4] + 3000 - 190, x_st_out_pin + 140, row_y[4] + 3000 + 190)
        add_box(l_via1, x_st_out_pin - 130, row_y[4] + 3000 - 130, x_st_out_pin + 130, row_y[4] + 3000 + 130)
        add_box(l_m2, x_st_out - 190, row_y[4] + 3000 - 140, x_st_out_pin + 190, row_y[4] + 3000 + 140)
        connect_m2_to_m4(x_st_out, row_y[4] + 3000)
        y_dacin = 180000 + k * 1500
        route_v_m4(x_st_out, row_y[4] + 3000, y_dacin)
        connect_m3_to_m4(x_st_out, y_dacin)
        add_label_m3(f'dac_in[{k}]', x_st_out, y_dacin)

    # 10. SAMPLE_EN: x_inv_se1 Out -> x_inv_se2 In (Channel 1, Y = 14000)
    BUS_SE_INT = 14000
    x_ise1_out = x_ise1_pos + 2770
    connect_m1_to_m4(x_ise1_out, row_y[0] + 980)
    route_v_m4(x_ise1_out, row_y[0] + 980, BUS_SE_INT)
    connect_m3_to_m4(x_ise1_out, BUS_SE_INT)

    x_ise2_in_pin = x_ise2_pos + 3330
    x_ise2_in     = x_ise2_pos + 6000
    add_box(l_m1, x_ise2_in_pin - 140, row_y[0] + 2000 - 190, x_ise2_in_pin + 140, row_y[0] + 2000 + 190)
    add_box(l_via1, x_ise2_in_pin - 130, row_y[0] + 2000 - 130, x_ise2_in_pin + 130, row_y[0] + 2000 + 130)
    add_box(l_m2, x_ise2_in_pin - 190, row_y[0] + 2000 - 140, x_ise2_in + 190, row_y[0] + 2000 + 140)
    connect_m2_to_m4(x_ise2_in, row_y[0] + 2000)
    route_v_m4(x_ise2_in, row_y[0] + 2000, BUS_SE_INT)
    connect_m3_to_m4(x_ise2_in, BUS_SE_INT)
    route_h_m3(BUS_SE_INT, x_ise1_out, x_ise2_in)

    # sample_en port (x_inv_se2 Out)
    x_se_out = x_ise2_pos + 2770
    connect_m1_to_m4(x_se_out, row_y[0] + 980)
    route_v_m4(x_se_out, row_y[0] + 980, 172000)
    connect_m3_to_m4(x_se_out, 172000)
    add_label_m3('sample_en', x_se_out, 172000)

    # 11. DONE: x_nand_done Out (M2 at Y=3000) to x_inv_done In (dogleg on M2 to +6000)
    BUS_DONE_INT = 22000
    x_ndn_out = x_ndn_pos + 5780
    connect_m2_to_m4(x_ndn_out, row_y[0] + 3000)
    route_v_m4(x_ndn_out, row_y[0] + 3000, BUS_DONE_INT)
    connect_m3_to_m4(x_ndn_out, BUS_DONE_INT)

    x_idn_in_pin = x_idn_pos + 3330
    x_idn_in     = x_idn_pos + 6000
    add_box(l_m1, x_idn_in_pin - 140, row_y[0] + 2000 - 190, x_idn_in_pin + 140, row_y[0] + 2000 + 190)
    add_box(l_via1, x_idn_in_pin - 130, row_y[0] + 2000 - 130, x_idn_in_pin + 130, row_y[0] + 2000 + 130)
    add_box(l_m2, x_idn_in_pin - 190, row_y[0] + 2000 - 140, x_idn_in + 190, row_y[0] + 2000 + 140)
    connect_m2_to_m4(x_idn_in, row_y[0] + 2000)
    route_v_m4(x_idn_in, row_y[0] + 2000, BUS_DONE_INT)
    connect_m3_to_m4(x_idn_in, BUS_DONE_INT)
    route_h_m3(BUS_DONE_INT, x_ndn_out, x_idn_in)

    # done port (x_inv_done Out) -> x_inv_dn In
    BUS_DONE = 24000
    x_idn_out = x_idn_pos + 2770
    connect_m1_to_m4(x_idn_out, row_y[0] + 980)
    route_v_m4(x_idn_out, row_y[0] + 980, 174000)
    connect_m3_to_m4(x_idn_out, 174000)
    connect_m3_to_m4(x_idn_out, BUS_DONE)
    add_label_m3('done', x_idn_out, 174000)

    # x_inv_dn In: dogleg at Y = 2000 to +6000 on M2
    x_idnv_pin = x_idnv_pos + 3330
    x_idnv_in  = x_idnv_pos + 6000
    add_box(l_m1, x_idnv_pin - 140, row_y[2] + 2000 - 190, x_idnv_pin + 140, row_y[2] + 2000 + 190)
    add_box(l_via1, x_idnv_pin - 130, row_y[2] + 2000 - 130, x_idnv_pin + 130, row_y[2] + 2000 + 130)
    add_box(l_m2, x_idnv_pin - 190, row_y[2] + 2000 - 140, x_idnv_in + 190, row_y[2] + 2000 + 140)
    connect_m2_to_m4(x_idnv_in, row_y[2] + 2000)
    route_v_m4(x_idnv_in, BUS_DONE, row_y[2] + 2000)
    connect_m3_to_m4(x_idnv_in, BUS_DONE)
    route_h_m3(BUS_DONE, min(x_idn_out, x_idnv_in), max(x_idn_out, x_idnv_in))

    # 12. Handshake logic (Channel 2.5, Y in [89000, 99000]):
    # comp_done_inv: x_inv_cd Out (tap at Y = 980) -> x_nand_settle In A (routed at Y = 89000)
    BUS_CD_INV = 89000
    x_icd_out = x_icd_pos + 2770
    connect_m1_to_m4(x_icd_out, row_y[2] + 980)
    route_v_m4(x_icd_out, row_y[2] + 980, BUS_CD_INV)
    connect_m3_to_m4(x_icd_out, BUS_CD_INV)

    x_nset_a = x_nset_pos + 3330
    connect_m1_to_m4(x_nset_a, row_y[2] + 4500)
    route_v_m4(x_nset_a, row_y[2] + 4500, BUS_CD_INV)
    connect_m3_to_m4(x_nset_a, BUS_CD_INV)
    route_h_m3(BUS_CD_INV, x_icd_out, x_nset_a)

    # comp_done_delayed_n: x_del Out -> x_nand_settle In B (routed at Y = 91000)
    BUS_CD_DEL = 91000
    x_del_out = x_del_pos + 122000
    add_box(l_m1, x_del_out - 140, row_y[2] + 4500 - 190, x_del_pos + 122770 + 140, row_y[2] + 4500 + 190)
    connect_m1_to_m4(x_del_out, row_y[2] + 4500)
    route_v_m4(x_del_out, row_y[2] + 4500, BUS_CD_DEL)
    connect_m3_to_m4(x_del_out, BUS_CD_DEL)

    x_nset_b = x_nset_pos + 9330
    connect_m1_to_m4(x_nset_b, row_y[2] + 4500)
    route_v_m4(x_nset_b, row_y[2] + 4500, BUS_CD_DEL)
    connect_m3_to_m4(x_nset_b, BUS_CD_DEL)
    route_h_m3(BUS_CD_DEL, x_del_out, x_nset_b)

    # start_n: x_start_del Out -> x_nand_ctrl In A (routed at Y = 93000)
    BUS_START_N = 93000
    x_stdel_out = x_stdel_pos + 266000
    add_box(l_m1, x_stdel_out - 140, row_y[2] + 4500 - 190, x_stdel_pos + 266770 + 140, row_y[2] + 4500 + 190)
    connect_m1_to_m4(x_stdel_out, row_y[2] + 4500)
    route_v_m4(x_stdel_out, row_y[2] + 4500, BUS_START_N)
    connect_m3_to_m4(x_stdel_out, BUS_START_N)

    x_nctl_a = x_nctl_pos + 3330
    connect_m1_to_m4(x_nctl_a, row_y[2] + 4500)
    route_v_m4(x_nctl_a, row_y[2] + 4500, BUS_START_N)
    connect_m3_to_m4(x_nctl_a, BUS_START_N)
    route_h_m3(BUS_START_N, x_stdel_out, x_nctl_a)

    # done_n: x_inv_dn Out (tap at Y = 980) -> x_nand_ctrl In B (routed at Y = 95000)
    BUS_DONE_N = 95000
    x_idnv_out = x_idnv_pos + 2770
    connect_m1_to_m4(x_idnv_out, row_y[2] + 980)
    route_v_m4(x_idnv_out, row_y[2] + 980, BUS_DONE_N)
    connect_m3_to_m4(x_idnv_out, BUS_DONE_N)

    x_nctl_b = x_nctl_pos + 9330
    connect_m1_to_m4(x_nctl_b, row_y[2] + 4500)
    route_v_m4(x_nctl_b, row_y[2] + 4500, BUS_DONE_N)
    connect_m3_to_m4(x_nctl_b, BUS_DONE_N)
    route_h_m3(BUS_DONE_N, x_idnv_out, x_nctl_b)

    # gate_settle: x_nand_settle Out -> x_nor_rstl In A (routed at Y = 97000)
    BUS_G_SETTLE = 97000
    x_nset_out = x_nset_pos + 5780
    connect_m2_to_m4(x_nset_out, row_y[2] + 3000)
    route_v_m4(x_nset_out, row_y[2] + 3000, BUS_G_SETTLE)
    connect_m3_to_m4(x_nset_out, BUS_G_SETTLE)

    # In A of x_nor_rstl: tap at native gate pad Y = 900
    x_nrst_a = x_nrst_pos + 3330
    connect_m1_to_m4(x_nrst_a, row_y[2] + 900)
    route_v_m4(x_nrst_a, row_y[2] + 900, BUS_G_SETTLE)
    connect_m3_to_m4(x_nrst_a, BUS_G_SETTLE)
    route_h_m3(BUS_G_SETTLE, x_nset_out, x_nrst_a)

    # gate_ctrl: x_nand_ctrl Out -> x_nor_rstl In B (routed at Y = 99000)
    BUS_G_CTRL = 99000
    x_nctl_out = x_nctl_pos + 5780
    connect_m2_to_m4(x_nctl_out, row_y[2] + 3000)
    route_v_m4(x_nctl_out, row_y[2] + 3000, BUS_G_CTRL)
    connect_m3_to_m4(x_nctl_out, BUS_G_CTRL)

    # In B of x_nor_rstl: dogleg on M2 to +12000
    x_nrst_b_pin = x_nrst_pos + 9330
    x_nrst_b     = x_nrst_pos + 12000
    add_box(l_m1, x_nrst_b_pin - 140, row_y[2] + 4000 - 190, x_nrst_b_pin + 140, row_y[2] + 4000 + 190)
    add_box(l_via1, x_nrst_b_pin - 130, row_y[2] + 4000 - 130, x_nrst_b_pin + 130, row_y[2] + 4000 + 130)
    add_box(l_m2, x_nrst_b_pin - 190, row_y[2] + 4000 - 140, x_nrst_b + 190, row_y[2] + 4000 + 140)
    connect_m2_to_m4(x_nrst_b, row_y[2] + 4000)
    route_v_m4(x_nrst_b, row_y[2] + 4000, BUS_G_CTRL)
    connect_m3_to_m4(x_nrst_b, BUS_G_CTRL)
    route_h_m3(BUS_G_CTRL, x_nctl_out, x_nrst_b)

    # rst_latch Out: x_nor_rstl Out
    x_nrst_out = x_nrst_pos + 26780
    connect_m1_to_m4(x_nrst_out, row_y[2] + 3000)
    route_v_m4(x_nrst_out, row_y[2] + 3000, 176000)
    connect_m3_to_m4(x_nrst_out, 176000)
    add_label_m3('rst_latch', x_nrst_out, 176000)

    # Flatten top cell and merge shapes
    top.flatten(-1, True)
    snap_to_grid(layout, 5)

    layout.write('/foss/designs/chipathon26-SAR_ADC/layout/async_sar.gds')
    print('Generated async_sar.gds successfully!')

if __name__ == '__main__':
    build_async_sar()
