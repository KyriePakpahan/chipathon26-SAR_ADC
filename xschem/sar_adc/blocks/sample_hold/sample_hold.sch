v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -550 -40 -550 40 {lab=sample_en}
N -510 -10 -510 10 {lab=clkb}
N -510 -70 -510 -40 {lab=vdd}
N -510 40 -510 70 {lab=vss}
C {ipin.sym} -800 -80 0 0 {name=p_vin lab=vin}
C {ipin.sym} -800 -40 0 0 {name=p_se lab=sample_en}
C {opin.sym} -800 0 0 0 {name=p_vh lab=vhold}
C {iopin.sym} -800 40 0 0 {name=p_vdd lab=vdd}
C {iopin.sym} -800 80 0 0 {name=p_vss lab=vss}
C {lab_wire.sym} -550 0 0 0 {name=l_inv_vi lab=sample_en}
C {lab_wire.sym} -510 -70 2 0 {name=l_inv_vd lab=vdd}
C {lab_wire.sym} -510 0 2 0 {name=l_inv_vo lab=clkb}
C {lab_wire.sym} -510 70 2 0 {name=l_inv_vs lab=vss}
C {symbols/nfet_03v3.sym} 0 -100 0 0 {name=M1 L=0.28u W=4.00u nf=2 m=1 model=nfet_03v3 spiceprefix=X}
C {lab_wire.sym} -20 -100 0 0 {name=l_m1_g lab=sample_en}
C {lab_wire.sym} 20 -130 2 0 {name=l_m1_d lab=vhold}
C {lab_wire.sym} 20 -100 2 0 {name=l_m1_b lab=vss}
C {lab_wire.sym} 20 -70 0 0 {name=l_m1_s lab=vin}
C {symbols/pfet_03v3.sym} 0 -250 0 0 {name=M2 L=0.28u W=8.00u nf=2 m=1 model=pfet_03v3 spiceprefix=X}
C {lab_wire.sym} -20 -250 0 0 {name=l_m2_g lab=clkb}
C {lab_wire.sym} 20 -280 0 0 {name=l_m2_s lab=vhold}
C {lab_wire.sym} 20 -250 2 0 {name=l_m2_b lab=vdd}
C {lab_wire.sym} 20 -220 2 0 {name=l_m2_d lab=vin}
C {symbols/cap_mim_2f0fF.sym} 250 100 0 0 {name=C2 W=15e-6 L=10e-6 model=cap_mim_2f0fF spiceprefix=X m=1}
C {lab_wire.sym} 250 70 2 0 {name=l_c2_top lab=vhold}
C {lab_wire.sym} 250 130 0 0 {name=l_c2_bot lab=vss}
C {title.sym} -430 400 0 0 {name=l_title author="Berkah Saluyu"}
C {symbols/pfet_03v3.sym} -530 -40 0 0 {name=M3
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
C {symbols/nfet_03v3.sym} -530 40 0 0 {name=M4
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
