import sys, types
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

layout = pya.Layout()
layout.dbu = 0.001

layout.read('/foss/designs/chipathon26-SAR_ADC/layout/dff_cell_set.gds')
layout.read('/foss/designs/chipathon26-SAR_ADC/layout/dff_cell.gds')

cell_dff_set = layout.cell('dff_cell_set')
cell_dff = layout.cell('dff_cell')

top = layout.create_cell('shift_reg_8bit')

l_nw = layout.layer(21, 0)
l_m1 = layout.layer(34, 0)
l_m1_lbl = layout.layer(34, 10)
l_via1 = layout.layer(35, 0)
l_m2 = layout.layer(36, 0)
l_m2_lbl = layout.layer(36, 10)
l_via2 = layout.layer(38, 0)
l_m3 = layout.layer(42, 0)
l_m3_lbl = layout.layer(42, 10)

# Remove ALL text objects from child cells safely
for cell in [cell_dff_set, cell_dff]:
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

def add_label_m2(text, x, y):
    top.shapes(l_m2_lbl).insert(pya.Text(text, snap(x), snap(y)))
    top.shapes(l_m2).insert(pya.Text(text, snap(x), snap(y)))

def route_pin_to_bus(x_pin, y_pin, y_bus_m2):
    # 1. At pin: M1 -> Via1 -> M2 -> Via2 -> M3 stack
    add_box(l_m1, x_pin - 190, y_pin - 190, x_pin + 190, y_pin + 190)
    add_box(l_via1, x_pin - 130, y_pin - 130, x_pin + 130, y_pin + 130)
    add_box(l_m2, x_pin - 190, y_pin - 190, x_pin + 190, y_pin + 190)
    add_box(l_via2, x_pin - 130, y_pin - 130, x_pin + 130, y_pin + 130)
    add_box(l_m3, x_pin - 190, y_pin - 190, x_pin + 190, y_pin + 190)
    
    # 2. Vertical M3 stem across cell up to y_bus_m2
    add_box(l_m3, x_pin - 150, min(y_pin, y_bus_m2), x_pin + 150, max(y_pin, y_bus_m2))
    
    # 3. At y_bus_m2: M3 -> Via2 -> M2 stack
    add_box(l_m3, x_pin - 190, y_bus_m2 - 190, x_pin + 190, y_bus_m2 + 190)
    add_box(l_via2, x_pin - 130, y_bus_m2 - 130, x_pin + 130, y_bus_m2 + 130)
    add_box(l_m2, x_pin - 190, y_bus_m2 - 190, x_pin + 190, y_bus_m2 + 190)

stage_x = [0]
cur_x = 76000
for i in range(8):
    stage_x.append(cur_x)
    cur_x += 64000

total_w = cur_x + 4000

# Place instances
top.insert(pya.CellInstArray(cell_dff_set.cell_index(), pya.Trans(stage_x[0], 0)))
for i in range(1, 9):
    top.insert(pya.CellInstArray(cell_dff.cell_index(), pya.Trans(stage_x[i], 0)))

# Continuous power rails & N-Well
vdd_y1 = 6800 + 2500
vdd_y2 = 6800 + 3500
vss_y1 = -2500
vss_y2 = -1500
add_box(l_nw, 0, 6800 - 1500, total_w, vdd_y2 + 500)
add_box(l_m1, 0, vdd_y1, total_w, vdd_y2)
add_label_m1('VDD', total_w/2, vdd_y1 + 500)
add_box(l_m1, 0, vss_y1, total_w, vss_y2)
add_label_m1('VSS', total_w/2, vss_y1 + 500)

# Global Clock, Reset, and Interstage Q-D on Metal 2 ABOVE the cell
T_CLK_M2 = 12000
T_RST_M2 = 13000
T_QD_M2  = 14000

# Stage 0 (dff_cell_set):
# clk (Col 1 = 9330, y=1000)
st0_clk_x = stage_x[0] + 9330
route_pin_to_bus(st0_clk_x, 1000, T_CLK_M2)

# rst_n (Col 8 = 51330, y=3900)
st0_rst_x = stage_x[0] + 51330
route_pin_to_bus(st0_rst_x, 3900, T_RST_M2)

# serial_in (Col 0 = 3330, y=3900)
st0_d_x = stage_x[0] + 3330
add_label_m1('serial_in', st0_d_x, 3900)

# Stages 1..8 (dff_cell):
for i in range(1, 9):
    # clk (Col 0 = 3330, y=1300)
    st_clk_x = stage_x[i] + 3330
    route_pin_to_bus(st_clk_x, 1300, T_CLK_M2)

    # rst_n (Col 7 = 45330, y=3400)
    st_rst_x = stage_x[i] + 45330
    route_pin_to_bus(st_rst_x, 3400, T_RST_M2)

# Global bus lines on Metal 2
add_box(l_m2, 0, T_CLK_M2 - 140, total_w, T_CLK_M2 + 140)
add_label_m2('clk', 2000, T_CLK_M2)

add_box(l_m2, 0, T_RST_M2 - 140, total_w, T_RST_M2 + 140)
add_label_m2('rst_n', 2000, T_RST_M2)

# Stage 0 Q to Stage 1 D (Q0)
q0_x1 = stage_x[0] + 68780
q0_x2 = stage_x[1] + 9330
route_pin_to_bus(q0_x1, 3900, T_QD_M2)
route_pin_to_bus(q0_x2, 3400, T_QD_M2)
add_box(l_m2, q0_x1 - 190, T_QD_M2 - 140, q0_x2 + 190, T_QD_M2 + 140)
add_label_m2('Q0', (q0_x1 + q0_x2)/2, T_QD_M2)

# Stages 1..7 Q to D (Q1..Q7)
q_names = ['Q1', 'Q2', 'Q3', 'Q4', 'Q5', 'Q6', 'Q7']
for idx, qname in enumerate(q_names, 1):
    q_x1 = stage_x[idx] + 50780
    q_x2 = stage_x[idx+1] + 9330
    route_pin_to_bus(q_x1, 3400, T_QD_M2)
    route_pin_to_bus(q_x2, 3400, T_QD_M2)
    add_box(l_m2, q_x1 - 190, T_QD_M2 - 140, q_x2 + 190, T_QD_M2 + 140)
    add_label_m2(qname, (q_x1 + q_x2)/2, T_QD_M2)

# Stage 8 Q (done)
q8_x = stage_x[8] + 50780
route_pin_to_bus(q8_x, 3400, T_QD_M2)
add_label_m2('done', q8_x, T_QD_M2)

# Flatten top cell and merge shapes
top.flatten(-1, True)
snap_to_grid(layout, 5)

layout.write('/foss/designs/chipathon26-SAR_ADC/layout/shift_reg_8bit.gds')
print('Generated shift_reg_8bit.gds!')
