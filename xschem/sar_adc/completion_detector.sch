v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 0 0 -0 20 {lab=#net1}
N 0 -100 -0 -60 {lab=VDD}
N -0 -30 30 -30 {lab=VDD}
N 30 -60 30 -30 {lab=VDD}
N -0 50 30 50 {lab=VDD}
N 30 -100 30 -60 {lab=VDD}
N 0 -100 30 -100 {lab=VDD}
N 30 40 30 50 {lab=VDD}
N 30 -30 30 40 {lab=VDD}
N -90 140 -90 150 {lab=done}
N -90 120 -90 140 {lab=done}
N -90 120 -20 120 {lab=done}
N 20 120 100 120 {lab=done}
N 100 120 100 150 {lab=done}
N -90 210 -90 230 {lab=0}
N -70 230 80 230 {lab=0}
N 100 210 100 230 {lab=0}
N -90 180 -60 180 {lab=0}
N -60 180 -60 230 {lab=0}
N 80 230 110 230 {lab=0}
N -70 -30 -40 -30 {lab=out_p}
N -70 50 -40 50 {lab=out_n}
N -20 120 20 120 {lab=done}
N 0 80 0 120 {lab=done}
N -90 230 -70 230 {lab=0}
N 100 180 130 180 {lab=0}
N 130 180 130 230 {lab=0}
N 110 230 130 230 {lab=0}
N 0 230 0 250 {lab=0}
N -0 100 170 100 {lab=done}
N -30 180 60 180 {lab=out_n}
N -30 90 -30 180 {lab=out_n}
N -60 90 -30 90 {lab=out_n}
N -60 50 -60 90 {lab=out_n}
N -90 -30 -70 -30 {lab=out_p}
N -230 -30 -230 70 {lab=out_p}
N -230 -30 -90 -30 {lab=out_p}
N -230 180 -130 180 {lab=out_p}
N -230 70 -230 180 {lab=out_p}
C {symbols/pfet_03v3.sym} -20 -30 0 0 {name=M1
L=0.28u
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
C {symbols/pfet_03v3.sym} -20 50 0 0 {name=M2
L=0.28u
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
C {vdd.sym} 0 -100 0 0 {name=l1 lab=VDD}
C {gnd.sym} 0 250 0 0 {name=l2 lab=0}
C {symbols/nfet_03v3.sym} -110 180 0 0 {name=M3
L=0.28u
W=0.30u
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
C {symbols/nfet_03v3.sym} 80 180 0 0 {name=M4
L=0.28u
W=0.30u
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
C {ipin.sym} -230 70 0 0 {name=p1 lab=out_p
}
C {ipin.sym} -70 50 0 0 {name=p3 lab=out_n
}
C {opin.sym} 170 100 0 0 {name=p5 lab=done}
