v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -100 -70 -100 -60 {lab=VDD}
N -100 0 -100 10 {lab=0}
N -50 90 -50 100 {lab=0}
N 400 70 400 80 {lab=0}
N -50 0 -50 30 {lab=IN}
N -50 0 50 0 {lab=IN}
N 350 0 400 0 {lab=OUT}
N 400 0 400 10 {lab=OUT}
N 400 0 470 0 {lab=OUT}
N 470 -0 470 30 {lab=OUT}
C {vsource.sym} -100 -30 0 0 {name=V1 value=5}
C {vdd.sym} -100 -70 0 0 {name=l1 lab=VDD}
C {gnd.sym} -100 10 0 0 {name=l2 lab=0}
C {vsource.sym} -50 60 0 0 {name=V2 value="PULSE(0 5 1n 0.1n 0.1n 3n 6n)"}
C {gnd.sym} -50 100 0 0 {name=l3 lab=0}
C {res.sym} 400 40 0 0 {name=R1 value=1Meg}
C {gnd.sym} 400 80 0 0 {name=l4 lab=0}
C {lab_wire.sym} 30 0 0 0 {name=l5 lab=IN}
C {lab_wire.sym} 370 0 0 0 {name=l6 lab=OUT}
C {code_shown.sym} 100 -180 0 0 {name=s1 value=".param fnoicor=0
.param sw_stat_mismatch=0
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.tran 0.01n 10n
.save all"}
C {sar_adc/blocks/async_sar/delay_line.sym} 200 0 0 0 {name=x1}
C {parax_cap.sym} 470 40 0 0 {name=C1 gnd=0 value=10f m=1}
