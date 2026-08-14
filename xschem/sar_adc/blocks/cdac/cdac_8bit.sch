v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
# Main Input/Output and Supply Pins
C {ipin.sym} -800 -400 0 0 {name=p_vref lab=vref}
C {lab_wire.sym} -750 -400 0 0 {name=l_vref lab=vref}
C {iopin.sym} -800 -300 0 0 {name=p_vdd lab=vdd}
C {lab_wire.sym} -750 -300 0 0 {name=l_vdd lab=vdd}
C {iopin.sym} -800 -200 0 0 {name=p_vss lab=vss}
C {lab_wire.sym} -750 -200 0 0 {name=l_vss lab=vss}
C {ipin.sym} -800 -100 0 0 {name=p_din lab=dac_in[7:0]}
C {lab_wire.sym} -750 -100 0 0 {name=l_din lab=dac_in[7:0]}
C {opin.sym} 950 -400 0 0 {name=p_vdac lab=vdac}
C {lab_wire.sym} 900 -400 2 0 {name=l_vdac lab=vdac}

# 8 CDAC Switches and Capacitors
# Bit 0 (LSB, C0 = 2fF)
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} -600 0 0 0 {name=XSW0}
N -750 -30 -750 -30 {lab=dac_in[0]}
C {lab_wire.sym} -750 -30 0 0 {name=l_sw0_b lab=dac_in[0]}
N -450 -30 -450 -30 {lab=vref}
C {lab_wire.sym} -450 -30 2 0 {name=l_sw0_vr lab=vref}
N -450 -10 -450 -10 {lab=VDD}
C {lab_wire.sym} -450 -10 2 0 {name=l_sw0_vd lab=vdd}
N -450 10 -450 10 {lab=VSS}
C {lab_wire.sym} -450 10 2 0 {name=l_sw0_vs lab=vss}
N -450 30 -450 30 {lab=bot0}
C {lab_wire.sym} -450 30 2 0 {name=l_sw0_bot lab=bot0}
C {capa.sym} -600 -150 0 0 {name=C0 value=2f m=1}
N -600 -180 -600 -180 {lab=vdac}
C {lab_wire.sym} -600 -180 2 0 {name=l_c0_top lab=vdac}
N -600 -120 -600 -120 {lab=bot0}
C {lab_wire.sym} -600 -120 0 0 {name=l_c0_bot lab=bot0}

# Bit 1 (C1 = 4fF)
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} -400 0 0 0 {name=XSW1}
N -550 -30 -550 -30 {lab=dac_in[1]}
C {lab_wire.sym} -550 -30 0 0 {name=l_sw1_b lab=dac_in[1]}
N -250 -30 -250 -30 {lab=vref}
C {lab_wire.sym} -250 -30 2 0 {name=l_sw1_vr lab=vref}
N -250 -10 -250 -10 {lab=VDD}
C {lab_wire.sym} -250 -10 2 0 {name=l_sw1_vd lab=vdd}
N -250 10 -250 10 {lab=VSS}
C {lab_wire.sym} -250 10 2 0 {name=l_sw1_vs lab=vss}
N -250 30 -250 30 {lab=bot1}
C {lab_wire.sym} -250 30 2 0 {name=l_sw1_bot lab=bot1}
C {capa.sym} -400 -150 0 0 {name=C1 value=4f m=1}
N -400 -180 -400 -180 {lab=vdac}
C {lab_wire.sym} -400 -180 2 0 {name=l_c1_top lab=vdac}
N -400 -120 -400 -120 {lab=bot1}
C {lab_wire.sym} -400 -120 0 0 {name=l_c1_bot lab=bot1}

# Bit 2 (C2 = 8fF)
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} -200 0 0 0 {name=XSW2}
N -350 -30 -350 -30 {lab=dac_in[2]}
C {lab_wire.sym} -350 -30 0 0 {name=l_sw2_b lab=dac_in[2]}
N -50 -30 -50 -30 {lab=vref}
C {lab_wire.sym} -50 -30 2 0 {name=l_sw2_vr lab=vref}
N -50 -10 -50 -10 {lab=VDD}
C {lab_wire.sym} -50 -10 2 0 {name=l_sw2_vd lab=vdd}
N -50 10 -50 10 {lab=VSS}
C {lab_wire.sym} -50 10 2 0 {name=l_sw2_vs lab=vss}
N -50 30 -50 30 {lab=bot2}
C {lab_wire.sym} -50 30 2 0 {name=l_sw2_bot lab=bot2}
C {capa.sym} -200 -150 0 0 {name=C2 value=8f m=1}
N -200 -180 -200 -180 {lab=vdac}
C {lab_wire.sym} -200 -180 2 0 {name=l_c2_top lab=vdac}
N -200 -120 -200 -120 {lab=bot2}
C {lab_wire.sym} -200 -120 0 0 {name=l_c2_bot lab=bot2}

# Bit 3 (C3 = 16fF)
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} 0 0 0 0 {name=XSW3}
N -150 -30 -150 -30 {lab=dac_in[3]}
C {lab_wire.sym} -150 -30 0 0 {name=l_sw3_b lab=dac_in[3]}
N 150 -30 150 -30 {lab=vref}
C {lab_wire.sym} 150 -30 2 0 {name=l_sw3_vr lab=vref}
N 150 -10 150 -10 {lab=VDD}
C {lab_wire.sym} 150 -10 2 0 {name=l_sw3_vd lab=vdd}
N 150 10 150 10 {lab=VSS}
C {lab_wire.sym} 150 10 2 0 {name=l_sw3_vs lab=vss}
N 150 30 150 30 {lab=bot3}
C {lab_wire.sym} 150 30 2 0 {name=l_sw3_bot lab=bot3}
C {capa.sym} 0 -150 0 0 {name=C3 value=16f m=1}
N 0 -180 0 -180 {lab=vdac}
C {lab_wire.sym} 0 -180 2 0 {name=l_c3_top lab=vdac}
N 0 -120 0 -120 {lab=bot3}
C {lab_wire.sym} 0 -120 0 0 {name=l_c3_bot lab=bot3}

# Bit 4 (C4 = 32fF)
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} 200 0 0 0 {name=XSW4}
N 50 -30 50 -30 {lab=dac_in[4]}
C {lab_wire.sym} 50 -30 0 0 {name=l_sw4_b lab=dac_in[4]}
N 350 -30 350 -30 {lab=vref}
C {lab_wire.sym} 350 -30 2 0 {name=l_sw4_vr lab=vref}
N 350 -10 350 -10 {lab=VDD}
C {lab_wire.sym} 350 -10 2 0 {name=l_sw4_vd lab=vdd}
N 350 10 350 10 {lab=VSS}
C {lab_wire.sym} 350 10 2 0 {name=l_sw4_vs lab=vss}
N 350 30 350 30 {lab=bot4}
C {lab_wire.sym} 350 30 2 0 {name=l_sw4_bot lab=bot4}
C {capa.sym} 200 -150 0 0 {name=C4 value=32f m=1}
N 200 -180 200 -180 {lab=vdac}
C {lab_wire.sym} 200 -180 2 0 {name=l_c4_top lab=vdac}
N 200 -120 200 -120 {lab=bot4}
C {lab_wire.sym} 200 -120 0 0 {name=l_c4_bot lab=bot4}

# Bit 5 (C5 = 64fF)
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} 400 0 0 0 {name=XSW5}
N 250 -30 250 -30 {lab=dac_in[5]}
C {lab_wire.sym} 250 -30 0 0 {name=l_sw5_b lab=dac_in[5]}
N 550 -30 550 -30 {lab=vref}
C {lab_wire.sym} 550 -30 2 0 {name=l_sw5_vr lab=vref}
N 550 -10 550 -10 {lab=VDD}
C {lab_wire.sym} 550 -10 2 0 {name=l_sw5_vd lab=vdd}
N 550 10 550 10 {lab=VSS}
C {lab_wire.sym} 550 10 2 0 {name=l_sw5_vs lab=vss}
N 550 30 550 30 {lab=bot5}
C {lab_wire.sym} 550 30 2 0 {name=l_sw5_bot lab=bot5}
C {capa.sym} 400 -150 0 0 {name=C5 value=64f m=1}
N 400 -180 400 -180 {lab=vdac}
C {lab_wire.sym} 400 -180 2 0 {name=l_c5_top lab=vdac}
N 400 -120 400 -120 {lab=bot5}
C {lab_wire.sym} 400 -120 0 0 {name=l_c5_bot lab=bot5}

# Bit 6 (C6 = 128fF)
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} 600 0 0 0 {name=XSW6}
N 450 -30 450 -30 {lab=dac_in[6]}
C {lab_wire.sym} 450 -30 0 0 {name=l_sw6_b lab=dac_in[6]}
N 750 -30 750 -30 {lab=vref}
C {lab_wire.sym} 750 -30 2 0 {name=l_sw6_vr lab=vref}
N 750 -10 750 -10 {lab=VDD}
C {lab_wire.sym} 750 -10 2 0 {name=l_sw6_vd lab=vdd}
N 750 10 750 10 {lab=VSS}
C {lab_wire.sym} 750 10 2 0 {name=l_sw6_vs lab=vss}
N 750 30 750 30 {lab=bot6}
C {lab_wire.sym} 750 30 2 0 {name=l_sw6_bot lab=bot6}
C {capa.sym} 600 -150 0 0 {name=C6 value=128f m=1}
N 600 -180 600 -180 {lab=vdac}
C {lab_wire.sym} 600 -180 2 0 {name=l_c6_top lab=vdac}
N 600 -120 600 -120 {lab=bot6}
C {lab_wire.sym} 600 -120 0 0 {name=l_c6_bot lab=bot6}

# Bit 7 (MSB, C7 = 256fF)
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} 800 0 0 0 {name=XSW7}
N 650 -30 650 -30 {lab=dac_in[7]}
C {lab_wire.sym} 650 -30 0 0 {name=l_sw7_b lab=dac_in[7]}
N 950 -30 950 -30 {lab=vref}
C {lab_wire.sym} 950 -30 2 0 {name=l_sw7_vr lab=vref}
N 950 -10 950 -10 {lab=VDD}
C {lab_wire.sym} 950 -10 2 0 {name=l_sw7_vd lab=vdd}
N 950 10 950 10 {lab=VSS}
C {lab_wire.sym} 950 10 2 0 {name=l_sw7_vs lab=vss}
N 950 30 950 30 {lab=bot7}
C {lab_wire.sym} 950 30 2 0 {name=l_sw7_bot lab=bot7}
C {capa.sym} 800 -150 0 0 {name=C7 value=256f m=1}
N 800 -180 800 -180 {lab=vdac}
C {lab_wire.sym} 800 -180 2 0 {name=l_c7_top lab=vdac}
N 800 -120 800 -120 {lab=bot7}
C {lab_wire.sym} 800 -120 0 0 {name=l_c7_bot lab=bot7}

# Dummy Capacitor (C_dummy = 2fF to vss)
C {capa.sym} -800 -150 0 0 {name=CDummy value=2f m=1}
N -800 -180 -800 -180 {lab=vdac}
C {lab_wire.sym} -800 -180 2 0 {name=l_cdum_top lab=vdac}
N -800 -120 -800 -120 {lab=VSS}
C {lab_wire.sym} -800 -120 0 0 {name=l_cdum_bot lab=vss}

# DC Bleed Resistor
C {res.sym} 0 -300 0 0 {name=R_dc value=100G m=1}
N 0 -330 0 -330 {lab=vdac}
C {lab_wire.sym} 0 -330 2 0 {name=l_rdc_top lab=vdac}
N 0 -270 0 -270 {lab=VSS}
C {lab_wire.sym} 0 -270 0 0 {name=l_rdc_bot lab=vss}

C {title.sym} 160 200 0 0 {name=l_title author="Berkah Saluyu"}
