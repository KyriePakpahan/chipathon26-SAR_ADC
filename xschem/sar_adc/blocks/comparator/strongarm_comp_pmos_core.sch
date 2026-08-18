v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 470 -750 470 -730 {lab=vdd}
N 360 -700 430 -700 {lab=rst_latch_b}
N 490 -700 490 -740 {lab=vdd}
N 260 -590 290 -590 {lab=vin_p}
N 490 -590 520 -590 {lab=vin_n}
N 330 -620 560 -620 {lab=#net1}
N 470 -620 470 -670 {lab=#net1}
N 330 -510 330 -560 {lab=#net2}
N 560 -510 560 -560 {lab=#net3}
N 330 -320 330 -450 {lab=out_p}
N 560 -320 560 -450 {lab=out_n}
N 330 -210 440 -210 {lab=vss}
N 330 -210 330 -260 {lab=vss}
N 440 -210 560 -210 {lab=vss}
N 560 -210 560 -260 {lab=vss}
N 260 -290 330 -290 {lab=vss}
N 260 -250 260 -290 {lab=vss}
N 260 -250 330 -250 {lab=vss}
N 560 -290 630 -290 {lab=vss}
N 630 -250 630 -290 {lab=vss}
N 560 -250 630 -250 {lab=vss}
N 370 -290 410 -290 {lab=out_n}
N 410 -290 480 -330 {lab=out_n}
N 480 -330 560 -330 {lab=out_n}
N 410 -330 480 -290 {lab=out_p}
N 330 -330 410 -330 {lab=out_p}
N 100 -800 200 -800 {lab=rst_latch}
N 200 -800 200 -730 {lab=rst_latch}
N 300 -730 360 -730 {lab=rst_latch_b}
N 360 -730 360 -700 {lab=rst_latch_b}

C {title.sym} 160 -40 0 0 {name=l1 author="Berkah Saluyu"}
C {ipin.sym} 260 -590 0 0 {name=p1 lab=vin_p}
C {ipin.sym} 490 -590 0 0 {name=p2 lab=vin_n}
C {ipin.sym} 100 -800 0 0 {name=p3 lab=rst_latch}
C {iopin.sym} 440 -750 3 0 {name=p4 lab=vdd}
C {iopin.sym} 470 -210 1 0 {name=p5 lab=vss}
C {opin.sym} 330 -380 0 0 {name=p6 lab=out_p}
C {opin.sym} 560 -380 0 0 {name=p7 lab=out_n}

# Inverter for active-low reset to PMOS tail
C {sar_adc/blocks/async_sar/async_inverter.sym} 250 -730 0 0 {name=x_rst_inv}
C {lab_wire.sym} 200 -730 0 0 {name=l_ri_in lab=rst_latch}
C {lab_wire.sym} 300 -730 2 0 {name=l_ri_out lab=rst_latch_b}

# Mtail: PFET tied to VDD, active low gate rst_latch_b
C {symbols/pfet_03v3.sym} 450 -700 0 0 {name=Mtail
L=0.28u
W=0.80u
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

# M1, M2: PFET Input Differential Pair
C {symbols/pfet_03v3.sym} 310 -590 0 0 {name=M1
L=0.28u
W=0.80u
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

C {symbols/pfet_03v3.sym} 540 -590 0 0 {name=M2
L=0.28u
W=0.80u
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

# M3, M4: PFET Regenerative Cross-Coupled Pair
C {symbols/pfet_03v3.sym} 350 -480 0 1 {name=M3
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
model=pfet_03v3
spiceprefix=X
}

C {symbols/pfet_03v3.sym} 540 -480 0 0 {name=M4
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
model=pfet_03v3
spiceprefix=X
}

# M5, M6: NFET Bottom Cross-Coupled Pair tied to VSS
C {symbols/nfet_03v3.sym} 350 -290 0 1 {name=M5
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

C {symbols/nfet_03v3.sym} 540 -290 0 0 {name=M6
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

# Reset Transistors (NFETs pulling out_p, out_n to VSS during rst_latch=0)
C {symbols/nfet_03v3.sym} 190 -290 0 1 {name=M7
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

C {symbols/nfet_03v3.sym} 700 -290 0 0 {name=M8
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
