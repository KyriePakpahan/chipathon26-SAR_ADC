v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
C {ipin.sym} -800 -80 0 0 {name=p_vin lab=vin}
C {ipin.sym} -800 -40 0 0 {name=p_se lab=sample_en}
C {opin.sym} -800 0 0 0 {name=p_vh lab=vhold}
C {iopin.sym} -800 40 0 0 {name=p_vdd lab=vdd}
C {iopin.sym} -800 80 0 0 {name=p_vss lab=vss}
C {sar_adc/blocks/sample_hold/inv_sh.sym} -500 0 0 0 {name=x_inv}
C {lab_wire.sym} -650 0 0 0 {name=l_inv_vi lab=sample_en}
C {lab_wire.sym} -350 -20 2 0 {name=l_inv_vd lab=vdd}
C {lab_wire.sym} -350 0 2 0 {name=l_inv_vo lab=clkb}
C {lab_wire.sym} -350 20 2 0 {name=l_inv_vs lab=vss}
C {symbols/nfet_03v3.sym} 0 -100 0 0 {name=M1 L=0.28u W=4.00u nf=2 m=1 model=nfet_03v3 spiceprefix=X}
C {lab_wire.sym} -20 -100 0 0 {name=l_m1_g lab=sample_en}
C {lab_wire.sym} 20 -130 2 0 {name=l_m1_d lab=vhold}
C {lab_wire.sym} 20 -100 2 0 {name=l_m1_b lab=vss}
C {lab_wire.sym} 20 -70 0 0 {name=l_m1_s lab=vin}
C {symbols/pfet_03v3.sym} 0 -250 0 0 {name=M2 L=0.28u W=8.00u nf=2 m=1 model=pfet_03v3 spiceprefix=X}
C {lab_wire.sym} -20 -250 0 0 {name=l_m2_g lab=clkb}
C {lab_wire.sym} 20 -280 0 0 {name=l_m2_s lab=vhold}
C {lab_wire.sym} 20 -250 2 0 {name=l_m2_b lab=vdd}
C {lab_wire.sym} 20 -220 2 0 {name=l_m2_d lab=vin}
C {symbols/cap_mim_2f0fF.sym} 250 100 0 0 {name=C2 W=15e-6 L=10e-6 model=cap_mim_2f0fF spiceprefix=X m=1}
C {lab_wire.sym} 250 70 2 0 {name=l_c2_top lab=vhold}
C {lab_wire.sym} 250 130 0 0 {name=l_c2_bot lab=vss}
C {title.sym} -430 400 0 0 {name=l_title author="Berkah Saluyu"}
