v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
C {ipin.sym} -400 -60 0 0 {name=p_vi lab=vi}
C {opin.sym} 360 -30 0 0 {name=p_vo lab=vo}
C {iopin.sym} 0 -210 0 0 {name=p_vdd lab=vdd}
C {iopin.sym} 0 -170 0 0 {name=p_vss lab=vss}
C {symbols/pfet_03v3.sym} 0 -70 0 0 {name=M2 L=0.28u W=4.00u nf=1 m=1 model=pfet_03v3 spiceprefix=X}
C {lab_wire.sym} -20 -70 0 0 {name=l_m2_g lab=vi}
C {lab_wire.sym} 20 -100 0 0 {name=l_m2_s lab=vdd}
C {lab_wire.sym} 20 -70 2 0 {name=l_m2_b lab=vdd}
C {lab_wire.sym} 20 -40 2 0 {name=l_m2_d lab=vo}
C {symbols/nfet_03v3.sym} 0 70 0 0 {name=M1 L=0.28u W=1.60u nf=1 m=1 model=nfet_03v3 spiceprefix=X}
C {lab_wire.sym} -20 70 0 0 {name=l_m1_g lab=vi}
C {lab_wire.sym} 20 40 2 0 {name=l_m1_d lab=vo}
C {lab_wire.sym} 20 70 2 0 {name=l_m1_b lab=vss}
C {lab_wire.sym} 20 100 0 0 {name=l_m1_s lab=vss}
C {title.sym} -220 160 0 0 {name=l_title author="Berkah Saluyu"}
