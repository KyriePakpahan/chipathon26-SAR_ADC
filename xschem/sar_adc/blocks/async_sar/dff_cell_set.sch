v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
# Main Input/Output Pins
C {ipin.sym} -600 -120 0 0 {name=p_d lab=D}
C {lab_wire.sym} -550 -120 0 0 {name=l_d lab=D}
C {ipin.sym} -600 -100 0 0 {name=p_clk lab=clk}
C {lab_wire.sym} -550 -100 0 0 {name=l_clk lab=clk}
C {ipin.sym} -600 -80 0 0 {name=p_rst lab=rst_n}
C {lab_wire.sym} -550 -80 0 0 {name=l_rst lab=rst_n}
C {opin.sym} 600 -120 0 0 {name=p_q lab=Q}
C {lab_wire.sym} 550 -120 2 0 {name=l_q lab=Q}

# 1. Invert D -> D_b (placed at -350, -120)
# in at (-500, -120), out at (-200, -120)
C {sar_adc/blocks/async_sar/async_inverter.sym} -350 -120 0 0 {name=x_inv_d}
C {lab_wire.sym} -500 -120 0 0 {name=l_id_in lab=D}
C {lab_wire.sym} -200 -120 2 0 {name=l_id_out lab=D_b}

# 2. Master DFF (placed at 0, -100)
# D at (-150, -120), clk at (-150, -100), rst_n at (-150, -80), Q at (150, -120)
C {sar_adc/blocks/async_sar/dff_cell.sym} 0 -100 0 0 {name=x_dff}
C {lab_wire.sym} -150 -120 0 0 {name=l_df_d lab=D_b}
C {lab_wire.sym} -150 -100 0 0 {name=l_df_c lab=clk}
C {lab_wire.sym} -150 -80 0 0 {name=l_df_r lab=rst_n}

# 3. Invert Q_b -> Q (placed at 300, -120: in at 150, -120; out at 450, -120)
# Direct connection at (150, -120) from x_dff Q pin to x_inv_q input pin!
C {sar_adc/blocks/async_sar/async_inverter.sym} 300 -120 0 0 {name=x_inv_q}
N 450 -120 550 -120 {lab=Q}

C {title.sym} 160 200 0 0 {name=l_title author="Berkah Saluyu"}
