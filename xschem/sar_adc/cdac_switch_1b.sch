v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 260 -670 430 -670 {lab=vdd}
N 430 -670 430 -640 {lab=vdd}
N 310 -610 390 -610 {lab=bit}
N 430 -580 430 -530 {lab=bit_b}
N 430 -550 470 -550 {lab=bit_b}
N 430 -610 500 -610 {lab=vdd}
N 210 -810 290 -810 {lab=vdd}
N 210 -780 290 -780 {lab=vss}
N 360 -500 390 -500 {lab=bit}
N 360 -610 360 -500 {lab=bit}
N 430 -470 430 -440 {lab=vss}
N 430 -440 430 -420 {lab=vss}
N 630 -530 660 -530 {lab=bit_b}
N 700 -500 700 -460 {lab=bot}
N 700 -460 890 -460 {lab=bot}
N 890 -500 890 -460 {lab=bot}
N 700 -530 740 -530 {lab=vdd}
N 890 -530 950 -530 {lab=vss}
N 640 -630 700 -630 {lab=vref}
N 700 -630 700 -560 {lab=vref}
N 700 -630 890 -630 {lab=vref}
N 890 -630 890 -560 {lab=vref}
N 430 -420 430 -360 {lab=vss}
N 350 -420 430 -420 {lab=vss}
N 360 -330 390 -330 {lab=bit}
N 430 -330 480 -330 {lab=vdd}
N 670 -400 670 -360 {lab=vss}
N 430 -400 670 -400 {lab=vss}
N 670 -330 740 -330 {lab=vss}
N 610 -330 630 -330 {lab=bit_b}
N 430 -300 430 -260 {lab=bot}
N 430 -260 670 -260 {lab=bot}
N 670 -300 670 -260 {lab=bot}
N 810 -460 810 -200 {lab=bot}
N 540 -200 810 -200 {lab=bot}
N 540 -260 540 -200 {lab=bot}
N 680 -200 680 -160 {lab=bot}
N 430 -500 480 -500 {lab=vss}
N 830 -530 850 -530 {lab=bit}
N 210 -840 290 -840 {lab=vref}
N 210 -720 280 -720 {lab=bit}
N 210 -750 290 -750 {lab=bot}
C {title.sym} 160 -40 0 0 {name=l1 author="Berkah Saluyu"}
C {iopin.sym} 210 -810 2 0 {name=p1 lab=vdd
}
C {symbols/pfet_03v3.sym} 410 -610 0 0 {name=M1
L=0.28u
W=1u
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
C {symbols/nfet_03v3.sym} 410 -500 0 0 {name=M2
L=0.28u
W=0.5u
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
C {symbols/pfet_03v3.sym} 680 -530 0 0 {name=M3
L=0.28u
W=4u
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
C {symbols/nfet_03v3.sym} 870 -530 0 0 {name=M4
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
C {lab_pin.sym} 310 -610 0 0 {name=p3 sig_type=std_logic lab=bit}
C {lab_pin.sym} 470 -550 2 0 {name=p5 sig_type=std_logic lab=bit_b}
C {lab_pin.sym} 500 -610 2 0 {name=p6 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 290 -810 2 0 {name=p7 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 260 -670 0 0 {name=p8 sig_type=std_logic lab=vdd}
C {iopin.sym} 210 -780 2 0 {name=p9 lab=vss
}
C {lab_pin.sym} 290 -780 2 0 {name=p10 sig_type=std_logic lab=vss}
C {lab_pin.sym} 350 -420 0 0 {name=p11 sig_type=std_logic lab=vss}
C {symbols/pfet_03v3.sym} 410 -330 0 0 {name=M5
L=0.28u
W=4u
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
C {lab_pin.sym} 640 -630 0 0 {name=p14 sig_type=std_logic lab=vref}
C {lab_pin.sym} 630 -530 0 0 {name=p2 sig_type=std_logic lab=bit_b}
C {lab_pin.sym} 740 -530 2 0 {name=p4 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 950 -530 2 0 {name=p12 sig_type=std_logic lab=vss}
C {symbols/nfet_03v3.sym} 650 -330 0 0 {name=M6
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
C {lab_pin.sym} 360 -330 0 0 {name=p13 sig_type=std_logic lab=bit}
C {lab_pin.sym} 480 -330 2 0 {name=p15 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 740 -330 2 0 {name=p16 sig_type=std_logic lab=vss}
C {lab_pin.sym} 610 -330 0 0 {name=p17 sig_type=std_logic lab=bit_b}
C {lab_pin.sym} 680 -160 3 0 {name=p18 sig_type=std_logic lab=bot}
C {lab_pin.sym} 480 -500 2 0 {name=p19 sig_type=std_logic lab=vss}
C {lab_pin.sym} 830 -530 0 0 {name=p20 sig_type=std_logic lab=bit}
C {iopin.sym} 210 -840 2 0 {name=p21 lab=vref
}
C {lab_pin.sym} 290 -840 2 0 {name=p22 sig_type=std_logic lab=vref}
C {ipin.sym} 210 -720 0 0 {name=p23 lab=bit}
C {lab_pin.sym} 280 -720 2 0 {name=p24 sig_type=std_logic lab=bit}
C {iopin.sym} 210 -750 2 0 {name=p25 lab=bot

}
C {lab_pin.sym} 290 -750 2 0 {name=p26 sig_type=std_logic lab=bot}
