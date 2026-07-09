v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -300 -100 -300 -70 {lab=#net1}
N -300 -300 -220 -300 {lab=VDD}
N -220 -300 -220 -270 {lab=VDD}
N -380 -300 -300 -300 {lab=VDD}
N -380 -300 -380 -270 {lab=VDD}
N -380 -210 -380 -180 {lab=output}
N -300 -180 -220 -180 {lab=output}
N -220 -210 -220 -180 {lab=output}
N -300 -330 -300 -300 {lab=VDD}
N -300 -180 -300 -160 {lab=output}
N -220 -180 -120 -180 {lab=output}
N -320 -300 -320 -240 {lab=VDD}
N -220 -240 -180 -240 {lab=VDD}
N -220 -300 -170 -300 {lab=VDD}
N -170 -300 -170 -240 {lab=VDD}
N -180 -240 -170 -240 {lab=VDD}
N -380 -240 -320 -240 {lab=VDD}
N -300 -130 -270 -130 {lab=0}
N -240 -80 -240 -10 {lab=0}
N -270 -130 -240 -130 {lab=0}
N -240 -130 -240 -80 {lab=0}
N -520 -300 -440 -300 {lab=VDD}
N -520 -300 -520 -270 {lab=VDD}
N -520 -210 -520 -180 {lab=output}
N -440 -180 -360 -180 {lab=output}
N -460 -300 -460 -240 {lab=VDD}
N -520 -240 -460 -240 {lab=VDD}
N -440 -300 -380 -300 {lab=VDD}
N -520 -180 -440 -180 {lab=output}
N -300 80 -270 80 {lab=0}
N -300 50 -270 50 {lab=0}
N -240 10 -240 80 {lab=0}
N -270 80 -240 80 {lab=0}
N -300 -10 -300 20 {lab=#net2}
N -270 80 -270 110 {lab=0}
N -240 -10 -240 10 {lab=0}
N -300 -40 -240 -40 {lab=0}
N -360 -180 -300 -180 {lab=output}
N -270 50 -240 50 {lab=0}
C {symbols/nfet_03v3.sym} -320 -40 0 0 {name=M2
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
C {symbols/pfet_03v3.sym} -400 -240 0 0 {name=M3
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
C {symbols/pfet_03v3.sym} -240 -240 0 0 {name=M1
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
C {symbols/nfet_03v3.sym} -320 -130 0 0 {name=M4
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
C {symbols/pfet_03v3.sym} -540 -240 0 0 {name=M5
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
C {symbols/nfet_03v3.sym} -320 50 0 0 {name=M6
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
C {vdd.sym} -300 -330 0 0 {name=l1 lab=VDD}
C {gnd.sym} -270 110 0 0 {name=l2 lab=0}
C {ipin.sym} -740 -220 0 0 {name=p1 lab=input_A}
C {ipin.sym} -740 -200 0 0 {name=p2 lab=input_B}
C {ipin.sym} -740 -240 0 0 {name=p15 lab=input_C}
C {opin.sym} -120 -180 0 0 {name=p9 lab=output}
C {lab_wire.sym} -740 -240 2 0 {name=p13 sig_type=std_logic lab=input_C}
C {lab_wire.sym} -740 -220 2 0 {name=p4 sig_type=std_logic lab=input_A}
C {lab_wire.sym} -740 -200 2 0 {name=p5 sig_type=std_logic lab=input_B}
C {lab_wire.sym} -560 -240 0 0 {name=p3 sig_type=std_logic lab=input_C}
C {lab_wire.sym} -420 -240 0 0 {name=p7 sig_type=std_logic lab=input_A}
C {lab_wire.sym} -260 -240 0 0 {name=p10 sig_type=std_logic lab=input_B}
C {lab_wire.sym} -340 -130 0 0 {name=p6 sig_type=std_logic lab=input_C}
C {lab_wire.sym} -340 -40 0 0 {name=p8 sig_type=std_logic lab=input_A}
C {lab_wire.sym} -340 50 0 0 {name=p11 sig_type=std_logic lab=input_B}
