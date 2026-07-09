v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
C {completion_detector.sym} 200 0 0 0 {name=x1}
C {vsource.sym} -100 -30 0 0 {name=V1 value=5}
C {vdd.sym} -100 -70 0 0 {name=l1 lab=VDD}
C {gnd.sym} -100 10 0 0 {name=l2 lab=0}
C {vsource.sym} -50 60 0 0 {name=V2 value="PULSE(0 5 10n 1n 1n 20n 60n)"}
C {gnd.sym} -50 100 0 0 {name=l3 lab=0}
C {vsource.sym} 0 60 0 0 {name=V3 value="PULSE(0 5 30n 1n 1n 20n 60n)"}
C {gnd.sym} 0 100 0 0 {name=l4 lab=0}
C {res.sym} 400 40 0 0 {name=R1 value=1Meg}
C {gnd.sym} 400 80 0 0 {name=l5 lab=0}
C {lab_wire.sym} 380 -10 0 0 {name=l6 lab=done}
C {code_shown.sym} 100 -180 0 0 {name=s1 value=".param fnoicor=0
.param sw_stat_mismatch=0
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.tran 0.05n 120n
.save all"}
N -100 -60 -100 -70 {}
N -100 0 -100 10 {}
N -50 90 -50 100 {}
N 0 90 0 100 {}
N 400 70 400 80 {}
N -50 -20 -50 30 {}
N -50 -20 50 -20 {}
N 0 10 0 30 {}
N 0 10 50 10 {}
N 350 -10 400 -10 {}
N 400 -10 400 10 {}
