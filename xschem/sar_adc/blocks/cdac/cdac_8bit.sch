v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -800 -400 -650 -400 {lab=vref}
N -800 -340 -650 -340 {lab=vdd}
N -800 -280 -650 -280 {lab=vss}
N -800 -220 -650 -220 {lab=dac_in[7:0]}
N -800 -160 -650 -160 {lab=vdac}
C {title.sym} 160 200 0 0 {name=l1 author="Berkah Saluyu"}
C {ipin.sym} -800 -400 0 0 {name=p_vref lab=vref}
C {lab_wire.sym} -650 -400 2 0 {name=l_vref lab=vref}
C {iopin.sym} -800 -340 0 0 {name=p_vdd lab=vdd}
C {lab_wire.sym} -650 -340 2 0 {name=l_vdd lab=vdd}
C {iopin.sym} -800 -280 0 0 {name=p_vss lab=vss}
C {lab_wire.sym} -650 -280 2 0 {name=l_vss lab=vss}
C {ipin.sym} -800 -220 0 0 {name=p_dac_in lab=dac_in[7:0]}
C {lab_wire.sym} -650 -220 2 0 {name=l_dac_in lab=dac_in[7:0]}
C {opin.sym} -800 -160 0 0 {name=p_vdac lab=vdac}
C {lab_wire.sym} -650 -160 2 0 {name=l_vdac lab=vdac}

# Bit 0 (C0 = 0.0005p / 0.5fF)
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} -400 -50 0 0 {name=XSW0}
C {lab_wire.sym} -550 -80 0 0 {name=l_sw_b0 lab=dac_in[0]}
C {lab_wire.sym} -250 -80 2 0 {name=l_sw_vr0 lab=vref}
C {lab_wire.sym} -250 -60 2 0 {name=l_sw_vd0 lab=vdd}
C {lab_wire.sym} -250 -40 2 0 {name=l_sw_vs0 lab=vss}
C {lab_wire.sym} -250 -20 2 0 {name=l_sw_bt0 lab=bot0}
C {capa.sym} -400 -180 0 0 {name=C0 m=1 value=0.0005p}
C {lab_wire.sym} -400 -210 0 0 {name=l_c0_top lab=vdac}
C {lab_wire.sym} -400 -150 2 0 {name=l_c0_bot lab=bot0}

# Bit 1 (C1 = 0.001p / 1.0fF)
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} 0 -50 0 0 {name=XSW1}
C {lab_wire.sym} -150 -80 0 0 {name=l_sw_b1 lab=dac_in[1]}
C {lab_wire.sym} 150 -80 2 0 {name=l_sw_vr1 lab=vref}
C {lab_wire.sym} 150 -60 2 0 {name=l_sw_vd1 lab=vdd}
C {lab_wire.sym} 150 -40 2 0 {name=l_sw_vs1 lab=vss}
C {lab_wire.sym} 150 -20 2 0 {name=l_sw_bt1 lab=bot1}
C {capa.sym} 0 -180 0 0 {name=C1 m=1 value=0.001p}
C {lab_wire.sym} 0 -210 0 0 {name=l_c1_top lab=vdac}
C {lab_wire.sym} 0 -150 2 0 {name=l_c1_bot lab=bot1}

# Bit 2 (C2 = 0.002p / 2.0fF)
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} 400 -50 0 0 {name=XSW2}
C {lab_wire.sym} 250 -80 0 0 {name=l_sw_b2 lab=dac_in[2]}
C {lab_wire.sym} 550 -80 2 0 {name=l_sw_vr2 lab=vref}
C {lab_wire.sym} 550 -60 2 0 {name=l_sw_vd2 lab=vdd}
C {lab_wire.sym} 550 -40 2 0 {name=l_sw_vs2 lab=vss}
C {lab_wire.sym} 550 -20 2 0 {name=l_sw_bt2 lab=bot2}
C {capa.sym} 400 -180 0 0 {name=C2 m=1 value=0.002p}
C {lab_wire.sym} 400 -210 0 0 {name=l_c2_top lab=vdac}
C {lab_wire.sym} 400 -150 2 0 {name=l_c2_bot lab=bot2}

# Bit 3 (C3 = 0.004p / 4.0fF)
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} 800 -50 0 0 {name=XSW3}
C {lab_wire.sym} 650 -80 0 0 {name=l_sw_b3 lab=dac_in[3]}
C {lab_wire.sym} 950 -80 2 0 {name=l_sw_vr3 lab=vref}
C {lab_wire.sym} 950 -60 2 0 {name=l_sw_vd3 lab=vdd}
C {lab_wire.sym} 950 -40 2 0 {name=l_sw_vs3 lab=vss}
C {lab_wire.sym} 950 -20 2 0 {name=l_sw_bt3 lab=bot3}
C {capa.sym} 800 -180 0 0 {name=C3 m=1 value=0.004p}
C {lab_wire.sym} 800 -210 0 0 {name=l_c3_top lab=vdac}
C {lab_wire.sym} 800 -150 2 0 {name=l_c3_bot lab=bot3}

# Bit 4 (C4 = 0.008p / 8.0fF)
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} 1200 -50 0 0 {name=XSW4}
C {lab_wire.sym} 1050 -80 0 0 {name=l_sw_b4 lab=dac_in[4]}
C {lab_wire.sym} 1350 -80 2 0 {name=l_sw_vr4 lab=vref}
C {lab_wire.sym} 1350 -60 2 0 {name=l_sw_vd4 lab=vdd}
C {lab_wire.sym} 1350 -40 2 0 {name=l_sw_vs4 lab=vss}
C {lab_wire.sym} 1350 -20 2 0 {name=l_sw_bt4 lab=bot4}
C {capa.sym} 1200 -180 0 0 {name=C4 m=1 value=0.008p}
C {lab_wire.sym} 1200 -210 0 0 {name=l_c4_top lab=vdac}
C {lab_wire.sym} 1200 -150 2 0 {name=l_c4_bot lab=bot4}

# Bit 5 (C5 = 0.016p / 16.0fF)
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} 1600 -50 0 0 {name=XSW5}
C {lab_wire.sym} 1450 -80 0 0 {name=l_sw_b5 lab=dac_in[5]}
C {lab_wire.sym} 1750 -80 2 0 {name=l_sw_vr5 lab=vref}
C {lab_wire.sym} 1750 -60 2 0 {name=l_sw_vd5 lab=vdd}
C {lab_wire.sym} 1750 -40 2 0 {name=l_sw_vs5 lab=vss}
C {lab_wire.sym} 1750 -20 2 0 {name=l_sw_bt5 lab=bot5}
C {capa.sym} 1600 -180 0 0 {name=C5 m=1 value=0.016p}
C {lab_wire.sym} 1600 -210 0 0 {name=l_c5_top lab=vdac}
C {lab_wire.sym} 1600 -150 2 0 {name=l_c5_bot lab=bot5}

# Bit 6 (C6 = 0.032p / 32.0fF)
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} 2000 -50 0 0 {name=XSW6}
C {lab_wire.sym} 1850 -80 0 0 {name=l_sw_b6 lab=dac_in[6]}
C {lab_wire.sym} 2150 -80 2 0 {name=l_sw_vr6 lab=vref}
C {lab_wire.sym} 2150 -60 2 0 {name=l_sw_vd6 lab=vdd}
C {lab_wire.sym} 2150 -40 2 0 {name=l_sw_vs6 lab=vss}
C {lab_wire.sym} 2150 -20 2 0 {name=l_sw_bt6 lab=bot6}
C {capa.sym} 2000 -180 0 0 {name=C6 m=1 value=0.032p}
C {lab_wire.sym} 2000 -210 0 0 {name=l_c6_top lab=vdac}
C {lab_wire.sym} 2000 -150 2 0 {name=l_c6_bot lab=bot6}

# Bit 7 (C7 = 0.064p / 64.0fF)
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} 2400 -50 0 0 {name=XSW7}
C {lab_wire.sym} 2250 -80 0 0 {name=l_sw_b7 lab=dac_in[7]}
C {lab_wire.sym} 2550 -80 2 0 {name=l_sw_vr7 lab=vref}
C {lab_wire.sym} 2550 -60 2 0 {name=l_sw_vd7 lab=vdd}
C {lab_wire.sym} 2550 -40 2 0 {name=l_sw_vs7 lab=vss}
C {lab_wire.sym} 2550 -20 2 0 {name=l_sw_bt7 lab=bot7}
C {capa.sym} 2400 -180 0 0 {name=C7 m=1 value=0.064p}
C {lab_wire.sym} 2400 -210 0 0 {name=l_c7_top lab=vdac}
C {lab_wire.sym} 2400 -150 2 0 {name=l_c7_bot lab=bot7}

# Dummy Cap (0.5fF) & Bleed Resistor
C {capa.sym} 2800 -180 0 0 {name=CDummy m=1 value=0.0005p}
C {lab_wire.sym} 2800 -210 0 0 {name=l_cdum_top lab=vdac}
C {lab_wire.sym} 2800 -150 2 0 {name=l_cdum_bot lab=vss}

C {res.sym} 3000 -180 0 0 {name=Rdc value=100MEG}
C {lab_wire.sym} 3000 -210 0 0 {name=l_rdc_top lab=vdac}
C {lab_wire.sym} 3000 -150 2 0 {name=l_rdc_bot lab=vss}
