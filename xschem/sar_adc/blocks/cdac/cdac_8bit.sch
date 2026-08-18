v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 900 -400 950 -400 {lab=vdac}
N -800 -400 -750 -400 {lab=vref}
C {ipin.sym} -800 -400 0 0 {name=p_vref lab=vref}
C {lab_wire.sym} -750 -400 0 0 {name=l_vref lab=vref}
C {iopin.sym} -750 -300 0 0 {name=p_vdd lab=vdd}
C {lab_wire.sym} -750 -300 0 0 {name=l_vdd lab=vdd}
C {iopin.sym} -750 -270 0 0 {name=p_vss lab=vss}
C {lab_wire.sym} -750 -270 0 0 {name=l_vss lab=vss}
C {ipin.sym} -430 -280 0 0 {name=p_din lab=dac_in[7:0]}
C {lab_wire.sym} -430 -280 0 0 {name=l_din lab=dac_in[7:0]}
C {opin.sym} 950 -400 0 0 {name=p_vdac lab=vdac}
C {lab_wire.sym} 900 -400 2 0 {name=l_vdac lab=vdac}
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} -880 250 0 0 {name=XSW0}
C {lab_wire.sym} -1030 220 0 0 {name=l_sw0_b lab=dac_in[0]}
C {lab_wire.sym} -730 220 2 0 {name=l_sw0_vr lab=vref}
C {lab_wire.sym} -730 240 2 0 {name=l_sw0_vd lab=vdd}
C {lab_wire.sym} -730 260 2 0 {name=l_sw0_vs lab=vss}
C {lab_wire.sym} -730 280 2 0 {name=l_sw0_bot lab=bot0}
C {capa.sym} -660 -150 0 0 {name=C0 value=2f m=1}
C {lab_wire.sym} -660 -180 2 0 {name=l_c0_top lab=vdac}
C {lab_wire.sym} -660 -120 0 0 {name=l_c0_bot lab=bot0}
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} -440 250 0 0 {name=XSW1}
C {lab_wire.sym} -590 220 0 0 {name=l_sw1_b lab=dac_in[1]}
C {lab_wire.sym} -290 220 2 0 {name=l_sw1_vr lab=vref}
C {lab_wire.sym} -290 240 2 0 {name=l_sw1_vd lab=vdd}
C {lab_wire.sym} -290 260 2 0 {name=l_sw1_vs lab=vss}
C {lab_wire.sym} -290 280 2 0 {name=l_sw1_bot lab=bot1}
C {capa.sym} -570 -150 0 0 {name=C1 value=4f m=1}
C {lab_wire.sym} -570 -180 2 0 {name=l_c1_top lab=vdac}
C {lab_wire.sym} -570 -120 0 0 {name=l_c1_bot lab=bot1}
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} -30 250 0 0 {name=XSW2}
C {lab_wire.sym} -180 220 0 0 {name=l_sw2_b lab=dac_in[2]}
C {lab_wire.sym} 120 220 2 0 {name=l_sw2_vr lab=vref}
C {lab_wire.sym} 120 240 2 0 {name=l_sw2_vd lab=vdd}
C {lab_wire.sym} 120 260 2 0 {name=l_sw2_vs lab=vss}
C {lab_wire.sym} 120 280 2 0 {name=l_sw2_bot lab=bot2}
C {capa.sym} -470 -150 0 0 {name=C2 value=8f m=1}
C {lab_wire.sym} -470 -180 2 0 {name=l_c2_top lab=vdac}
C {lab_wire.sym} -470 -120 0 0 {name=l_c2_bot lab=bot2}
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} 370 250 0 0 {name=XSW3}
C {lab_wire.sym} 220 220 0 0 {name=l_sw3_b lab=dac_in[3]}
C {lab_wire.sym} 520 220 2 0 {name=l_sw3_vr lab=vref}
C {lab_wire.sym} 520 240 2 0 {name=l_sw3_vd lab=vdd}
C {lab_wire.sym} 520 260 2 0 {name=l_sw3_vs lab=vss}
C {lab_wire.sym} 520 280 2 0 {name=l_sw3_bot lab=bot3}
C {capa.sym} -360 -150 0 0 {name=C3 value=16f m=1}
C {lab_wire.sym} -360 -180 2 0 {name=l_c3_top lab=vdac}
C {lab_wire.sym} -360 -120 0 0 {name=l_c3_bot lab=bot3}
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} 780 250 0 0 {name=XSW4}
C {lab_wire.sym} 630 220 0 0 {name=l_sw4_b lab=dac_in[4]}
C {lab_wire.sym} 930 220 2 0 {name=l_sw4_vr lab=vref}
C {lab_wire.sym} 930 240 2 0 {name=l_sw4_vd lab=vdd}
C {lab_wire.sym} 930 260 2 0 {name=l_sw4_vs lab=vss}
C {lab_wire.sym} 930 280 2 0 {name=l_sw4_bot lab=bot4}
C {capa.sym} -260 -150 0 0 {name=C4 value=32f m=1}
C {lab_wire.sym} -260 -180 2 0 {name=l_c4_top lab=vdac}
C {lab_wire.sym} -260 -120 0 0 {name=l_c4_bot lab=bot4}
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} 1210 250 0 0 {name=XSW5}
C {lab_wire.sym} 1060 220 0 0 {name=l_sw5_b lab=dac_in[5]}
C {lab_wire.sym} 1360 220 2 0 {name=l_sw5_vr lab=vref}
C {lab_wire.sym} 1360 240 2 0 {name=l_sw5_vd lab=vdd}
C {lab_wire.sym} 1360 260 2 0 {name=l_sw5_vs lab=vss}
C {lab_wire.sym} 1360 280 2 0 {name=l_sw5_bot lab=bot5}
C {capa.sym} -160 -150 0 0 {name=C5 value=64f m=1}
C {lab_wire.sym} -160 -180 2 0 {name=l_c5_top lab=vdac}
C {lab_wire.sym} -160 -120 0 0 {name=l_c5_bot lab=bot5}
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} 1630 250 0 0 {name=XSW6}
C {lab_wire.sym} 1480 220 0 0 {name=l_sw6_b lab=dac_in[6]}
C {lab_wire.sym} 1780 220 2 0 {name=l_sw6_vr lab=vref}
C {lab_wire.sym} 1780 240 2 0 {name=l_sw6_vd lab=vdd}
C {lab_wire.sym} 1780 260 2 0 {name=l_sw6_vs lab=vss}
C {lab_wire.sym} 1780 280 2 0 {name=l_sw6_bot lab=bot6}
C {capa.sym} -60 -150 0 0 {name=C6 value=128f m=1}
C {lab_wire.sym} -60 -180 2 0 {name=l_c6_top lab=vdac}
C {lab_wire.sym} -60 -120 0 0 {name=l_c6_bot lab=bot6}
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} 2100 250 0 0 {name=XSW7}
C {lab_wire.sym} 1950 220 0 0 {name=l_sw7_b lab=dac_in[7]}
C {lab_wire.sym} 2250 220 2 0 {name=l_sw7_vr lab=vref}
C {lab_wire.sym} 2250 240 2 0 {name=l_sw7_vd lab=vdd}
C {lab_wire.sym} 2250 260 2 0 {name=l_sw7_vs lab=vss}
C {lab_wire.sym} 2250 280 2 0 {name=l_sw7_bot lab=bot7}
C {capa.sym} 30 -150 0 0 {name=C7 value=256f m=1}
C {lab_wire.sym} 30 -180 2 0 {name=l_c7_top lab=vdac}
C {lab_wire.sym} 30 -120 0 0 {name=l_c7_bot lab=bot7}
C {capa.sym} -800 -150 0 0 {name=CDummy value=2f m=1}
C {lab_wire.sym} -800 -180 2 0 {name=l_cdum_top lab=vdac}
C {lab_wire.sym} -800 -120 0 0 {name=l_cdum_bot lab=vss}
C {res.sym} 0 -300 0 0 {name=R_dc value=100G m=1}
C {lab_wire.sym} 0 -330 2 0 {name=l_rdc_top lab=vdac}
C {lab_wire.sym} 0 -270 0 0 {name=l_rdc_bot lab=vss}
C {title.sym} -690 380 0 0 {name=l_title author="Berkah Saluyu"}
