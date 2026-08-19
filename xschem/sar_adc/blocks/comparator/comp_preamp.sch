v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
C {ipin.sym} -600 -120 0 0 {name=p_vp lab=vin_p}
C {ipin.sym} -600 -80 0 0 {name=p_vn lab=vin_n}
C {ipin.sym} -600 -40 0 0 {name=p_en lab=en}
C {iopin.sym} 20 -280 0 0 {name=p_vdd lab=vdd}
C {iopin.sym} 20 -240 0 0 {name=p_vss lab=vss}
C {opin.sym} 600 -100 0 0 {name=p_op lab=out_p}
C {opin.sym} 600 -60 0 0 {name=p_on lab=out_n}
C {symbols/nfet_03v3.sym} 0 250 0 0 {name=Mtail L=0.28u W=10.00u nf=2 m=1 model=nfet_03v3 spiceprefix=X}
C {lab_wire.sym} -20 250 0 0 {name=l_mt_g lab=en}
C {lab_wire.sym} 20 220 2 0 {name=l_mt_d lab=net_tail}
C {lab_wire.sym} 20 250 2 0 {name=l_mt_b lab=vss}
C {lab_wire.sym} 20 280 0 0 {name=l_mt_s lab=vss}
C {symbols/nfet_03v3.sym} -150 100 0 0 {name=M1 L=0.28u W=8.00u nf=2 m=1 model=nfet_03v3 spiceprefix=X}
C {lab_wire.sym} -170 100 0 0 {name=l_m1_g lab=vin_p}
C {lab_wire.sym} -130 70 2 0 {name=l_m1_d lab=out_n}
C {lab_wire.sym} -130 100 2 0 {name=l_m1_b lab=vss}
C {lab_wire.sym} -130 130 0 0 {name=l_m1_s lab=net_tail}
C {symbols/nfet_03v3.sym} 150 100 0 0 {name=M2 L=0.28u W=8.00u nf=2 m=1 model=nfet_03v3 spiceprefix=X}
C {lab_wire.sym} 130 100 0 0 {name=l_m2_g lab=vin_n}
C {lab_wire.sym} 170 70 2 0 {name=l_m2_d lab=out_p}
C {lab_wire.sym} 170 100 2 0 {name=l_m2_b lab=vss}
C {lab_wire.sym} 170 130 0 0 {name=l_m2_s lab=net_tail}
C {symbols/pfet_03v3.sym} -150 -100 0 0 {name=M3 L=0.50u W=4.00u nf=1 m=1 model=pfet_03v3 spiceprefix=X}
C {lab_wire.sym} -170 -100 0 0 {name=l_m3_g lab=out_n}
C {lab_wire.sym} -130 -130 0 0 {name=l_m3_s lab=vdd}
C {lab_wire.sym} -130 -100 2 0 {name=l_m3_b lab=vdd}
C {lab_wire.sym} -130 -70 2 0 {name=l_m3_d lab=out_n}
C {symbols/pfet_03v3.sym} 150 -100 0 0 {name=M4 L=0.50u W=4.00u nf=1 m=1 model=pfet_03v3 spiceprefix=X}
C {lab_wire.sym} 130 -100 0 0 {name=l_m4_g lab=out_p}
C {lab_wire.sym} 170 -130 0 0 {name=l_m4_s lab=vdd}
C {lab_wire.sym} 170 -100 2 0 {name=l_m4_b lab=vdd}
C {lab_wire.sym} 170 -70 2 0 {name=l_m4_d lab=out_p}
C {symbols/pfet_03v3.sym} -350 -100 0 0 {name=M5 L=0.28u W=2.00u nf=1 m=1 model=pfet_03v3 spiceprefix=X}
C {lab_wire.sym} -370 -100 0 0 {name=l_m5_g lab=en}
C {lab_wire.sym} -330 -130 0 0 {name=l_m5_s lab=vdd}
C {lab_wire.sym} -330 -100 2 0 {name=l_m5_b lab=vdd}
C {lab_wire.sym} -330 -70 2 0 {name=l_m5_d lab=out_n}
C {symbols/pfet_03v3.sym} 350 -100 0 0 {name=M6 L=0.28u W=2.00u nf=1 m=1 model=pfet_03v3 spiceprefix=X}
C {lab_wire.sym} 330 -100 0 0 {name=l_m6_g lab=en}
C {lab_wire.sym} 370 -130 0 0 {name=l_m6_s lab=vdd}
C {lab_wire.sym} 370 -100 2 0 {name=l_m6_b lab=vdd}
C {lab_wire.sym} 370 -70 2 0 {name=l_m6_d lab=out_p}
C {title.sym} -200 380 0 0 {name=l_title author="Berkah Saluyu"}
