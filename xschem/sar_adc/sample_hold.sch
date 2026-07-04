v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 480 -750 590 -750 {lab=sample_en}
N 690 -900 690 -820 {lab=vdd}
N 690 -680 690 -600 {lab=vss}
N 790 -750 850 -750 {lab=clkb}
N 1110 -970 1110 -930 {lab=vin}
N 960 -970 1110 -970 {lab=vin}
N 960 -970 960 -850 {lab=vin}
N 950 -850 960 -850 {lab=vin}
N 1110 -770 1110 -730 {lab=vin}
N 960 -730 1110 -730 {lab=vin}
N 960 -850 960 -730 {lab=vin}
N 1110 -870 1110 -830 {lab=vhold}
N 1110 -900 1230 -900 {lab=vss}
N 1110 -800 1230 -800 {lab=vdd}
N 1010 -900 1070 -900 {lab=vg}
N 1010 -930 1010 -900 {lab=vg}
N 1240 -660 1310 -660 {lab=#net1}
N 1120 -660 1240 -660 {lab=#net1}
N 1120 -660 1120 -610 {lab=#net1}
N 1120 -610 1200 -610 {lab=#net1}
N 1050 -610 1120 -610 {lab=#net1}
N 1050 -580 1070 -580 {lab=vss}
N 1200 -580 1220 -580 {lab=vss}
N 1050 -550 1050 -540 {lab=vss}
N 960 -730 960 -480 {lab=vin}
N 960 -480 1200 -480 {lab=vin}
N 1200 -550 1200 -480 {lab=vin}
N 1010 -770 1030 -770 {lab=clkb}
N 1030 -800 1070 -800 {lab=clkb}
N 1030 -800 1030 -770 {lab=clkb}
N 1010 -750 1010 -580 {lab=clkb}
N 1010 -750 1030 -750 {lab=clkb}
N 1030 -770 1030 -750 {lab=clkb}
N 1130 -580 1160 -580 {lab=sample_en}
N 1130 -580 1130 -450 {lab=sample_en}
N 1620 -710 1620 -660 {lab=vg}
N 1370 -660 1620 -660 {lab=vg}
N 1620 -660 1620 -610 {lab=vg}
N 1620 -580 1650 -580 {lab=vdd}
N 1620 -740 1660 -740 {lab=vdd}
N 1620 -790 1620 -770 {lab=vdd}
N 1550 -740 1580 -740 {lab=vg}
N 1530 -580 1580 -580 {lab=clkb}
N 1620 -550 1620 -500 {lab=vg}
N 1620 -500 1760 -500 {lab=vg}
N 1620 -660 1760 -660 {lab=vg}
N 1760 -660 1760 -500 {lab=vg}
N 1760 -660 1780 -660 {lab=vg}
N 1960 -760 1960 -730 {lab=vg}
N 1960 -670 1960 -630 {lab=#net2}
N 1890 -700 1920 -700 {lab=vdd}
N 1880 -600 1920 -600 {lab=clkb}
N 1960 -700 2040 -700 {lab=vss}
N 2040 -700 2040 -600 {lab=vss}
N 1960 -600 2040 -600 {lab=vss}
N 1960 -570 1960 -550 {lab=vss}
N 1960 -550 2040 -550 {lab=vss}
N 2040 -600 2040 -550 {lab=vss}
N 1360 -770 1360 -760 {lab=vss}
N 1110 -850 1420 -850 {lab=vhold}
N 1360 -850 1360 -830 {lab=vhold}
C {title.sym} 160 -40 0 0 {name=l1 author="Berkah Saluyu"}
C {ipin.sym} 950 -850 0 0 {name=p1 lab=vin}
C {ipin.sym} 480 -750 0 0 {name=p2 lab=sample_en
}
C {opin.sym} 1420 -850 0 0 {name=p3 lab=vhold}
C {iopin.sym} 690 -900 3 0 {name=p4 lab=vdd}
C {iopin.sym} 690 -600 1 0 {name=p5 lab=vss}
C {lab_pin.sym} 850 -750 2 0 {name=p6 sig_type=std_logic lab=clkb
}
C {lab_pin.sym} 1010 -930 1 0 {name=p7 sig_type=std_logic lab=vg}
C {lab_pin.sym} 1010 -770 0 0 {name=p8 sig_type=std_logic lab=clkb
}
C {capa.sym} 1340 -660 3 0 {name=C1
m=1
value=500f
footprint=1206
device="ceramic capacitor"}
C {lab_pin.sym} 1550 -740 0 0 {name=p20 sig_type=std_logic lab=vg}
C {lab_pin.sym} 1530 -580 0 0 {name=p21 sig_type=std_logic lab=clkb
}
C {lab_pin.sym} 1780 -660 2 0 {name=p22 sig_type=std_logic lab=vg}
C {lab_pin.sym} 1960 -760 1 0 {name=p23 sig_type=std_logic lab=vg}
C {lab_pin.sym} 1880 -600 0 0 {name=p25 sig_type=std_logic lab=clkb
}
C {capa.sym} 1360 -800 0 0 {name=C2
m=1
value=200f
footprint=1206
device="ceramic capacitor"}
C {lab_pin.sym} 1230 -900 2 0 {name=p9 sig_type=std_logic lab=vss}
C {lab_pin.sym} 1230 -800 2 0 {name=p10 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 1070 -580 2 0 {name=p30 sig_type=std_logic lab=vss}
C {lab_pin.sym} 1050 -540 3 0 {name=p11 sig_type=std_logic lab=vss}
C {lab_pin.sym} 1220 -580 2 0 {name=p14 sig_type=std_logic lab=vss}
C {lab_pin.sym} 1130 -450 3 0 {name=p13 sig_type=std_logic lab=sample_en}
C {lab_pin.sym} 1650 -580 2 0 {name=p15 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 1660 -740 2 0 {name=p17 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 1620 -790 1 0 {name=p18 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 1890 -700 0 0 {name=p19 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 1360 -760 3 0 {name=p24 sig_type=std_logic lab=vss}
C {lab_pin.sym} 2040 -640 2 0 {name=p27 sig_type=std_logic lab=vss}
C {symbols/nfet_03v3.sym} 1090 -900 0 0 {name=M1
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
C {symbols/pfet_03v3.sym} 1090 -800 0 0 {name=M2
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
C {symbols/nfet_03v3.sym} 1030 -580 0 0 {name=M3
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
C {symbols/nfet_03v3.sym} 1180 -580 0 0 {name=M4
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
C {symbols/pfet_03v3.sym} 1600 -740 0 0 {name=M5
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
C {symbols/pfet_03v3.sym} 1600 -580 0 0 {name=M6
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
C {symbols/nfet_03v3.sym} 1940 -700 0 0 {name=M7
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
C {symbols/nfet_03v3.sym} 1940 -600 0 0 {name=M8
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
C {inv_sh.sym} 590 -820 0 0 {name=xinv2}
