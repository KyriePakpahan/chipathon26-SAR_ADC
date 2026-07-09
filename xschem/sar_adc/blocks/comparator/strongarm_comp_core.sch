v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 450 -230 450 -210 {lab=vss}
N 360 -260 410 -260 {lab=rst_latch}
N 450 -260 490 -260 {lab=vss}
N 490 -260 490 -220 {lab=vss}
N 450 -220 490 -220 {lab=vss}
N 260 -370 290 -370 {lab=vin_p}
N 500 -370 520 -370 {lab=vin_n}
N 330 -340 330 -320 {lab=#net1}
N 330 -320 450 -320 {lab=#net1}
N 450 -320 450 -290 {lab=#net1}
N 560 -340 560 -320 {lab=#net1}
N 450 -320 560 -320 {lab=#net1}
N 560 -370 600 -370 {lab=vss}
N 330 -370 370 -370 {lab=vss}
N 330 -450 330 -400 {lab=#net2}
N 560 -450 560 -400 {lab=#net3}
N 330 -640 330 -510 {lab=out_p}
N 560 -640 560 -510 {lab=out_n}
N 370 -480 420 -480 {lab=out_n}
N 420 -480 480 -530 {lab=out_n}
N 480 -530 560 -530 {lab=out_n}
N 480 -480 520 -480 {lab=out_p}
N 420 -530 480 -480 {lab=out_p}
N 330 -530 420 -530 {lab=out_p}
N 330 -750 440 -750 {lab=vdd}
N 330 -750 330 -700 {lab=vdd}
N 440 -750 560 -750 {lab=vdd}
N 560 -750 560 -700 {lab=vdd}
N 260 -670 330 -670 {lab=vdd}
N 260 -710 260 -670 {lab=vdd}
N 260 -710 330 -710 {lab=vdd}
N 560 -670 630 -670 {lab=vdd}
N 630 -710 630 -670 {lab=vdd}
N 560 -710 630 -710 {lab=vdd}
N 370 -670 410 -670 {lab=out_n}
N 410 -670 480 -630 {lab=out_n}
N 480 -630 560 -630 {lab=out_n}
N 480 -670 520 -670 {lab=out_p}
N 410 -630 480 -670 {lab=out_p}
N 330 -630 410 -630 {lab=out_p}
N 140 -750 330 -750 {lab=vdd}
N 140 -750 140 -710 {lab=vdd}
N 560 -750 750 -750 {lab=vdd}
N 750 -750 750 -710 {lab=vdd}
N 140 -680 210 -680 {lab=vdd}
N 210 -720 210 -680 {lab=vdd}
N 140 -720 210 -720 {lab=vdd}
N 680 -680 750 -680 {lab=vdd}
N 680 -720 680 -680 {lab=vdd}
N 680 -720 750 -720 {lab=vdd}
N 140 -650 140 -630 {lab=out_p}
N 140 -630 330 -630 {lab=out_p}
N 750 -650 750 -630 {lab=out_n}
N 560 -630 750 -630 {lab=out_n}
N 60 -680 100 -680 {lab=rst_latch}
N 790 -680 820 -680 {lab=rst_latch}
N 260 -480 330 -480 {lab=vss}
N 560 -480 600 -480 {lab=vss}
N -20 -750 140 -750 {lab=vdd}
N -20 -750 -20 -710 {lab=vdd}
N -20 -680 40 -680 {lab=vdd}
N 40 -720 40 -680 {lab=vdd}
N -20 -720 40 -720 {lab=vdd}
N 750 -750 900 -750 {lab=vdd}
N 900 -750 900 -710 {lab=vdd}
N 840 -680 900 -680 {lab=vdd}
N 840 -720 840 -680 {lab=vdd}
N 840 -720 900 -720 {lab=vdd}
N -20 -650 -20 -420 {lab=#net2}
N -20 -420 330 -420 {lab=#net2}
N 900 -650 900 -420 {lab=#net3}
N 560 -420 900 -420 {lab=#net3}
N -100 -680 -60 -680 {lab=rst_latch}
N 940 -680 970 -680 {lab=rst_latch}
C {title.sym} 160 -40 0 0 {name=l1 author="Berkah Saluyu"}
C {ipin.sym} 260 -370 0 0 {name=p1 lab=vin_p
}
C {ipin.sym} 500 -370 0 0 {name=p2 lab=vin_n
}
C {ipin.sym} 360 -260 0 0 {name=p3 lab=rst_latch


}
C {iopin.sym} 440 -750 3 0 {name=p4 lab=vdd

}
C {iopin.sym} 450 -210 1 0 {name=p5 lab=vss


}
C {opin.sym} 330 -580 0 0 {name=p6 lab=out_p
}
C {opin.sym} 560 -580 0 0 {name=p7 lab=out_n}
C {symbols/nfet_03v3.sym} 430 -260 0 0 {name=Mtail
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
C {lab_pin.sym} 380 -260 3 0 {name=p9 sig_type=std_logic lab=rst_latch}
C {symbols/nfet_03v3.sym} 310 -370 0 0 {name=M1
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
C {symbols/nfet_03v3.sym} 540 -370 0 0 {name=M2
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
C {lab_pin.sym} 450 -220 0 0 {name=p11 sig_type=std_logic lab=vss}
C {lab_pin.sym} 370 -370 2 0 {name=p10 sig_type=std_logic lab=vss}
C {lab_pin.sym} 600 -370 2 0 {name=p12 sig_type=std_logic lab=vss}
C {symbols/nfet_03v3.sym} 350 -480 0 1 {name=M3
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
C {symbols/nfet_03v3.sym} 540 -480 0 0 {name=M4
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
C {symbols/pfet_03v3.sym} 350 -670 0 1 {name=M5
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
C {symbols/pfet_03v3.sym} 540 -670 0 0 {name=M6
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
C {symbols/pfet_03v3.sym} 120 -680 0 0 {name=M7
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
C {symbols/pfet_03v3.sym} 770 -680 0 1 {name=M8
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
C {lab_pin.sym} 60 -680 3 0 {name=p13 sig_type=std_logic lab=rst_latch}
C {lab_pin.sym} 820 -680 3 0 {name=p14 sig_type=std_logic lab=rst_latch}
C {symbols/pfet_03v3.sym} -40 -680 0 0 {name=M9
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
C {symbols/pfet_03v3.sym} 920 -680 0 1 {name=M10
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
C {lab_pin.sym} 260 -480 0 0 {name=p15 sig_type=std_logic lab=vss}
C {lab_pin.sym} 600 -480 2 0 {name=p16 sig_type=std_logic lab=vss}
C {lab_pin.sym} -100 -680 3 0 {name=p17 sig_type=std_logic lab=rst_latch}
C {lab_pin.sym} 970 -680 3 0 {name=p18 sig_type=std_logic lab=rst_latch}
