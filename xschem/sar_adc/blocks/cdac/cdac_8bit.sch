v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
C {ipin.sym} -1200 -240 0 0 {name=p_vref lab=vref}
C {ipin.sym} -1200 -200 0 0 {name=p_di7 lab=dac_in[7]}
C {ipin.sym} -1200 -160 0 0 {name=p_di6 lab=dac_in[6]}
C {ipin.sym} -1200 -120 0 0 {name=p_di5 lab=dac_in[5]}
C {ipin.sym} -1200 -80 0 0 {name=p_di4 lab=dac_in[4]}
C {ipin.sym} -1200 -40 0 0 {name=p_di3 lab=dac_in[3]}
C {ipin.sym} -1200 0 0 0 {name=p_di2 lab=dac_in[2]}
C {ipin.sym} -1200 40 0 0 {name=p_di1 lab=dac_in[1]}
C {ipin.sym} -1200 80 0 0 {name=p_di0 lab=dac_in[0]}
C {opin.sym} -1200 140 0 0 {name=p_vdac lab=vdac}
C {iopin.sym} -1200 180 0 0 {name=p_vdd lab=vdd}
C {iopin.sym} -1200 220 0 0 {name=p_vss lab=vss}
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} -700 150 0 0 {name=XSW0}
C {lab_wire.sym} -850 120 0 0 {name=l_sw0_b lab=dac_in[0]}
C {lab_wire.sym} -550 120 2 0 {name=l_sw0_vr lab=vref}
C {lab_wire.sym} -550 140 2 0 {name=l_sw0_vd lab=vdd}
C {lab_wire.sym} -550 160 2 0 {name=l_sw0_vs lab=vss}
C {lab_wire.sym} -550 180 2 0 {name=l_sw0_bot lab=bot0}
C {symbols/cap_mim_2f0fF.sym} -700 -100 0 0 {name=C0 W=5e-6 L=5e-6 model=cap_mim_2f0fF spiceprefix=X m=1}
C {lab_wire.sym} -700 -130 2 0 {name=l_c0_top lab=vdac}
C {lab_wire.sym} -700 -70 0 0 {name=l_c0_bot lab=bot0}
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} -300 150 0 0 {name=XSW1}
C {lab_wire.sym} -450 120 0 0 {name=l_sw1_b lab=dac_in[1]}
C {lab_wire.sym} -150 120 2 0 {name=l_sw1_vr lab=vref}
C {lab_wire.sym} -150 140 2 0 {name=l_sw1_vd lab=vdd}
C {lab_wire.sym} -150 160 2 0 {name=l_sw1_vs lab=vss}
C {lab_wire.sym} -150 180 2 0 {name=l_sw1_bot lab=bot1}
C {symbols/cap_mim_2f0fF.sym} -300 -100 0 0 {name=C1 W=5e-6 L=5e-6 model=cap_mim_2f0fF spiceprefix=X m=2}
C {lab_wire.sym} -300 -130 2 0 {name=l_c1_top lab=vdac}
C {lab_wire.sym} -300 -70 0 0 {name=l_c1_bot lab=bot1}
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} 100 150 0 0 {name=XSW2}
C {lab_wire.sym} -50 120 0 0 {name=l_sw2_b lab=dac_in[2]}
C {lab_wire.sym} 250 120 2 0 {name=l_sw2_vr lab=vref}
C {lab_wire.sym} 250 140 2 0 {name=l_sw2_vd lab=vdd}
C {lab_wire.sym} 250 160 2 0 {name=l_sw2_vs lab=vss}
C {lab_wire.sym} 250 180 2 0 {name=l_sw2_bot lab=bot2}
C {symbols/cap_mim_2f0fF.sym} 100 -100 0 0 {name=C2 W=5e-6 L=5e-6 model=cap_mim_2f0fF spiceprefix=X m=4}
C {lab_wire.sym} 100 -130 2 0 {name=l_c2_top lab=vdac}
C {lab_wire.sym} 100 -70 0 0 {name=l_c2_bot lab=bot2}
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} 500 150 0 0 {name=XSW3}
C {lab_wire.sym} 350 120 0 0 {name=l_sw3_b lab=dac_in[3]}
C {lab_wire.sym} 650 120 2 0 {name=l_sw3_vr lab=vref}
C {lab_wire.sym} 650 140 2 0 {name=l_sw3_vd lab=vdd}
C {lab_wire.sym} 650 160 2 0 {name=l_sw3_vs lab=vss}
C {lab_wire.sym} 650 180 2 0 {name=l_sw3_bot lab=bot3}
C {symbols/cap_mim_2f0fF.sym} 500 -100 0 0 {name=C3 W=5e-6 L=5e-6 model=cap_mim_2f0fF spiceprefix=X m=8}
C {lab_wire.sym} 500 -130 2 0 {name=l_c3_top lab=vdac}
C {lab_wire.sym} 500 -70 0 0 {name=l_c3_bot lab=bot3}
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} 900 150 0 0 {name=XSW4}
C {lab_wire.sym} 750 120 0 0 {name=l_sw4_b lab=dac_in[4]}
C {lab_wire.sym} 1050 120 2 0 {name=l_sw4_vr lab=vref}
C {lab_wire.sym} 1050 140 2 0 {name=l_sw4_vd lab=vdd}
C {lab_wire.sym} 1050 160 2 0 {name=l_sw4_vs lab=vss}
C {lab_wire.sym} 1050 180 2 0 {name=l_sw4_bot lab=bot4}
C {symbols/cap_mim_2f0fF.sym} 900 -100 0 0 {name=C4 W=5e-6 L=5e-6 model=cap_mim_2f0fF spiceprefix=X m=16}
C {lab_wire.sym} 900 -130 2 0 {name=l_c4_top lab=vdac}
C {lab_wire.sym} 900 -70 0 0 {name=l_c4_bot lab=bot4}
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} 1300 150 0 0 {name=XSW5}
C {lab_wire.sym} 1150 120 0 0 {name=l_sw5_b lab=dac_in[5]}
C {lab_wire.sym} 1450 120 2 0 {name=l_sw5_vr lab=vref}
C {lab_wire.sym} 1450 140 2 0 {name=l_sw5_vd lab=vdd}
C {lab_wire.sym} 1450 160 2 0 {name=l_sw5_vs lab=vss}
C {lab_wire.sym} 1450 180 2 0 {name=l_sw5_bot lab=bot5}
C {symbols/cap_mim_2f0fF.sym} 1300 -100 0 0 {name=C5 W=5e-6 L=5e-6 model=cap_mim_2f0fF spiceprefix=X m=32}
C {lab_wire.sym} 1300 -130 2 0 {name=l_c5_top lab=vdac}
C {lab_wire.sym} 1300 -70 0 0 {name=l_c5_bot lab=bot5}
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} 1700 150 0 0 {name=XSW6}
C {lab_wire.sym} 1550 120 0 0 {name=l_sw6_b lab=dac_in[6]}
C {lab_wire.sym} 1850 120 2 0 {name=l_sw6_vr lab=vref}
C {lab_wire.sym} 1850 140 2 0 {name=l_sw6_vd lab=vdd}
C {lab_wire.sym} 1850 160 2 0 {name=l_sw6_vs lab=vss}
C {lab_wire.sym} 1850 180 2 0 {name=l_sw6_bot lab=bot6}
C {symbols/cap_mim_2f0fF.sym} 1700 -100 0 0 {name=C6 W=5e-6 L=5e-6 model=cap_mim_2f0fF spiceprefix=X m=64}
C {lab_wire.sym} 1700 -130 2 0 {name=l_c6_top lab=vdac}
C {lab_wire.sym} 1700 -70 0 0 {name=l_c6_bot lab=bot6}
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} 2100 150 0 0 {name=XSW7}
C {lab_wire.sym} 1950 120 0 0 {name=l_sw7_b lab=dac_in[7]}
C {lab_wire.sym} 2250 120 2 0 {name=l_sw7_vr lab=vref}
C {lab_wire.sym} 2250 140 2 0 {name=l_sw7_vd lab=vdd}
C {lab_wire.sym} 2250 160 2 0 {name=l_sw7_vs lab=vss}
C {lab_wire.sym} 2250 180 2 0 {name=l_sw7_bot lab=bot7}
C {symbols/cap_mim_2f0fF.sym} 2100 -100 0 0 {name=C7 W=5e-6 L=5e-6 model=cap_mim_2f0fF spiceprefix=X m=128}
C {lab_wire.sym} 2100 -130 2 0 {name=l_c7_top lab=vdac}
C {lab_wire.sym} 2100 -70 0 0 {name=l_c7_bot lab=bot7}
C {symbols/cap_mim_2f0fF.sym} -1050 -100 0 0 {name=C8 W=5e-6 L=5e-6 model=cap_mim_2f0fF spiceprefix=X m=1}
C {lab_wire.sym} -1050 -130 2 0 {name=l_cdum_top lab=vdac}
C {lab_wire.sym} -1050 -70 0 0 {name=l_cdum_bot lab=vss}
C {title.sym} 0 350 0 0 {name=l_title author="Berkah Saluyu"}
