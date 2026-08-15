import sys, os, types
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

def build_inverter_chain(num_stages, cell_name, out_gds_path):
    layout = pya.Layout()
    layout.dbu = 0.001

    layout.read('/foss/designs/chipathon26-SAR_ADC/layout/async_inverter.gds')
    cell_inv = layout.cell('async_inverter')

    top = layout.create_cell(cell_name)

    l_nw = layout.layer(21, 0)
    l_m1 = layout.layer(34, 0)
    l_m1_lbl = layout.layer(34, 10)
    l_via1 = layout.layer(35, 0)
    l_m2 = layout.layer(36, 0)
    l_m2_lbl = layout.layer(36, 10)
    l_via2 = layout.layer(38, 0)
    l_m3 = layout.layer(42, 0)
    l_m3_lbl = layout.layer(42, 10)

    # Remove text objects from child cell safely
    for l_idx in layout.layer_indexes():
        shapes = cell_inv.shapes(l_idx)
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

    col_pitch = 6000
    total_w = num_stages * col_pitch + 4000

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

    # Place inverter instances
    for i in range(num_stages):
        xc = i * col_pitch
        top.insert(pya.CellInstArray(cell_inv.cell_index(), pya.Trans(xc, 0)))

    # Primary Input: 'in' at Stage 0 input (xc = 0, x = 3330)
    st0_in_x = 3330
    add_label_m1('in', st0_in_x, 3000)

    # Alternating bus tracks on Metal 2 above cell
    tracks = [12000, 13000]
    for i in range(num_stages - 1):
        y_track = tracks[i % 2]
        out_orig_x = i * col_pitch + 2770
        out_x = i * col_pitch + 2000
        # M1 dogleg at y=4500
        add_box(l_m1, out_x - 190, 4500 - 120, out_orig_x + 190, 4500 + 120)
        
        in_next_x = (i + 1) * col_pitch + 3330
        route_m1_pin_to_bus(out_x, 4500, y_track)
        route_m1_pin_to_bus(in_next_x, 3000, y_track)
        add_box(l_m2, out_x - 190, y_track - 140, in_next_x + 190, y_track + 140)

    # Primary Output: 'out' at Stage (num_stages-1) output
    last_out_x = (num_stages - 1) * col_pitch + 2770
    add_label_m1('out', last_out_x, 3000)

    # Flatten top cell and merge shapes
    top.flatten(-1, True)
    snap_to_grid(layout, 5)

    layout.write(out_gds_path)
    print(f'Generated {out_gds_path} ({num_stages} stages) successfully!')

def build_all():
    build_inverter_chain(21, 'async_delay_chain', '/foss/designs/chipathon26-SAR_ADC/layout/async_delay_chain.gds')
    build_inverter_chain(45, 'async_start_delay', '/foss/designs/chipathon26-SAR_ADC/layout/async_start_delay.gds')

build_all()
