v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 130 -510 240 -510 {lab=sample_en}
N 340 -660 340 -580 {lab=vdd}
N 340 -440 340 -360 {lab=vss}
N 440 -510 500 -510 {lab=clkb}
N 760 -730 760 -690 {lab=vin}
N 610 -730 760 -730 {lab=vin}
N 610 -730 610 -610 {lab=vin}
N 600 -610 610 -610 {lab=vin}
N 760 -530 760 -490 {lab=vin}
N 610 -490 760 -490 {lab=vin}
N 610 -610 610 -490 {lab=vin}
N 760 -630 760 -590 {lab=vhold}
N 760 -660 880 -660 {lab=vss}
N 760 -560 880 -560 {lab=vdd}
N 660 -660 720 -660 {lab=vg}
N 660 -690 660 -660 {lab=vg}
N 890 -420 960 -420 {lab=#net1}
N 770 -420 890 -420 {lab=#net1}
N 770 -420 770 -370 {lab=#net1}
N 770 -370 850 -370 {lab=#net1}
N 700 -370 770 -370 {lab=#net1}
N 700 -340 720 -340 {lab=vss}
N 850 -340 870 -340 {lab=vss}
N 700 -310 700 -300 {lab=vss}
N 610 -490 610 -240 {lab=vin}
N 610 -240 850 -240 {lab=vin}
N 850 -310 850 -240 {lab=vin}
N 660 -530 680 -530 {lab=clkb}
N 680 -560 720 -560 {lab=clkb}
N 680 -560 680 -530 {lab=clkb}
N 660 -510 660 -340 {lab=clkb}
N 660 -510 680 -510 {lab=clkb}
N 680 -530 680 -510 {lab=clkb}
N 780 -340 810 -340 {lab=sample_en}
N 780 -340 780 -210 {lab=sample_en}
N 1270 -470 1270 -420 {lab=vg}
N 1020 -420 1270 -420 {lab=vg}
N 1270 -420 1270 -370 {lab=vg}
N 1270 -340 1300 -340 {lab=vdd}
N 1270 -500 1310 -500 {lab=vdd}
N 1270 -550 1270 -530 {lab=vdd}
N 1200 -500 1230 -500 {lab=vg}
N 1180 -340 1230 -340 {lab=clkb}
N 1270 -310 1270 -260 {lab=vg}
N 1270 -260 1410 -260 {lab=vg}
N 1270 -420 1410 -420 {lab=vg}
N 1410 -420 1410 -260 {lab=vg}
N 1410 -420 1430 -420 {lab=vg}
N 1610 -520 1610 -490 {lab=vg}
N 1610 -430 1610 -390 {lab=#net2}
N 1540 -460 1570 -460 {lab=vdd}
N 1530 -360 1570 -360 {lab=clkb}
N 1610 -460 1690 -460 {lab=vss}
N 1690 -460 1690 -360 {lab=vss}
N 1610 -360 1690 -360 {lab=vss}
N 1610 -330 1610 -310 {lab=vss}
N 1610 -310 1690 -310 {lab=vss}
N 1690 -360 1690 -310 {lab=vss}
N 1010 -530 1010 -520 {lab=vss}
N 760 -610 1070 -610 {lab=vhold}
N 1010 -610 1010 -590 {lab=vhold}
C {title.sym} 160 -40 0 0 {name=l1 author="Berkah Saluyu"}
C {ipin.sym} 600 -610 0 0 {name=p1 lab=vin}
C {ipin.sym} 130 -510 0 0 {name=p2 lab=sample_en
}
C {opin.sym} 1070 -610 0 0 {name=p3 lab=vhold}
C {iopin.sym} 340 -660 3 0 {name=p4 lab=vdd}
C {iopin.sym} 340 -360 1 0 {name=p5 lab=vss}
C {lab_pin.sym} 500 -510 2 0 {name=p6 sig_type=std_logic lab=clkb
}
C {lab_pin.sym} 660 -690 1 0 {name=p7 sig_type=std_logic lab=vg}
C {lab_pin.sym} 660 -530 0 0 {name=p8 sig_type=std_logic lab=clkb
}
C {capa.sym} 990 -420 3 0 {name=C1
m=1
value=500f
footprint=1206
device="ceramic capacitor"}
C {lab_pin.sym} 1200 -500 0 0 {name=p20 sig_type=std_logic lab=vg}
C {lab_pin.sym} 1180 -340 0 0 {name=p21 sig_type=std_logic lab=clkb
}
C {lab_pin.sym} 1430 -420 2 0 {name=p22 sig_type=std_logic lab=vg}
C {lab_pin.sym} 1610 -520 1 0 {name=p23 sig_type=std_logic lab=vg}
C {lab_pin.sym} 1530 -360 0 0 {name=p25 sig_type=std_logic lab=clkb
}
C {capa.sym} 1010 -560 0 0 {name=C2
m=1
value=200f
footprint=1206
device="ceramic capacitor"}
C {lab_pin.sym} 880 -660 2 0 {name=p9 sig_type=std_logic lab=vss}
C {lab_pin.sym} 880 -560 2 0 {name=p10 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 720 -340 2 0 {name=p30 sig_type=std_logic lab=vss}
C {lab_pin.sym} 700 -300 3 0 {name=p11 sig_type=std_logic lab=vss}
C {lab_pin.sym} 870 -340 2 0 {name=p14 sig_type=std_logic lab=vss}
C {lab_pin.sym} 780 -210 3 0 {name=p13 sig_type=std_logic lab=sample_en}
C {lab_pin.sym} 1300 -340 2 0 {name=p15 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 1310 -500 2 0 {name=p17 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 1270 -550 1 0 {name=p18 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 1540 -460 0 0 {name=p19 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 1010 -520 3 0 {name=p24 sig_type=std_logic lab=vss}
C {lab_pin.sym} 1690 -400 2 0 {name=p27 sig_type=std_logic lab=vss}
C {symbols/nfet_03v3.sym} 740 -660 0 0 {name=M1
L=0.28u
W=5u
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
C {symbols/pfet_03v3.sym} 740 -560 0 0 {name=M2
L=0.28u
W=5u
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
C {symbols/nfet_03v3.sym} 680 -340 0 0 {name=M3
L=0.28u
W=2u
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
C {symbols/nfet_03v3.sym} 830 -340 0 0 {name=M4
L=0.28u
W=2u
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
C {symbols/pfet_03v3.sym} 1250 -500 0 0 {name=M5
L=0.28u
W=2u
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
C {symbols/pfet_03v3.sym} 1250 -340 0 0 {name=M6
L=0.28u
W=2u
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
C {symbols/nfet_03v3.sym} 1590 -460 0 0 {name=M7
L=0.28u
W=2u
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
C {symbols/nfet_03v3.sym} 1590 -360 0 0 {name=M8
L=0.28u
W=2u
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
C {inv_sh.sym} 240 -580 0 0 {name=xinv2}
