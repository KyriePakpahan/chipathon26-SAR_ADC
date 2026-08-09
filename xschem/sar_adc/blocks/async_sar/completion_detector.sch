v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -200 -10 -150 -10 {lab=out_n}
N -200 10 -150 10 {lab=out_p}
N 150 -10 200 -10 {lab=done}
C {ipin.sym} -200 -10 0 0 {name=p1 lab=out_n}
C {ipin.sym} -200 10 0 0 {name=p2 lab=out_p}
C {opin.sym} 200 -10 0 0 {name=p3 lab=done}
C {sar_adc/blocks/async_sar/async_nand2.sym} 0 0 0 0 {name=x1}
C {lab_wire.sym} -150 -10 0 0 {name=l1 lab=out_n}
C {lab_wire.sym} -150 10 0 0 {name=l2 lab=out_p}
C {lab_wire.sym} 150 -10 2 0 {name=l3 lab=done}
