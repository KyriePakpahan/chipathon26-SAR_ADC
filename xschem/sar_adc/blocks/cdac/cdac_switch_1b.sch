v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -180 -40 -180 -20 {lab=bit_b}
N 20 -40 20 -20 {lab=bot}
N 220 -40 220 -20 {lab=bot}
N 350 0 400 -0 {lab=bot}
C {ipin.sym} -400 -200 0 0 {name=p_bit lab=bit}
C {lab_wire.sym} -400 -200 0 0 {name=l_bit lab=bit}
C {iopin.sym} -400 -100 0 0 {name=p_vref lab=vref}
C {lab_wire.sym} -350 -100 0 0 {name=l_vref lab=vref}
C {iopin.sym} -400 0 0 0 {name=p_vdd lab=vdd}
C {lab_wire.sym} -350 0 0 0 {name=l_vdd lab=vdd}
C {iopin.sym} -400 100 0 0 {name=p_vss lab=vss}
C {lab_wire.sym} -350 100 0 0 {name=l_vss lab=vss}
C {iopin.sym} 400 0 0 0 {name=p_bot lab=bot}
C {lab_wire.sym} 350 0 2 0 {name=l_bot lab=bot}
C {symbols/pfet_03v3.sym} -200 -70 0 0 {name=M1 L=0.28u W=4.0u nf=2 m=1 model=pfet_03v3 spiceprefix=X}
C {symbols/nfet_03v3.sym} -200 10 0 0 {name=M2 L=0.28u W=2.0u nf=2 m=1 model=nfet_03v3 spiceprefix=X}
C {lab_wire.sym} -180 -100 0 0 {name=l_m1_s lab=vdd}
C {lab_wire.sym} -180 -70 2 0 {name=l_m1_b lab=vdd}
C {lab_wire.sym} -220 -70 0 0 {name=l_m1_g lab=bit}
C {lab_wire.sym} -180 -30 2 0 {name=l_inv_out lab=bit_b}
C {lab_wire.sym} -220 10 0 0 {name=l_m2_g lab=bit}
C {lab_wire.sym} -180 10 2 0 {name=l_m2_b lab=vss}
C {lab_wire.sym} -180 40 0 0 {name=l_m2_s lab=vss}
C {symbols/pfet_03v3.sym} 0 -70 0 0 {name=M3 L=0.28u W=4.0u nf=2 m=1 model=pfet_03v3 spiceprefix=X}
C {symbols/nfet_03v3.sym} 0 10 0 0 {name=M4 L=0.28u W=2.0u nf=2 m=1 model=nfet_03v3 spiceprefix=X}
C {lab_wire.sym} -20 -70 0 0 {name=l_m3_g lab=bit_b}
C {lab_wire.sym} 20 -100 0 0 {name=l_m3_s lab=vref}
C {lab_wire.sym} 20 -70 2 0 {name=l_m3_b lab=vdd}
C {lab_wire.sym} 20 -30 2 0 {name=l_m3_d lab=bot}
C {lab_wire.sym} -20 10 0 0 {name=l_m4_g lab=bit}
C {lab_wire.sym} 20 10 2 0 {name=l_m4_b lab=vss}
C {lab_wire.sym} 20 40 0 0 {name=l_m4_s lab=vref}
C {symbols/pfet_03v3.sym} 200 -70 0 0 {name=M5 L=0.28u W=4.0u nf=2 m=1 model=pfet_03v3 spiceprefix=X}
C {symbols/nfet_03v3.sym} 200 10 0 0 {name=M6 L=0.28u W=2.0u nf=2 m=1 model=nfet_03v3 spiceprefix=X}
C {lab_wire.sym} 180 -70 0 0 {name=l_m5_g lab=bit}
C {lab_wire.sym} 220 -100 0 0 {name=l_m5_s lab=vss}
C {lab_wire.sym} 220 -70 2 0 {name=l_m5_b lab=vdd}
C {lab_wire.sym} 220 -30 2 0 {name=l_m5_d lab=bot}
C {lab_wire.sym} 180 10 0 0 {name=l_m6_g lab=bit_b}
C {lab_wire.sym} 220 10 2 0 {name=l_m6_b lab=vss}
C {lab_wire.sym} 220 40 0 0 {name=l_m6_s lab=vss}
C {title.sym} 160 200 0 0 {name=l_title author="Berkah Saluyu"}
