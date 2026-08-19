v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
C {ipin.sym} -500 -120 0 0 {name=p_vp lab=vin_p}
C {ipin.sym} -500 -80 0 0 {name=p_vn lab=vin_n}
C {ipin.sym} -500 -40 0 0 {name=p_rl lab=rst_latch}
C {iopin.sym} 20 -280 0 0 {name=p_vdd lab=vdd}
C {iopin.sym} 20 -240 0 0 {name=p_vss lab=vss}
C {opin.sym} 590 -100 0 0 {name=p_op lab=out_p}
C {opin.sym} 590 -60 0 0 {name=p_on lab=out_n}
C {symbols/nfet_03v3.sym} 0 300 0 0 {name=Mtail L=0.28u W=8.00u nf=2 m=1 model=nfet_03v3 spiceprefix=X}
C {lab_wire.sym} -20 300 0 0 {name=l_mt_g lab=rst_latch}
C {lab_wire.sym} 20 270 2 0 {name=l_mt_d lab=net_tail}
C {lab_wire.sym} 20 300 2 0 {name=l_mt_b lab=vss}
C {lab_wire.sym} 20 330 0 0 {name=l_mt_s lab=vss}
C {symbols/nfet_03v3.sym} -150 150 0 0 {name=M1 L=0.28u W=6.00u nf=2 m=1 model=nfet_03v3 spiceprefix=X}
C {lab_wire.sym} -170 150 0 0 {name=l_m1_g lab=vin_p}
C {lab_wire.sym} -130 120 2 0 {name=l_m1_d lab=fn_p}
C {lab_wire.sym} -130 150 2 0 {name=l_m1_b lab=vss}
C {lab_wire.sym} -130 180 0 0 {name=l_m1_s lab=net_tail}
C {symbols/nfet_03v3.sym} 150 150 0 0 {name=M2 L=0.28u W=6.00u nf=2 m=1 model=nfet_03v3 spiceprefix=X}
C {lab_wire.sym} 130 150 0 0 {name=l_m2_g lab=vin_n}
C {lab_wire.sym} 170 120 2 0 {name=l_m2_d lab=fn_n}
C {lab_wire.sym} 170 150 2 0 {name=l_m2_b lab=vss}
C {lab_wire.sym} 170 180 0 0 {name=l_m2_s lab=net_tail}
C {symbols/nfet_03v3.sym} -150 0 0 0 {name=M3 L=0.28u W=3.50u nf=1 m=1 model=nfet_03v3 spiceprefix=X}
C {lab_wire.sym} -170 0 0 0 {name=l_m3_g lab=out_n}
C {lab_wire.sym} -130 -30 2 0 {name=l_m3_d lab=out_p}
C {lab_wire.sym} -130 0 2 0 {name=l_m3_b lab=vss}
C {lab_wire.sym} -130 30 0 0 {name=l_m3_s lab=fn_p}
C {symbols/nfet_03v3.sym} 150 0 0 0 {name=M4 L=0.28u W=3.50u nf=1 m=1 model=nfet_03v3 spiceprefix=X}
C {lab_wire.sym} 130 0 0 0 {name=l_m4_g lab=out_p}
C {lab_wire.sym} 170 -30 2 0 {name=l_m4_d lab=out_n}
C {lab_wire.sym} 170 0 2 0 {name=l_m4_b lab=vss}
C {lab_wire.sym} 170 30 0 0 {name=l_m4_s lab=fn_n}
C {symbols/pfet_03v3.sym} -150 -150 0 0 {name=M5 L=0.28u W=4.20u nf=2 m=1 model=pfet_03v3 spiceprefix=X}
C {lab_wire.sym} -170 -150 0 0 {name=l_m5_g lab=out_n}
C {lab_wire.sym} -130 -180 0 0 {name=l_m5_s lab=vdd}
C {lab_wire.sym} -130 -150 2 0 {name=l_m5_b lab=vdd}
C {lab_wire.sym} -130 -120 2 0 {name=l_m5_d lab=out_p}
C {symbols/pfet_03v3.sym} 150 -150 0 0 {name=M6 L=0.28u W=4.20u nf=2 m=1 model=pfet_03v3 spiceprefix=X}
C {lab_wire.sym} 130 -150 0 0 {name=l_m6_g lab=out_p}
C {lab_wire.sym} 170 -180 0 0 {name=l_m6_s lab=vdd}
C {lab_wire.sym} 170 -150 2 0 {name=l_m6_b lab=vdd}
C {lab_wire.sym} 170 -120 2 0 {name=l_m6_d lab=out_n}
C {symbols/pfet_03v3.sym} -350 -150 0 0 {name=M7 L=0.28u W=2.00u nf=1 m=1 model=pfet_03v3 spiceprefix=X}
C {lab_wire.sym} -370 -150 0 0 {name=l_m7_g lab=rst_latch}
C {lab_wire.sym} -330 -180 0 0 {name=l_m7_s lab=vdd}
C {lab_wire.sym} -330 -150 2 0 {name=l_m7_b lab=vdd}
C {lab_wire.sym} -330 -120 2 0 {name=l_m7_d lab=out_p}
C {symbols/pfet_03v3.sym} 350 -150 0 0 {name=M8 L=0.28u W=2.00u nf=1 m=1 model=pfet_03v3 spiceprefix=X}
C {lab_wire.sym} 330 -150 0 0 {name=l_m8_g lab=rst_latch}
C {lab_wire.sym} 370 -180 0 0 {name=l_m8_s lab=vdd}
C {lab_wire.sym} 370 -150 2 0 {name=l_m8_b lab=vdd}
C {lab_wire.sym} 370 -120 2 0 {name=l_m8_d lab=out_n}
C {symbols/pfet_03v3.sym} -350 0 0 0 {name=M9 L=0.28u W=2.00u nf=1 m=1 model=pfet_03v3 spiceprefix=X}
C {lab_wire.sym} -370 0 0 0 {name=l_m9_g lab=rst_latch}
C {lab_wire.sym} -330 -30 0 0 {name=l_m9_s lab=vdd}
C {lab_wire.sym} -330 0 2 0 {name=l_m9_b lab=vdd}
C {lab_wire.sym} -330 30 2 0 {name=l_m9_d lab=fn_p}
C {symbols/pfet_03v3.sym} 350 0 0 0 {name=M10 L=0.28u W=2.00u nf=1 m=1 model=pfet_03v3 spiceprefix=X}
C {lab_wire.sym} 330 0 0 0 {name=l_m10_g lab=rst_latch}
C {lab_wire.sym} 370 -30 0 0 {name=l_m10_s lab=vdd}
C {lab_wire.sym} 370 0 2 0 {name=l_m10_b lab=vdd}
C {lab_wire.sym} 370 30 2 0 {name=l_m10_d lab=fn_n}
C {title.sym} -200 440 0 0 {name=l_title author="Berkah Saluyu"}
