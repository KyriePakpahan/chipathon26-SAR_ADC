v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -100 -170 -100 -160 {lab=VDD}
N -100 -100 -100 -90 {lab=0}
N -150 130 -150 140 {lab=0}
N -100 130 -100 140 {lab=0}
N -50 130 -50 140 {lab=0}
N 400 60 400 70 {lab=0}
N -150 -20 -150 70 {lab=D}
N -150 -20 50 -20 {lab=D}
N -100 0 -100 70 {lab=clk}
N -100 0 50 0 {lab=clk}
N -50 20 -50 70 {lab=rst_n}
N -50 20 50 20 {lab=rst_n}
N 350 -20 400 -20 {lab=Q}
N 400 -20 400 0 {lab=Q}
N -100 -90 -100 -80 {lab=0}
C {vsource.sym} -100 -130 0 0 {name=V1 value=5}
C {vdd.sym} -100 -170 0 0 {name=l1 lab=VDD}
C {gnd.sym} -100 -80 0 0 {name=l2 lab=0}
C {vsource.sym} -150 100 0 0 {name=V2 value="PULSE(0 5 2n 0.1n 0.1n 4n 10n)"}
C {gnd.sym} -150 140 0 0 {name=l3 lab=0}
C {vsource.sym} -100 100 0 0 {name=V3 value="PULSE(0 5 1n 0.1n 0.1n 2n 4n)"}
C {gnd.sym} -100 140 0 0 {name=l4 lab=0}
C {vsource.sym} -50 100 0 0 {name=V4 value="PWL(0 0 0.5n 0 0.6n 5 8n 5 8.1n 0 8.6n 0 8.7n 5)"}
C {gnd.sym} -50 140 0 0 {name=l5 lab=0}
C {res.sym} 400 30 0 0 {name=R1 value=1Meg}
C {gnd.sym} 400 70 0 0 {name=l6 lab=0}
C {lab_wire.sym} -150 -20 0 0 {name=l7 lab=D}
C {lab_wire.sym} -100 0 0 0 {name=l8 lab=clk}
C {lab_wire.sym} -50 20 0 0 {name=l9 lab=rst_n}
C {lab_wire.sym} 400 -20 0 0 {name=l10 lab=Q}
C {code_shown.sym} 100 -180 0 0 {name=s1 value=".param fnoicor=0
.param sw_stat_mismatch=0
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.tran 0.01n 12n
.save all"}
C {sar_adc/blocks/async_sar/dff_cell.sym} 200 0 0 0 {name=x1}
