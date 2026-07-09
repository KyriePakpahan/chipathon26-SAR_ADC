v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {Simple CMOS Inverter
} 550 -1040 0 0 0.4 0.4 {}
N 560 -770 620 -770 {lab=vi}
N 560 -770 560 -590 {lab=vi}
N 560 -590 620 -590 {lab=vi}
N 520 -680 560 -680 {lab=vi}
N 660 -740 660 -620 {lab=vo}
N 660 -680 840 -680 {lab=vo}
N 660 -920 660 -800 {lab=vdd}
N 660 -770 730 -770 {lab=vdd}
N 730 -840 730 -770 {lab=vdd}
N 660 -840 730 -840 {lab=vdd}
N 660 -590 750 -590 {lab=vss}
N 750 -590 750 -540 {lab=vss}
N 660 -540 750 -540 {lab=vss}
N 660 -560 660 -490 {lab=vss}
C {title.sym} 180 -30 0 0 {name=l1 author="IIC-OSIC-TUTOR INV Tutorials"}
C {symbols/nfet_03v3.sym} 640 -590 0 0 {name=M1
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
C {symbols/pfet_03v3.sym} 640 -770 0 0 {name=M2
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
C {iopin.sym} 660 -920 3 0 {name=p1 lab=vdd
}
C {ipin.sym} 520 -680 0 0 {name=p3 lab=vi
}
C {opin.sym} 840 -680 0 0 {name=p4 lab=vo
}
C {iopin.sym} 660 -490 1 0 {name=p2 lab=vss

}
