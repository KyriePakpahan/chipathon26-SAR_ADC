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
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} -400 -50 0 0 {name=XSW0}
C {lab_wire.sym} -550 -80 0 0 {name=l_sw_b0 lab=dac_in[0]}
C {lab_wire.sym} -250 -80 2 0 {name=l_sw_vr0 lab=vref}
C {lab_wire.sym} -250 -60 2 0 {name=l_sw_vd0 lab=vdd}
C {lab_wire.sym} -250 -40 2 0 {name=l_sw_vs0 lab=vss}
C {lab_wire.sym} -250 -20 2 0 {name=l_sw_bt0 lab=bot0}
C {lab_wire.sym} -400 -210 0 0 {name=l_c0_top lab=vdac}
C {lab_wire.sym} -400 -150 2 0 {name=l_c0_bot lab=bot0}
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} 0 -50 0 0 {name=XSW1}
C {lab_wire.sym} -150 -80 0 0 {name=l_sw_b1 lab=dac_in[1]}
C {lab_wire.sym} 150 -80 2 0 {name=l_sw_vr1 lab=vref}
C {lab_wire.sym} 150 -60 2 0 {name=l_sw_vd1 lab=vdd}
C {lab_wire.sym} 150 -40 2 0 {name=l_sw_vs1 lab=vss}
C {lab_wire.sym} 150 -20 2 0 {name=l_sw_bt1 lab=bot1}
C {lab_wire.sym} 0 -210 0 0 {name=l_c1_top lab=vdac}
C {lab_wire.sym} 0 -150 2 0 {name=l_c1_bot lab=bot1}
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} 400 -50 0 0 {name=XSW2}
C {lab_wire.sym} 250 -80 0 0 {name=l_sw_b2 lab=dac_in[2]}
C {lab_wire.sym} 550 -80 2 0 {name=l_sw_vr2 lab=vref}
C {lab_wire.sym} 550 -60 2 0 {name=l_sw_vd2 lab=vdd}
C {lab_wire.sym} 550 -40 2 0 {name=l_sw_vs2 lab=vss}
C {lab_wire.sym} 550 -20 2 0 {name=l_sw_bt2 lab=bot2}
C {lab_wire.sym} 400 -210 0 0 {name=l_c2_top lab=vdac}
C {lab_wire.sym} 400 -150 2 0 {name=l_c2_bot lab=bot2}
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} 800 -50 0 0 {name=XSW3}
C {lab_wire.sym} 650 -80 0 0 {name=l_sw_b3 lab=dac_in[3]}
C {lab_wire.sym} 950 -80 2 0 {name=l_sw_vr3 lab=vref}
C {lab_wire.sym} 950 -60 2 0 {name=l_sw_vd3 lab=vdd}
C {lab_wire.sym} 950 -40 2 0 {name=l_sw_vs3 lab=vss}
C {lab_wire.sym} 950 -20 2 0 {name=l_sw_bt3 lab=bot3}
C {lab_wire.sym} 800 -210 0 0 {name=l_c3_top lab=vdac}
C {lab_wire.sym} 800 -150 2 0 {name=l_c3_bot lab=bot3}
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} 1200 -50 0 0 {name=XSW4}
C {lab_wire.sym} 1050 -80 0 0 {name=l_sw_b4 lab=dac_in[4]}
C {lab_wire.sym} 1350 -80 2 0 {name=l_sw_vr4 lab=vref}
C {lab_wire.sym} 1350 -60 2 0 {name=l_sw_vd4 lab=vdd}
C {lab_wire.sym} 1350 -40 2 0 {name=l_sw_vs4 lab=vss}
C {lab_wire.sym} 1350 -20 2 0 {name=l_sw_bt4 lab=bot4}
C {lab_wire.sym} 1200 -210 0 0 {name=l_c4_top lab=vdac}
C {lab_wire.sym} 1200 -150 2 0 {name=l_c4_bot lab=bot4}
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} 1600 -50 0 0 {name=XSW5}
C {lab_wire.sym} 1450 -80 0 0 {name=l_sw_b5 lab=dac_in[5]}
C {lab_wire.sym} 1750 -80 2 0 {name=l_sw_vr5 lab=vref}
C {lab_wire.sym} 1750 -60 2 0 {name=l_sw_vd5 lab=vdd}
C {lab_wire.sym} 1750 -40 2 0 {name=l_sw_vs5 lab=vss}
C {lab_wire.sym} 1750 -20 2 0 {name=l_sw_bt5 lab=bot5}
C {lab_wire.sym} 1600 -210 0 0 {name=l_c5_top lab=vdac}
C {lab_wire.sym} 1600 -150 2 0 {name=l_c5_bot lab=bot5}
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} 2000 -50 0 0 {name=XSW6}
C {lab_wire.sym} 1850 -80 0 0 {name=l_sw_b6 lab=dac_in[6]}
C {lab_wire.sym} 2150 -80 2 0 {name=l_sw_vr6 lab=vref}
C {lab_wire.sym} 2150 -60 2 0 {name=l_sw_vd6 lab=vdd}
C {lab_wire.sym} 2150 -40 2 0 {name=l_sw_vs6 lab=vss}
C {lab_wire.sym} 2150 -20 2 0 {name=l_sw_bt6 lab=bot6}
C {lab_wire.sym} 2000 -210 0 0 {name=l_c6_top lab=vdac}
C {lab_wire.sym} 2000 -150 2 0 {name=l_c6_bot lab=bot6}
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} 2400 -50 0 0 {name=XSW7}
C {lab_wire.sym} 2250 -80 0 0 {name=l_sw_b7 lab=dac_in[7]}
C {lab_wire.sym} 2550 -80 2 0 {name=l_sw_vr7 lab=vref}
C {lab_wire.sym} 2550 -60 2 0 {name=l_sw_vd7 lab=vdd}
C {lab_wire.sym} 2550 -40 2 0 {name=l_sw_vs7 lab=vss}
C {lab_wire.sym} 2550 -20 2 0 {name=l_sw_bt7 lab=bot7}
C {lab_wire.sym} 2400 -210 0 0 {name=l_c7_top lab=vdac}
C {lab_wire.sym} 2400 -150 2 0 {name=l_c7_bot lab=bot7}
C {lab_wire.sym} 2800 -210 0 0 {name=l_cdum_top lab=vdac}
C {lab_wire.sym} 2800 -150 2 0 {name=l_cdum_bot lab=vss}
C {symbols/cap_mim_2f0fF.sym} -400 -180 0 0 {name=C0
W=5e-6
L=5e-6
model=cap_mim_2f0fF
spiceprefix=X
m=1}
C {symbols/cap_mim_2f0fF.sym} 0 -180 0 0 {name=C1
W=5e-6
L=5e-6
model=cap_mim_2f0fF
spiceprefix=X
m=2}
C {symbols/cap_mim_2f0fF.sym} 400 -180 0 0 {name=C2
W=5e-6
L=5e-6
model=cap_mim_2f0fF
spiceprefix=X
m=4}
C {symbols/cap_mim_2f0fF.sym} 800 -180 0 0 {name=C3
W=5e-6
L=5e-6
model=cap_mim_2f0fF
spiceprefix=X
m=8}
C {symbols/cap_mim_2f0fF.sym} 1200 -180 0 0 {name=C4
W=16e-6
L=16e-6
model=cap_mim_2f0fF
spiceprefix=X
m=16}
C {symbols/cap_mim_2f0fF.sym} 1600 -180 0 0 {name=C5
W=5e-6
L=5e-6
model=cap_mim_2f0fF
spiceprefix=X
m=32}
C {symbols/cap_mim_2f0fF.sym} 2000 -180 0 0 {name=C6
W=5e-6
L=5e-6
model=cap_mim_2f0fF
spiceprefix=X
m=64}
C {symbols/cap_mim_2f0fF.sym} 2400 -180 0 0 {name=C7
W=5e-6
L=5e-6
model=cap_mim_2f0fF
spiceprefix=X
m=128}
C {symbols/cap_mim_2f0fF.sym} 2800 -180 0 0 {name=CDummy
W=5e-6
L=5e-6
model=cap_mim_2f0fF
spiceprefix=X
m=1}
