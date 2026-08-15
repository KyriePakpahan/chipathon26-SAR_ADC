v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
# Main Input Pins
C {ipin.sym} -1600 -100 0 0 {name=p_sin lab=serial_in}
C {lab_wire.sym} -1550 -100 0 0 {name=l_sin lab=serial_in}
C {ipin.sym} -1600 -50 0 0 {name=p_clk lab=clk}
C {lab_wire.sym} -1550 -50 0 0 {name=l_clk lab=clk}
C {ipin.sym} -1600 0 0 0 {name=p_rst lab=rst_n}
C {lab_wire.sym} -1550 0 0 0 {name=l_rst lab=rst_n}

# Output Pins
C {opin.sym} -1150 -120 0 0 {name=p_q0 lab=Q0}
C {lab_wire.sym} -1150 -120 0 0 {name=l_q0 lab=Q0}
C {opin.sym} -800 -120 0 0 {name=p_q1 lab=Q1}
C {lab_wire.sym} -800 -120 0 0 {name=l_q1 lab=Q1}
C {opin.sym} -450 -120 0 0 {name=p_q2 lab=Q2}
C {lab_wire.sym} -450 -120 0 0 {name=l_q2 lab=Q2}
C {opin.sym} -100 -120 0 0 {name=p_q3 lab=Q3}
C {lab_wire.sym} -100 -120 0 0 {name=l_q3 lab=Q3}
C {opin.sym} 250 -120 0 0 {name=p_q4 lab=Q4}
C {lab_wire.sym} 250 -120 0 0 {name=l_q4 lab=Q4}
C {opin.sym} 600 -120 0 0 {name=p_q5 lab=Q5}
C {lab_wire.sym} 600 -120 0 0 {name=l_q5 lab=Q5}
C {opin.sym} 950 -120 0 0 {name=p_q6 lab=Q6}
C {lab_wire.sym} 950 -120 0 0 {name=l_q6 lab=Q6}
C {opin.sym} 1300 -120 0 0 {name=p_q7 lab=Q7}
C {lab_wire.sym} 1300 -120 0 0 {name=l_q7 lab=Q7}
C {opin.sym} 1650 -120 0 0 {name=p_done lab=done}
C {lab_wire.sym} 1650 -120 0 0 {name=l_done lab=done}

# Stage 0: DFF with Set (Preset to 1 on reset)
C {sar_adc/blocks/async_sar/dff_cell_set.sym} -1300 0 0 0 {name=x1}
N -1500 -20 -1450 -20 {lab=serial_in}
C {lab_wire.sym} -1500 -20 0 0 {name=l_w_sin lab=serial_in}
N -1500 0 -1450 0 {lab=clk}
C {lab_wire.sym} -1500 0 0 0 {name=l_w_clk0 lab=clk}
N -1500 20 -1450 20 {lab=rst_n}
C {lab_wire.sym} -1500 20 0 0 {name=l_w_rst0 lab=rst_n}
N -1150 -20 -1100 -20 {lab=Q0}
N -1150 -120 -1150 -20 {lab=Q0}

# Stage 1: DFF 1
C {sar_adc/blocks/async_sar/dff_cell.sym} -950 0 0 0 {name=x2}
N -1150 0 -1100 0 {lab=clk}
C {lab_wire.sym} -1150 0 0 0 {name=l_w_clk1 lab=clk}
N -1150 20 -1100 20 {lab=rst_n}
C {lab_wire.sym} -1150 20 0 0 {name=l_w_rst1 lab=rst_n}
N -800 -20 -750 -20 {lab=Q1}
N -800 -120 -800 -20 {lab=Q1}

# Stage 2: DFF 2
C {sar_adc/blocks/async_sar/dff_cell.sym} -600 0 0 0 {name=x3}
N -800 0 -750 0 {lab=clk}
C {lab_wire.sym} -800 0 0 0 {name=l_w_clk2 lab=clk}
N -800 20 -750 20 {lab=rst_n}
C {lab_wire.sym} -800 20 0 0 {name=l_w_rst2 lab=rst_n}
N -450 -20 -400 -20 {lab=Q2}
N -450 -120 -450 -20 {lab=Q2}

# Stage 3: DFF 3
C {sar_adc/blocks/async_sar/dff_cell.sym} -250 0 0 0 {name=x4}
N -450 0 -400 0 {lab=clk}
C {lab_wire.sym} -450 0 0 0 {name=l_w_clk3 lab=clk}
N -450 20 -400 20 {lab=rst_n}
C {lab_wire.sym} -450 20 0 0 {name=l_w_rst3 lab=rst_n}
N -100 -20 -50 -20 {lab=Q3}
N -100 -120 -100 -20 {lab=Q3}

# Stage 4: DFF 4
C {sar_adc/blocks/async_sar/dff_cell.sym} 100 0 0 0 {name=x5}
N -100 0 -50 0 {lab=clk}
C {lab_wire.sym} -100 0 0 0 {name=l_w_clk4 lab=clk}
N -100 20 -50 20 {lab=rst_n}
C {lab_wire.sym} -100 20 0 0 {name=l_w_rst4 lab=rst_n}
N 250 -20 300 -20 {lab=Q4}
N 250 -120 250 -20 {lab=Q4}

# Stage 5: DFF 5
C {sar_adc/blocks/async_sar/dff_cell.sym} 450 0 0 0 {name=x6}
N 250 0 300 0 {lab=clk}
C {lab_wire.sym} 250 0 0 0 {name=l_w_clk5 lab=clk}
N 250 20 300 20 {lab=rst_n}
C {lab_wire.sym} 250 20 0 0 {name=l_w_rst5 lab=rst_n}
N 600 -20 650 -20 {lab=Q5}
N 600 -120 600 -20 {lab=Q5}

# Stage 6: DFF 6
C {sar_adc/blocks/async_sar/dff_cell.sym} 800 0 0 0 {name=x7}
N 600 0 650 0 {lab=clk}
C {lab_wire.sym} 600 0 0 0 {name=l_w_clk6 lab=clk}
N 600 20 650 20 {lab=rst_n}
C {lab_wire.sym} 600 20 0 0 {name=l_w_rst6 lab=rst_n}
N 950 -20 1000 -20 {lab=Q6}
N 950 -120 950 -20 {lab=Q6}

# Stage 7: DFF 7
C {sar_adc/blocks/async_sar/dff_cell.sym} 1150 0 0 0 {name=x8}
N 950 0 1000 0 {lab=clk}
C {lab_wire.sym} 950 0 0 0 {name=l_w_clk7 lab=clk}
N 950 20 1000 20 {lab=rst_n}
C {lab_wire.sym} 950 20 0 0 {name=l_w_rst7 lab=rst_n}
N 1300 -20 1350 -20 {lab=Q7}
N 1300 -120 1300 -20 {lab=Q7}

# Stage 8: DFF Done
C {sar_adc/blocks/async_sar/dff_cell.sym} 1500 0 0 0 {name=x9}
N 1300 0 1350 0 {lab=clk}
C {lab_wire.sym} 1300 0 0 0 {name=l_w_clk8 lab=clk}
N 1300 20 1350 20 {lab=rst_n}
C {lab_wire.sym} 1300 20 0 0 {name=l_w_rst8 lab=rst_n}
N 1650 -20 1700 -20 {lab=done}
N 1650 -120 1650 -20 {lab=done}

C {title.sym} 160 200 0 0 {name=l_title author="Berkah Saluyu"}
