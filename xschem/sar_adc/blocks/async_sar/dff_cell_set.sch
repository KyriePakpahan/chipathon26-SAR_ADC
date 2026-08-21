v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
C {ipin.sym} -600 -120 0 0 {name=p_d lab=D}
C {ipin.sym} -600 -100 0 0 {name=p_clk lab=clk}
C {ipin.sym} -600 -80 0 0 {name=p_rst lab=rst_n}
C {opin.sym} 600 -120 0 0 {name=p_q lab=Q}
C {lab_wire.sym} 450 -60 2 0 {name=l_q lab=Q}
C {sar_adc/blocks/async_sar/async_inverter.sym} -340 -190 0 0 {name=x_inv_d}
C {lab_wire.sym} -490 -210 0 0 {name=l_id_in lab=D}
C {lab_wire.sym} -190 -190 2 0 {name=l_id_out lab=D_b}
C {sar_adc/blocks/async_sar/dff_cell.sym} 0 -100 0 0 {name=x_dff}
C {lab_wire.sym} -150 -120 0 0 {name=l_df_d lab=D_b}
C {lab_wire.sym} -150 -100 0 0 {name=l_df_c lab=clk}
C {lab_wire.sym} -150 -80 0 0 {name=l_df_r lab=rst_n}
C {sar_adc/blocks/async_sar/async_inverter.sym} 300 -60 0 0 {name=x_inv_q}
C {title.sym} -500 110 0 0 {name=l_title author="Berkah Saluyu"}
C {lab_wire.sym} -190 -210 2 0 {name=l_x7 lab=vdd}
C {lab_wire.sym} 150 -120 2 0 {name=l_x1 lab=vdd}
C {lab_wire.sym} 450 -80 2 0 {name=l_x2 lab=vdd}
C {lab_wire.sym} -190 -170 2 0 {name=l_x3 lab=vss}
C {lab_wire.sym} 150 -100 2 0 {name=l_x4 lab=vss}
C {lab_wire.sym} 450 -40 2 0 {name=l_x5 lab=vss
}
C {iopin.sym} -90 -370 0 0 {name=p1 lab=vdd}
C {iopin.sym} -90 -330 0 0 {name=p2 lab=vss}
