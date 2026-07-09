v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -1600 70 -1540 70 {lab=serial_in}
N -1600 110 -1540 110 {lab=clk}
N -1600 150 -1540 150 {lab=rst_n}
N -1190 -60 -1190 -20 {lab=Q0}
N -790 -60 -790 -20 {lab=Q1}
N -370 -60 -370 -20 {lab=Q2}
N 30 -60 30 -20 {lab=Q3}
N 440 -60 440 -20 {lab=Q4}
N 840 -60 840 -20 {lab=Q5}
N 1240 -60 1240 -20 {lab=Q6}
N 1650 -60 1650 -20 {lab=Q7}
N 2050 -60 2050 -20 {lab=done}
C {title.sym} -1470 350 0 0 {name=l1 author="Berkah Saluyu"}
C {ipin.sym} -1600 70 0 0 {name=p1 lab=serial_in}
C {lab_wire.sym} -1540 70 2 0 {name=p1_lab lab=serial_in}
C {ipin.sym} -1600 110 0 0 {name=p10 lab=clk}
C {lab_wire.sym} -1540 110 2 0 {name=p12 lab=clk}
C {ipin.sym} -1600 150 0 0 {name=p11 lab=rst_n}
C {lab_wire.sym} -1540 150 2 0 {name=p13 lab=rst_n}
C {opin.sym} -1190 -60 3 0 {name=p_out_0 lab=Q0}
C {lab_wire.sym} -1190 -40 2 0 {name=l_po_0 lab=Q0}
C {opin.sym} -790 -60 3 0 {name=p_out_1 lab=Q1}
C {lab_wire.sym} -790 -60 2 0 {name=l_po_1 lab=Q1}
C {opin.sym} -370 -60 3 0 {name=p_out_2 lab=Q2}
C {lab_wire.sym} -370 -60 2 0 {name=l_po_2 lab=Q2}
C {opin.sym} 30 -60 3 0 {name=p_out_3 lab=Q3}
C {lab_wire.sym} 30 -60 2 0 {name=l_po_3 lab=Q3}
C {opin.sym} 440 -60 3 0 {name=p_out_4 lab=Q4}
C {lab_wire.sym} 440 -60 2 0 {name=l_po_4 lab=Q4}
C {opin.sym} 840 -60 3 0 {name=p_out_5 lab=Q5}
C {lab_wire.sym} 840 -60 2 0 {name=l_po_5 lab=Q5}
C {opin.sym} 1240 -60 3 0 {name=p_out_6 lab=Q6}
C {lab_wire.sym} 1240 -60 2 0 {name=l_po_6 lab=Q6}
C {opin.sym} 1650 -60 3 0 {name=p_out_7 lab=Q7}
C {lab_wire.sym} 1650 -60 2 0 {name=l_po_7 lab=Q7}
C {opin.sym} 2050 -60 3 0 {name=p_out_8 lab=done}
C {lab_wire.sym} 2050 -60 2 0 {name=l_po_8 lab=done}
C {sar_adc/blocks/async_sar/dff_cell.sym} -1340 0 0 0 {name=x1}
C {lab_wire.sym} -1490 -20 0 0 {name=l_d_0 lab=serial_in}
C {lab_wire.sym} -1490 0 0 0 {name=l_clk_0 lab=clk}
C {lab_wire.sym} -1490 20 0 0 {name=l_rst_0 lab=rst_n}
C {lab_wire.sym} -1190 -60 2 0 {name=l_q_0 lab=Q0}
C {sar_adc/blocks/async_sar/dff_cell.sym} -940 0 0 0 {name=x2}
C {lab_wire.sym} -1090 -20 0 0 {name=l_d_1 lab=Q0}
C {lab_wire.sym} -1090 0 0 0 {name=l_clk_1 lab=clk}
C {lab_wire.sym} -1090 20 0 0 {name=l_rst_1 lab=rst_n}
C {lab_wire.sym} -790 -20 2 0 {name=l_q_1 lab=Q1}
C {sar_adc/blocks/async_sar/dff_cell.sym} -520 0 0 0 {name=x3}
C {lab_wire.sym} -670 -20 0 0 {name=l_d_2 lab=Q1}
C {lab_wire.sym} -670 0 0 0 {name=l_clk_2 lab=clk}
C {lab_wire.sym} -670 20 0 0 {name=l_rst_2 lab=rst_n}
C {lab_wire.sym} -370 -20 2 0 {name=l_q_2 lab=Q2}
C {sar_adc/blocks/async_sar/dff_cell.sym} -120 0 0 0 {name=x4}
C {lab_wire.sym} -270 -20 0 0 {name=l_d_3 lab=Q2}
C {lab_wire.sym} -270 0 0 0 {name=l_clk_3 lab=clk}
C {lab_wire.sym} -270 20 0 0 {name=l_rst_3 lab=rst_n}
C {lab_wire.sym} 30 -20 2 0 {name=l_q_3 lab=Q3}
C {sar_adc/blocks/async_sar/dff_cell.sym} 290 0 0 0 {name=x5}
C {lab_wire.sym} 140 -20 0 0 {name=l_d_4 lab=Q3}
C {lab_wire.sym} 140 0 0 0 {name=l_clk_4 lab=clk}
C {lab_wire.sym} 140 20 0 0 {name=l_rst_4 lab=rst_n}
C {lab_wire.sym} 440 -20 2 0 {name=l_q_4 lab=Q4}
C {sar_adc/blocks/async_sar/dff_cell.sym} 690 0 0 0 {name=x6}
C {lab_wire.sym} 540 -20 0 0 {name=l_d_5 lab=Q4}
C {lab_wire.sym} 540 0 0 0 {name=l_clk_5 lab=clk}
C {lab_wire.sym} 540 20 0 0 {name=l_rst_5 lab=rst_n}
C {lab_wire.sym} 840 -20 2 0 {name=l_q_5 lab=Q5}
C {sar_adc/blocks/async_sar/dff_cell.sym} 1090 0 0 0 {name=x7}
C {lab_wire.sym} 940 -20 0 0 {name=l_d_6 lab=Q5}
C {lab_wire.sym} 940 0 0 0 {name=l_clk_6 lab=clk}
C {lab_wire.sym} 940 20 0 0 {name=l_rst_6 lab=rst_n}
C {lab_wire.sym} 1240 -20 2 0 {name=l_q_6 lab=Q6}
C {sar_adc/blocks/async_sar/dff_cell.sym} 1500 0 0 0 {name=x8}
C {lab_wire.sym} 1350 -20 0 0 {name=l_d_7 lab=Q6}
C {lab_wire.sym} 1350 0 0 0 {name=l_clk_7 lab=clk}
C {lab_wire.sym} 1350 20 0 0 {name=l_rst_7 lab=rst_n}
C {lab_wire.sym} 1650 -20 2 0 {name=l_q_7 lab=Q7}
C {sar_adc/blocks/async_sar/dff_cell.sym} 1900 0 0 0 {name=x9}
C {lab_wire.sym} 1750 -20 0 0 {name=l_d_8 lab=Q7}
C {lab_wire.sym} 1750 0 0 0 {name=l_clk_8 lab=clk}
C {lab_wire.sym} 1750 20 0 0 {name=l_rst_8 lab=rst_n}
C {lab_wire.sym} 2050 -20 2 0 {name=l_q_8 lab=done}
