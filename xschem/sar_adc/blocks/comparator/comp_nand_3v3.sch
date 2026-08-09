v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -200 10 -150 10 {lab=b}
N -200 -10 -150 -10 {lab=a}
N 150 -10 200 -10 {lab=y}
C {iopin.sym} -200 -100 0 0 {name=p1 lab=vdd}
C {ipin.sym} -200 10 0 0 {name=p3 lab=b}
C {ipin.sym} -200 -10 0 0 {name=p2 lab=a}
C {opin.sym} 200 -10 0 0 {name=p4 lab=y}
C {iopin.sym} -200 100 0 0 {name=p5 lab=vss}

C {sar_adc/blocks/async_sar/async_nand2.sym} 0 0 0 0 {name=x1}
C {lab_wire.sym} -150 10 0 0 {name=l1 lab=b}
C {lab_wire.sym} -150 -10 0 0 {name=l2 lab=a}
C {lab_wire.sym} 150 -10 2 0 {name=l3 lab=y}
