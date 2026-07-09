v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -550 -320 -550 -290 {lab=VDD}
N -380 -320 -380 -290 {lab=VDD}
N -220 -320 -220 -290 {lab=VDD}
N -70 -320 -70 -290 {lab=VDD}
N -550 -170 -550 -140 {lab=0}
N -380 -170 -380 -140 {lab=0}
N -220 -170 -220 -140 {lab=0}
N -70 -170 -70 -140 {lab=0}
N -550 -320 -70 -320 {lab=VDD}
N -310 -360 -310 -320 {lab=VDD}
N -550 -140 -70 -140 {lab=0}
N -310 -140 -310 -90 {lab=0}
N -620 -290 -590 -290 {lab=in}
N -620 -290 -620 -170 {lab=in}
N -620 -170 -590 -170 {lab=in}
N -550 -260 -550 -200 {lab=#net1}
N -440 -290 -420 -290 {lab=#net1}
N -440 -290 -440 -170 {lab=#net1}
N -440 -170 -420 -170 {lab=#net1}
N -550 -230 -440 -230 {lab=#net1}
N -380 -260 -380 -200 {lab=#net2}
N -280 -290 -260 -290 {lab=#net2}
N -280 -290 -280 -230 {lab=#net2}
N -380 -230 -280 -230 {lab=#net2}
N -280 -230 -280 -170 {lab=#net2}
N -280 -170 -260 -170 {lab=#net2}
N -220 -260 -220 -200 {lab=#net3}
N -70 -260 -70 -200 {lab=xxx}
N -130 -290 -110 -290 {lab=#net3}
N -130 -290 -130 -230 {lab=#net3}
N -220 -230 -130 -230 {lab=#net3}
N -130 -230 -130 -170 {lab=#net3}
N -130 -170 -110 -170 {lab=#net3}
N -70 -230 50 -230 {lab=xxx}
N -700 -230 -620 -230 {lab=in}
C {symbols/pfet_03v3.sym} -570 -290 0 0 {name=M1
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
C {symbols/nfet_03v3.sym} -570 -170 0 0 {name=M5
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
C {symbols/pfet_03v3.sym} -400 -290 0 0 {name=M2
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
C {symbols/pfet_03v3.sym} -240 -290 0 0 {name=M3
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
C {symbols/pfet_03v3.sym} -90 -290 0 0 {name=M4
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
C {symbols/nfet_03v3.sym} -400 -170 0 0 {name=M6
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
C {symbols/nfet_03v3.sym} -240 -170 0 0 {name=M7
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
C {symbols/nfet_03v3.sym} -90 -170 0 0 {name=M8
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
C {vdd.sym} -310 -360 0 0 {name=l1 lab=VDD}
C {gnd.sym} -310 -90 0 0 {name=l2 lab=0}
C {ipin.sym} -700 -230 0 0 {name=p1 lab=in}
C {opin.sym} 50 -230 0 0 {name=p2 lab=out
}
