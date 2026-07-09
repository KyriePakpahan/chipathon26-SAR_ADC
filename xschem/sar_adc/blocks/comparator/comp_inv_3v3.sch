v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {Simple CMOS Inverter
} 380 -520 0 0 0.4 0.4 {}
N 520 -430 600 -430 {lab=vi}
N 520 -430 520 -360 {lab=vi}
N 520 -360 520 -280 {lab=vi}
N 520 -280 600 -280 {lab=vi}
N 640 -510 640 -460 {lab=vdd}
N 640 -400 640 -310 {lab=vo}
N 640 -360 760 -360 {lab=vo}
N 490 -360 520 -360 {lab=vi}
N 640 -430 690 -430 {lab=vdd}
N 690 -480 690 -430 {lab=vdd}
N 640 -480 690 -480 {lab=vdd}
N 640 -250 640 -200 {lab=vss}
N 640 -280 690 -280 {lab=vss}
N 690 -280 690 -220 {lab=vss}
N 640 -220 690 -220 {lab=vss}
C {title.sym} 180 -60 0 0 {name=l1 author="Afdhal Razaq"}
C {symbols/pfet_03v3.sym} 620 -430 0 0 {name=M2
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
C {symbols/nfet_03v3.sym} 620 -280 0 0 {name=M1
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
model=nfet_03v3
spiceprefix=X
}
C {devices/ipin.sym} 490 -360 0 0 {name=p3 lab=vi}
C {devices/opin.sym} 760 -360 0 0 {name=p4 lab=vo}
C {devices/iopin.sym} 640 -510 3 0 {name=p1 lab=vdd}
C {devices/iopin.sym} 640 -200 1 0 {name=p2 lab=vss}
