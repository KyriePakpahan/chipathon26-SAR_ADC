v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {INVERTER 1} -210 -150 0 0 0.4 0.4 {}
T {TRANSMISSION GATE 1} 420 170 0 0 0.4 0.4 {}
T {MASTER LATCH} -210 190 0 0 0.4 0.4 {}
T {TRANSMISSION GATE 2} -240 630 0 0 0.4 0.4 {}
T {INVERTER 2} -190 980 0 0 0.4 0.4 {}
T {NAND
} -790 910 0 0 0.4 0.4 {}
T {INVERTER FEEDBACK} 140 980 0 0 0.4 0.4 {}
T {INPUT INVERTER} 450 -160 0 0 0.4 0.4 {}
N -200 -30 -160 -30 {lab=clk}
N -200 -30 -200 70 {lab=clk}
N -200 70 -160 70 {lab=clk}
N -250 20 -200 20 {lab=clk}
N -120 0 -120 40 {lab=clk_n}
N -120 -80 -120 -60 {lab=VDD}
N -120 100 -120 120 {lab=0}
N -120 -60 -120 -30 {lab=VDD}
N -120 70 -120 100 {lab=0}
N -120 20 -90 20 {lab=clk_n}
N 300 300 340 300 {lab=clk}
N 630 300 660 300 {lab=clk_n}
N 380 250 380 270 {lab=D_int}
N 470 250 700 250 {lab=D_int}
N 700 250 700 270 {lab=D_int}
N 380 330 380 380 {lab=M}
N 470 380 700 380 {lab=M}
N 700 330 700 380 {lab=M}
N 530 380 530 410 {lab=M}
N -350 330 -280 330 {lab=M}
N -350 330 -350 440 {lab=M}
N -350 440 -280 440 {lab=M}
N -390 380 -350 380 {lab=M}
N -240 360 -240 410 {lab=M_bar}
N -240 440 -240 470 {lab=0}
N -240 300 -240 330 {lab=VDD}
N -240 290 -240 300 {lab=VDD}
N -10 360 -10 410 {lab=M}
N -240 280 -120 280 {lab=VDD}
N -120 280 -10 280 {lab=VDD}
N -10 280 -10 300 {lab=VDD}
N -240 280 -240 290 {lab=VDD}
N -240 470 -240 480 {lab=0}
N -240 480 -10 480 {lab=0}
N -10 470 -10 480 {lab=0}
N -120 480 -120 500 {lab=0}
N -10 380 110 380 {lab=M}
N -390 230 -390 380 {lab=M}
N -390 230 110 230 {lab=M}
N 110 230 110 380 {lab=M}
N -70 330 -50 330 {lab=M_bar}
N -70 330 -70 440 {lab=M_bar}
N -70 440 -50 440 {lab=M_bar}
N -110 380 -70 380 {lab=M_bar}
N -240 380 -110 380 {lab=M_bar}
N -10 300 -10 330 {lab=VDD}
N -10 440 -10 470 {lab=0}
N 380 300 440 300 {lab=VDD}
N 380 380 470 380 {lab=M}
N 380 250 470 250 {lab=D_int}
N 700 300 760 300 {lab=0}
N -350 790 -310 790 {lab=clk_n}
N -20 790 10 790 {lab=clk}
N -270 740 -270 760 {lab=M_bar}
N -180 740 50 740 {lab=M_bar}
N 50 740 50 760 {lab=M_bar}
N -270 820 -270 870 {lab=S}
N -180 870 50 870 {lab=S}
N 50 820 50 870 {lab=S}
N -120 870 -120 900 {lab=S}
N -120 700 -120 730 {lab=M_bar}
N -270 790 -210 790 {lab=VDD}
N -270 870 -180 870 {lab=S}
N -270 740 -180 740 {lab=M_bar}
N -120 730 -120 740 {lab=M_bar}
N 50 790 110 790 {lab=0}
N -880 1000 -880 1010 {lab=VDD}
N -880 1000 -640 1000 {lab=VDD}
N -640 1000 -640 1010 {lab=VDD}
N -760 990 -760 1000 {lab=VDD}
N -880 1070 -880 1090 {lab=Q_bar}
N -880 1090 -640 1090 {lab=Q_bar}
N -640 1070 -640 1090 {lab=Q_bar}
N -760 1090 -760 1120 {lab=Q_bar}
N -760 1180 -760 1220 {lab=#net1}
N -760 1280 -760 1320 {lab=0}
N -760 1150 -740 1150 {lab=0}
N -740 1150 -740 1280 {lab=0}
N -760 1280 -740 1280 {lab=0}
N -760 1250 -740 1250 {lab=0}
N -880 1010 -880 1040 {lab=VDD}
N -640 1010 -640 1040 {lab=VDD}
N -760 1110 -620 1110 {lab=Q_bar}
N -940 1040 -920 1040 {lab=S}
N -700 1040 -680 1040 {lab=rst_n}
N -830 1150 -800 1150 {lab=S}
N -860 1250 -800 1250 {lab=rst_n}
N -210 1100 -170 1100 {lab=Q_bar}
N -210 1100 -210 1200 {lab=Q_bar}
N -210 1200 -170 1200 {lab=Q_bar}
N -260 1150 -210 1150 {lab=Q_bar}
N -130 1130 -130 1170 {lab=Q}
N -130 1050 -130 1070 {lab=VDD}
N -130 1230 -130 1250 {lab=0}
N -130 1070 -130 1100 {lab=VDD}
N -130 1200 -130 1230 {lab=0}
N -130 1150 -100 1150 {lab=Q}
N 120 1100 160 1100 {lab=Q_bar}
N 120 1100 120 1200 {lab=Q_bar}
N 120 1200 160 1200 {lab=Q_bar}
N 70 1150 120 1150 {lab=Q_bar}
N 200 1130 200 1170 {lab=S}
N 200 1050 200 1070 {lab=VDD}
N 200 1230 200 1250 {lab=0}
N 200 1070 200 1100 {lab=VDD}
N 200 1200 200 1230 {lab=0}
N 200 1150 230 1150 {lab=S}
N 530 -20 530 20 {lab=D_int}
N 470 -50 490 -50 {lab=D}
N 440 0 460 0 {lab=D}
N 470 -50 470 50 {lab=D}
N 470 50 490 50 {lab=D}
N 460 0 470 0 {lab=D}
N 530 0 580 0 {lab=D_int}
N 540 220 540 250 {lab=D_int}
N 530 -100 530 -80 {lab=VDD}
N 530 -80 530 -50 {lab=VDD}
N 530 80 530 110 {lab=0}
N 530 50 530 80 {lab=0}
C {symbols/pfet_03v3.sym} -140 -30 0 0 {name=M1
L=0.28u
W=1.0u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=pfet_03v3
spiceprefix=X
}
C {symbols/nfet_03v3.sym} -140 70 0 0 {name=M2
L=0.28u
W=0.50u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {ipin.sym} -250 20 0 0 {name=p1 lab=clk
}
C {vdd.sym} -120 -80 0 0 {name=l1 lab=VDD}
C {gnd.sym} -120 120 0 0 {name=l2 lab=0}
C {symbols/pfet_03v3.sym} 360 300 0 0 {name=M3
L=0.28u
W=1.0u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=pfet_03v3
spiceprefix=X
}
C {symbols/nfet_03v3.sym} 680 300 0 0 {name=M4
L=0.28u
W=0.50u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {lab_wire.sym} 300 300 0 0 {name=p2 sig_type=std_logic lab=clk}
C {ipin.sym} 440 0 0 0 {name=p5 lab=D
}
C {lab_wire.sym} 530 410 0 0 {name=p6 sig_type=std_logic lab=M}
C {symbols/pfet_03v3.sym} -260 330 0 0 {name=M5
L=0.28u
W=1.0u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=pfet_03v3
spiceprefix=X
}
C {symbols/nfet_03v3.sym} -260 440 0 0 {name=M6
L=0.28u
W=0.50u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {vdd.sym} -120 280 0 0 {name=l3 lab=VDD}
C {gnd.sym} -120 500 0 0 {name=l4 lab=0}
C {lab_wire.sym} -390 380 0 0 {name=p7 sig_type=std_logic lab=M}
C {symbols/pfet_03v3.sym} -30 330 0 0 {name=M7
L=2.0u
W=0.30u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=pfet_03v3
spiceprefix=X
}
C {symbols/nfet_03v3.sym} -30 440 0 0 {name=M8
L=2.4u
W=0.22u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {lab_wire.sym} -140 380 0 0 {name=p8 sig_type=std_logic lab=M_bar}
C {vdd.sym} 440 300 1 0 {name=l5 lab=VDD}
C {gnd.sym} 760 300 3 0 {name=l6 lab=0}
C {symbols/pfet_03v3.sym} -290 790 0 0 {name=M9
L=0.28u
W=1.0u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=pfet_03v3
spiceprefix=X
}
C {symbols/nfet_03v3.sym} 30 790 0 0 {name=M10
L=0.28u
W=0.50u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {lab_wire.sym} -20 790 0 0 {name=p10 sig_type=std_logic lab=clk}
C {vdd.sym} -210 790 1 0 {name=l7 lab=VDD}
C {gnd.sym} 110 790 3 0 {name=l8 lab=0}
C {lab_wire.sym} -120 700 0 0 {name=p11 sig_type=std_logic lab=M_bar}
C {lab_wire.sym} -120 900 0 0 {name=p12 sig_type=std_logic lab=S}
C {symbols/pfet_03v3.sym} -900 1040 0 0 {name=M11
L=0.28u
W=1.0u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=pfet_03v3
spiceprefix=X
}
C {symbols/pfet_03v3.sym} -660 1040 0 0 {name=M12
L=0.28u
W=1.0u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=pfet_03v3
spiceprefix=X
}
C {symbols/nfet_03v3.sym} -780 1150 0 0 {name=M13
L=0.28u
W=0.50u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {symbols/nfet_03v3.sym} -780 1250 0 0 {name=M14
L=0.28u
W=0.50u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {gnd.sym} -760 1320 0 0 {name=l9 lab=0}
C {vdd.sym} -760 990 0 0 {name=l10 lab=VDD}
C {lab_wire.sym} -620 1110 2 0 {name=p13 sig_type=std_logic lab=Q_bar}
C {lab_wire.sym} -940 1040 0 0 {name=p14 sig_type=std_logic lab=S}
C {lab_wire.sym} -830 1150 0 0 {name=p15 sig_type=std_logic lab=S}
C {lab_wire.sym} -860 1250 0 0 {name=p16 sig_type=std_logic lab=rst_n}
C {ipin.sym} -700 1040 0 0 {name=p17 lab=rst_n}
C {symbols/pfet_03v3.sym} -150 1100 0 0 {name=M15
L=0.28u
W=1.0u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=pfet_03v3
spiceprefix=X
}
C {symbols/nfet_03v3.sym} -150 1200 0 0 {name=M16
L=0.28u
W=0.50u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {vdd.sym} -130 1050 0 0 {name=l11 lab=VDD}
C {gnd.sym} -130 1250 0 0 {name=l12 lab=0}
C {opin.sym} -100 1150 0 0 {name=p19 lab=Q}
C {lab_wire.sym} -260 1150 0 0 {name=p18 sig_type=std_logic lab=Q_bar}
C {symbols/pfet_03v3.sym} 180 1100 0 0 {name=M17
L=2.0u
W=0.30u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=pfet_03v3
spiceprefix=X
}
C {symbols/nfet_03v3.sym} 180 1200 0 0 {name=M18
L=2.4u
W=0.22u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {vdd.sym} 200 1050 0 0 {name=l13 lab=VDD}
C {gnd.sym} 200 1250 0 0 {name=l14 lab=0}
C {lab_wire.sym} 70 1150 0 0 {name=p21 sig_type=std_logic lab=Q_bar}
C {lab_wire.sym} 230 1150 2 0 {name=p20 sig_type=std_logic lab=S}
C {lab_wire.sym} -90 20 2 0 {name=p3 sig_type=std_logic lab=clk_n}
C {lab_wire.sym} 630 300 0 0 {name=p4 sig_type=std_logic lab=clk_n}
C {lab_wire.sym} -350 790 0 0 {name=p9 sig_type=std_logic lab=clk_n}
C {symbols/pfet_03v3.sym} 510 -50 0 0 {name=M19
L=0.28u
W=1.0u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=pfet_03v3
spiceprefix=X
}
C {symbols/nfet_03v3.sym} 510 50 0 0 {name=M20
L=0.28u
W=0.50u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {vdd.sym} 530 -100 0 0 {name=l15 lab=VDD}
C {gnd.sym} 530 110 0 0 {name=l16 lab=0}
C {lab_wire.sym} 580 0 2 0 {name=p22 sig_type=std_logic lab=D_int}
C {lab_wire.sym} 540 220 0 0 {name=p23 sig_type=std_logic lab=D_int}
