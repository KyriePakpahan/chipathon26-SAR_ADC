v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -90 -170 -70 -170 {lab=input}
N -90 -110 -90 -60 {lab=input}
N -90 -60 -70 -60 {lab=input}
N -30 -140 -30 -90 {lab=out}
N -90 -170 -90 -110 {lab=input}
N -30 -170 0 -170 {lab=VDD}
N -30 -200 0 -200 {lab=VDD}
N 0 -200 0 -170 {lab=VDD}
N -30 -60 0 -60 {lab=0}
N 0 -60 0 -30 {lab=0}
N -30 -30 0 -30 {lab=0}
N -30 -110 30 -110 {lab=out}
C {symbols/pfet_03v3.sym} -50 -170 0 0 {name=M5
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
C {symbols/nfet_03v3.sym} -50 -60 0 0 {name=M6
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
C {ipin.sym} -90 -110 0 0 {name=p1 lab=input
}
C {opin.sym} 30 -110 0 0 {name=p2 lab=output

}
C {vdd.sym} 0 -200 0 0 {name=l1 lab=VDD}
C {gnd.sym} 0 -30 0 0 {name=l2 lab=0}
