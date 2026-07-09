v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
P 4 1 620 -30 {}
N 520 -570 520 -550 {lab=vdd}
N 380 -550 520 -550 {lab=vdd}
N 380 -550 380 -520 {lab=vdd}
N 520 -550 650 -550 {lab=vdd}
N 650 -550 650 -520 {lab=vdd}
N 380 -490 440 -490 {lab=vdd}
N 440 -530 440 -490 {lab=vdd}
N 380 -530 440 -530 {lab=vdd}
N 650 -490 710 -490 {lab=vdd}
N 710 -530 710 -490 {lab=vdd}
N 650 -530 710 -530 {lab=vdd}
N 520 -190 520 -150 {lab=vss}
N 380 -460 380 -410 {lab=y}
N 380 -410 520 -410 {lab=y}
N 520 -410 520 -380 {lab=y}
N 650 -460 650 -410 {lab=y}
N 520 -410 650 -410 {lab=y}
N 520 -220 560 -220 {lab=vss}
N 560 -220 560 -180 {lab=vss}
N 520 -180 560 -180 {lab=vss}
N 520 -350 570 -350 {lab=vss}
N 310 -490 340 -490 {lab=a}
N 580 -490 610 -490 {lab=b}
N 460 -220 480 -220 {lab=b}
N 460 -350 480 -350 {lab=a}
N 520 -320 520 -250 {lab=#net1}
C {symbols/pfet_03v3.sym} 360 -490 0 0 {name=M1
L=0.28u
W=0.22u
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
C {title.sym} 160 -40 0 0 {name=l1 author="Berkah Saluyu"}
C {symbols/pfet_03v3.sym} 630 -490 0 0 {name=M2
L=0.28u
W=0.22u
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
C {iopin.sym} 520 -570 3 0 {name=p1 lab=vdd}
C {symbols/nfet_03v3.sym} 500 -350 0 0 {name=M3
L=0.28u
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
C {symbols/nfet_03v3.sym} 500 -220 0 0 {name=M4
L=0.28u
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
C {iopin.sym} 520 -150 1 0 {name=p2 lab=vss
}
C {lab_pin.sym} 520 -170 0 0 {name=p3 sig_type=std_logic lab=vss}
C {lab_pin.sym} 570 -350 2 0 {name=p4 sig_type=std_logic lab=vss}
C {opin.sym} 520 -400 0 0 {name=p5 lab=y}
C {ipin.sym} 310 -490 0 0 {name=p6 lab=a}
C {ipin.sym} 580 -490 0 0 {name=p7 lab=b}
C {lab_pin.sym} 320 -490 3 0 {name=p8 sig_type=std_logic lab=a}
C {lab_pin.sym} 590 -490 3 0 {name=p9 sig_type=std_logic lab=b}
C {lab_pin.sym} 460 -350 0 0 {name=p10 sig_type=std_logic lab=a}
C {lab_pin.sym} 460 -220 0 0 {name=p11 sig_type=std_logic lab=b}
