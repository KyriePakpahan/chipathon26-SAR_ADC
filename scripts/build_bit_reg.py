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

layout.read('/foss/designs/chipathon26-SAR_ADC/layout/async_inverter.gds')
layout.read('/foss/designs/chipathon26-SAR_ADC/layout/async_nand2.gds')
layout.read('/foss/designs/chipathon26-SAR_ADC/layout/async_nor2.gds')

cell_inv  = layout.cell('async_inverter')
cell_nand = layout.cell('async_nand2')
cell_nor  = layout.cell('async_nor2')

top = layout.create_cell('bit_reg')

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
for cell in [cell_inv, cell_nand, cell_nor]:
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

def route_m1_pin_to_bus(x_pin, y_pin, y_bus_m2):
    # 1. At pin: M1 -> Via1 -> M2 -> Via2 -> M3 stack
    add_box(l_m1, x_pin - 140, y_pin - 190, x_pin + 140, y_pin + 190)
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

def route_m2_pin_to_bus(x_pin, y_pin, y_bus_m2):
    # 1. At pin: M2 -> Via2 -> M3 stack
    add_box(l_m2, x_pin - 190, y_pin - 190, x_pin + 190, y_pin + 190)
    add_box(l_via2, x_pin - 130, y_pin - 130, x_pin + 130, y_pin + 130)
    add_box(l_m3, x_pin - 190, y_pin - 190, x_pin + 190, y_pin + 190)
    
    # 2. Vertical M3 stem across cell up to y_bus_m2
    add_box(l_m3, x_pin - 150, min(y_pin, y_bus_m2), x_pin + 150, max(y_pin, y_bus_m2))
    
    # 3. At y_bus_m2: M3 -> Via2 -> M2 stack
    add_box(l_m3, x_pin - 190, y_bus_m2 - 190, x_pin + 190, y_bus_m2 + 190)
    add_box(l_via2, x_pin - 130, y_bus_m2 - 130, x_pin + 130, y_bus_m2 + 130)
    add_box(l_m2, x_pin - 190, y_bus_m2 - 190, x_pin + 190, y_bus_m2 + 190)

x_pos = [0, 6000, 24000, 36000, 72000]
total_w = 72000 + 36000 + 4000

top.insert(pya.CellInstArray(cell_inv.cell_index(), pya.Trans(x_pos[0], 0)))
top.insert(pya.CellInstArray(cell_nand.cell_index(), pya.Trans(x_pos[1], 0)))
top.insert(pya.CellInstArray(cell_inv.cell_index(), pya.Trans(x_pos[2], 0)))
top.insert(pya.CellInstArray(cell_nor.cell_index(), pya.Trans(x_pos[3], 0)))
top.insert(pya.CellInstArray(cell_nor.cell_index(), pya.Trans(x_pos[4], 0)))

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

# Dedicated Metal 2 Bus Tracks above the cell
T_RST_M2  = 12000
T_SETN_M2 = 13000
T_SET_M2  = 14000
T_BO_M2   = 15000
T_BOB_M2  = 16000

# 1. NET: rst (x_inv_rst Out at y=3000 to x_nor_q In A at y=3000)
rst_x1 = x_pos[0] + 2770
rst_x2 = x_pos[3] + 3330
route_m1_pin_to_bus(rst_x1, 3000, T_RST_M2)
route_m1_pin_to_bus(rst_x2, 3000, T_RST_M2)
add_box(l_m2, rst_x1 - 190, T_RST_M2 - 140, rst_x2 + 190, T_RST_M2 + 140)

# 2. NET: set_n (x_nand_set Out on M2 at y=3000 to x_inv_set In on M1 at y=3000)
setn_x1 = x_pos[1] + 5780
setn_x2 = x_pos[2] + 3330
route_m2_pin_to_bus(setn_x1, 3000, T_SETN_M2)
route_m1_pin_to_bus(setn_x2, 3000, T_SETN_M2)
add_box(l_m2, setn_x1 - 190, T_SETN_M2 - 140, setn_x2 + 190, T_SETN_M2 + 140)

# 3. NET: set (x_inv_set Out on M1 at y=4500, dogleg M1 to x=26000, to x_nor_qb In A at y=3000)
set_orig_x = x_pos[2] + 2770 # 26770
set_x1 = x_pos[2] + 2000     # 26000
add_box(l_m1, set_x1 - 190, 4500 - 120, set_orig_x + 190, 4500 + 120)
set_x2 = x_pos[4] + 3330
route_m1_pin_to_bus(set_x1, 4500, T_SET_M2)
route_m1_pin_to_bus(set_x2, 3000, T_SET_M2)
add_box(l_m2, set_x1 - 190, T_SET_M2 - 140, set_x2 + 190, T_SET_M2 + 140)

# 4. NET: bit_out (x_nor_q Out on M1 at y=3000 to x_nor_qb In B on M1 at y=4000)
bo_x1 = x_pos[3] + 26780
bo_x2 = x_pos[4] + 9330
route_m1_pin_to_bus(bo_x1, 3000, T_BO_M2)
route_m1_pin_to_bus(bo_x2, 4000, T_BO_M2)
add_box(l_m2, bo_x1 - 190, T_BO_M2 - 140, bo_x2 + 190, T_BO_M2 + 140)
add_label_m2('bit_out', (bo_x1 + bo_x2)/2, T_BO_M2)

# 5. NET: bit_out_bar (x_nor_qb Out on M1 at y=3000 to x_nor_q In B on M1 at y=4000)
bob_x1 = x_pos[3] + 9330
bob_x2 = x_pos[4] + 26780
route_m1_pin_to_bus(bob_x1, 4000, T_BOB_M2)
route_m1_pin_to_bus(bob_x2, 3000, T_BOB_M2)
add_box(l_m2, bob_x1 - 190, T_BOB_M2 - 140, bob_x2 + 190, T_BOB_M2 + 140)

# Primary Input Pins:
# rst_n (x_inv_rst In)
rst_n_x = x_pos[0] + 3330
add_label_m1('rst_n', rst_n_x, 3000)

# comp_out (x_nand_set In A)
comp_out_x = x_pos[1] + 3330
add_label_m1('comp_out', comp_out_x, 3000)

# en (x_nand_set In B)
en_x = x_pos[1] + 9330
add_label_m1('en', en_x, 3000)

# Flatten top cell and merge shapes
top.flatten(-1, True)
snap_to_grid(layout, 5)

layout.write('/foss/designs/chipathon26-SAR_ADC/layout/bit_reg.gds')
print('Generated bit_reg.gds successfully!')
