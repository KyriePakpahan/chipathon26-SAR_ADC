v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
C {title.sym} 160 -40 0 0 {name=l1 author="Berkah Saluyu"}
C {ipin.sym} -200 -370 0 0 {name=p1 lab=vin_p}
C {ipin.sym} 1090 -380 0 0 {name=p2 lab=vin_n}
C {ipin.sym} -200 -260 0 0 {name=p3 lab=rst_latch}
C {iopin.sym} 480 -730 3 0 {name=p4 lab=vdd}
C {iopin.sym} 480 -140 1 0 {name=p5 lab=vss}
C {opin.sym} -230 -420 0 0 {name=p6 lab=out_p}
C {opin.sym} 1070 -430 0 0 {name=p7 lab=out_n}
C {symbols/nfet_03v3.sym} 450 -230 0 0 {name=Mtail
L=0.28u
W=6.00u
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
C {lab_wire.sym} 470 -200 2 0 {name=l_mt_d lab=net1}
C {lab_wire.sym} 430 -230 0 0 {name=l_mt_g lab=rst_latch}
C {lab_wire.sym} 470 -260 2 0 {name=l_mt_s lab=vss}
C {lab_wire.sym} 470 -230 2 0 {name=l_mt_b lab=vss}
C {symbols/nfet_03v3.sym} 300 -350 0 0 {name=M1
L=0.28u
W=4.20u
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
C {lab_wire.sym} 320 -320 2 0 {name=l_m1_d lab=net2}
C {lab_wire.sym} 280 -350 0 0 {name=l_m1_g lab=vin_p}
C {lab_wire.sym} 320 -380 2 0 {name=l_m1_s lab=net1}
C {lab_wire.sym} 320 -350 2 0 {name=l_m1_b lab=vss}
C {symbols/nfet_03v3.sym} 600 -350 0 0 {name=M2
L=0.28u
W=4.20u
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
C {lab_wire.sym} 620 -320 2 0 {name=l_m2_d lab=net3}
C {lab_wire.sym} 580 -350 0 0 {name=l_m2_g lab=vin_n}
C {lab_wire.sym} 620 -380 2 0 {name=l_m2_s lab=net1}
C {lab_wire.sym} 620 -350 2 0 {name=l_m2_b lab=vss}
C {symbols/nfet_03v3.sym} 300 -480 0 0 {name=M3
L=0.28u
W=2.00u
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
C {lab_wire.sym} 320 -450 2 0 {name=l_m3_d lab=out_p}
C {lab_wire.sym} 280 -480 0 0 {name=l_m3_g lab=out_n}
C {lab_wire.sym} 320 -510 2 0 {name=l_m3_s lab=net2}
C {lab_wire.sym} 320 -480 2 0 {name=l_m3_b lab=vss}
C {symbols/nfet_03v3.sym} 600 -480 0 0 {name=M4
L=0.28u
W=2.00u
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
C {lab_wire.sym} 620 -450 2 0 {name=l_m4_d lab=out_n}
C {lab_wire.sym} 580 -480 0 0 {name=l_m4_g lab=out_p}
C {lab_wire.sym} 620 -510 2 0 {name=l_m4_s lab=net3}
C {lab_wire.sym} 620 -480 2 0 {name=l_m4_b lab=vss}
C {symbols/pfet_03v3.sym} 300 -620 0 0 {name=M5
L=0.28u
W=3.00u
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
C {lab_wire.sym} 320 -590 2 0 {name=l_m5_d lab=out_p}
C {lab_wire.sym} 280 -620 0 0 {name=l_m5_g lab=out_n}
C {lab_wire.sym} 320 -650 2 0 {name=l_m5_s lab=vdd}
C {lab_wire.sym} 320 -620 2 0 {name=l_m5_b lab=vdd}
C {symbols/pfet_03v3.sym} 600 -620 0 0 {name=M6
L=0.28u
W=3.00u
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
C {lab_wire.sym} 620 -590 2 0 {name=l_m6_d lab=out_n}
C {lab_wire.sym} 580 -620 0 0 {name=l_m6_g lab=out_p}
C {lab_wire.sym} 620 -650 2 0 {name=l_m6_s lab=vdd}
C {lab_wire.sym} 620 -620 2 0 {name=l_m6_b lab=vdd}
C {symbols/pfet_03v3.sym} 100 -620 0 0 {name=M7
L=0.28u
W=1.00u
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
C {lab_wire.sym} 120 -590 2 0 {name=l_m7_d lab=out_p}
C {lab_wire.sym} 80 -620 0 0 {name=l_m7_g lab=rst_latch}
C {lab_wire.sym} 120 -650 2 0 {name=l_m7_s lab=vdd}
C {lab_wire.sym} 120 -620 2 0 {name=l_m7_b lab=vdd}
C {symbols/pfet_03v3.sym} 800 -620 0 0 {name=M8
L=0.28u
W=1.00u
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
C {lab_wire.sym} 820 -590 2 0 {name=l_m8_d lab=out_n}
C {lab_wire.sym} 780 -620 0 0 {name=l_m8_g lab=rst_latch}
C {lab_wire.sym} 820 -650 2 0 {name=l_m8_s lab=vdd}
C {lab_wire.sym} 820 -620 2 0 {name=l_m8_b lab=vdd}
C {symbols/pfet_03v3.sym} 100 -480 0 0 {name=M9
L=0.28u
W=1.00u
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
C {lab_wire.sym} 120 -450 2 0 {name=l_m9_d lab=net2}
C {lab_wire.sym} 80 -480 0 0 {name=l_m9_g lab=rst_latch}
C {lab_wire.sym} 120 -510 2 0 {name=l_m9_s lab=vdd}
C {lab_wire.sym} 120 -480 2 0 {name=l_m9_b lab=vdd}
C {symbols/pfet_03v3.sym} 800 -480 0 0 {name=M10
L=0.28u
W=1.00u
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
C {lab_wire.sym} 820 -450 2 0 {name=l_m10_d lab=net3}
C {lab_wire.sym} 780 -480 0 0 {name=l_m10_g lab=rst_latch}
C {lab_wire.sym} 820 -510 2 0 {name=l_m10_s lab=vdd}
C {lab_wire.sym} 820 -480 2 0 {name=l_m10_b lab=vdd}
