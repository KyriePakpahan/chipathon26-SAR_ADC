v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -200 -10 -150 -10 {lab=a}
N -200 10 -150 10 {lab=b}
N 150 -10 200 -10 {lab=y}
N -200 -100 -150 -100 {lab=vdd}
N -200 100 -150 100 {lab=vss}
C {title.sym} 160 120 0 0 {name=l1 author="Berkah Saluyu"}
C {iopin.sym} -200 -100 0 0 {name=p1 lab=vdd}
C {ipin.sym} -200 -10 0 0 {name=p2 lab=a}
C {ipin.sym} -200 10 0 0 {name=p3 lab=b}
C {opin.sym} 200 -10 0 0 {name=p4 lab=y}
C {iopin.sym} -200 100 0 0 {name=p5 lab=vss}
C {sar_adc/blocks/async_sar/async_nand2.sym} 0 0 0 0 {name=x1}
C {lab_wire.sym} -150 -10 0 0 {name=l_a lab=a}
C {lab_wire.sym} -150 10 0 0 {name=l_b lab=b}
C {lab_wire.sym} 150 -10 2 0 {name=l_y lab=y}
C {lab_wire.sym} -150 -100 2 0 {name=l_vdd lab=vdd}
C {lab_wire.sym} -150 100 2 0 {name=l_vss lab=vss}
