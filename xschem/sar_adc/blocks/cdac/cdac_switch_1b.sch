v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -150 -300 -50 -300 {lab=bit}
N -150 -240 -50 -240 {lab=vref}
N -150 -180 -50 -180 {lab=vdd}
N -150 -120 -50 -120 {lab=vss}
N -150 -60 -50 -60 {lab=bot}
N 0 -200 30 -200 {lab=bit}
N 0 -100 30 -100 {lab=bit}
N 70 -250 70 -230 {lab=vdd}
N 70 -200 100 -200 {lab=vdd}
N 70 -170 70 -130 {lab=bit_b}
N 70 -150 110 -150 {lab=bit_b}
N 70 -70 70 -50 {lab=vss}
N 70 -100 100 -100 {lab=vss}
N 270 -230 370 -230 {lab=vref}
N 200 -230 270 -230 {lab=vref}
N 200 -200 230 -200 {lab=bit_b}
N 270 -200 290 -200 {lab=vdd}
N 300 -200 330 -200 {lab=bit}
N 370 -200 390 -200 {lab=vss}
N 270 -170 370 -170 {lab=bot}
N 370 -170 410 -170 {lab=bot}
N 270 -80 370 -80 {lab=vss}
N 200 -80 270 -80 {lab=vss}
N 200 -50 230 -50 {lab=bit}
N 270 -50 290 -50 {lab=vdd}
N 300 -50 330 -50 {lab=bit_b}
N 370 -50 390 -50 {lab=vss}
N 270 -20 370 -20 {lab=bot}
N 370 -20 410 -20 {lab=bot}
C {title.sym} 160 100 0 0 {name=l1 author="Berkah Saluyu"}
C {ipin.sym} -150 -300 0 0 {name=p_bit lab=bit}
C {lab_wire.sym} -50 -300 2 0 {name=l_bit lab=bit}
C {iopin.sym} -150 -240 0 0 {name=p_vref lab=vref}
C {lab_wire.sym} -50 -240 2 0 {name=l_vref lab=vref}
C {iopin.sym} -150 -180 0 0 {name=p_vdd lab=vdd}
C {lab_wire.sym} -50 -180 2 0 {name=l_vdd lab=vdd}
C {iopin.sym} -150 -120 0 0 {name=p_vss lab=vss}
C {lab_wire.sym} -50 -120 2 0 {name=l_vss lab=vss}
C {iopin.sym} -150 -60 0 0 {name=p_bot lab=bot}
C {lab_wire.sym} -50 -60 2 0 {name=l_bot lab=bot}
C {symbols/pfet_03v3.sym} 50 -200 0 0 {name=M1
L=0.28u
W=0.8u
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
C {symbols/nfet_03v3.sym} 50 -100 0 0 {name=M2
L=0.28u
W=0.42u
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
C {lab_wire.sym} 0 -200 0 0 {name=l_inv_in1 lab=bit}
C {lab_wire.sym} 0 -100 0 0 {name=l_inv_in2 lab=bit}
C {lab_wire.sym} 70 -250 0 0 {name=l_inv_vdd1 lab=vdd}
C {lab_wire.sym} 100 -200 2 0 {name=l_inv_vdd2 lab=vdd}
C {lab_wire.sym} 110 -150 2 0 {name=l_inv_out lab=bit_b}
C {lab_wire.sym} 70 -50 0 0 {name=l_inv_vss1 lab=vss}
C {lab_wire.sym} 100 -100 2 0 {name=l_inv_vss2 lab=vss}
C {symbols/pfet_03v3.sym} 250 -200 0 0 {name=M3
L=0.28u
W=2.0u
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
C {symbols/nfet_03v3.sym} 350 -200 0 0 {name=M4
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
model=nfet_03v3
spiceprefix=X
}
C {lab_wire.sym} 200 -230 0 0 {name=l_vr_in lab=vref}
C {lab_wire.sym} 200 -200 0 0 {name=l_vr_g1 lab=bit_b}
C {lab_wire.sym} 290 -200 2 0 {name=l_vr_b1 lab=vdd}
C {lab_wire.sym} 300 -200 0 0 {name=l_vr_g2 lab=bit}
C {lab_wire.sym} 390 -200 2 0 {name=l_vr_b2 lab=vss}
C {lab_wire.sym} 410 -170 2 0 {name=l_vr_out lab=bot}
C {symbols/pfet_03v3.sym} 250 -50 0 0 {name=M5
L=0.28u
W=2.0u
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
C {symbols/nfet_03v3.sym} 350 -50 0 0 {name=M6
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
model=nfet_03v3
spiceprefix=X
}
C {lab_wire.sym} 200 -80 0 0 {name=l_vs_in lab=vss}
C {lab_wire.sym} 200 -50 0 0 {name=l_vs_g1 lab=bit}
C {lab_wire.sym} 290 -50 2 0 {name=l_vs_b1 lab=vdd}
C {lab_wire.sym} 300 -50 0 0 {name=l_vs_g2 lab=bit_b}
C {lab_wire.sym} 390 -50 2 0 {name=l_vs_b2 lab=vss}
C {lab_wire.sym} 410 -20 2 0 {name=l_vs_out lab=bot}
