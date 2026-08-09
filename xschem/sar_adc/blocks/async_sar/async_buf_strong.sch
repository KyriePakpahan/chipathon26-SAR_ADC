v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -250 30 -200 30 {lab=in}
N 400 30 450 30 {lab=out}
C {ipin.sym} -250 30 0 0 {name=p1 lab=in}
C {opin.sym} 450 30 0 0 {name=p2 lab=out}
C {sar_adc/blocks/async_sar/async_inverter.sym} -50 30 0 0 {name=x1}
C {lab_wire.sym} -200 30 0 0 {name=l1 lab=in}
C {lab_wire.sym} 100 30 2 0 {name=l2 lab=in_b}
C {sar_adc/blocks/async_sar/async_inverter.sym} 250 30 0 0 {name=x2}
C {lab_wire.sym} 400 30 2 0 {name=l4 lab=out}
