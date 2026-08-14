v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -200 -210 -200 -200 {lab=VDD}
N -200 -140 -200 -130 {lab=0}
N -150 130 -150 140 {lab=0}
N -100 130 -100 140 {lab=0}
N -50 130 -50 140 {lab=0}
N -150 -70 -150 70 {lab=serial_in}
N -150 -70 130 -70 {lab=serial_in}
N -100 -50 -100 70 {lab=clk}
N -100 -50 130 -50 {lab=clk}
N -50 -30 -50 70 {lab=rst_n}
N -50 -30 130 -30 {lab=rst_n}
N 430 -70 450 -70 {lab=Q0}
N 430 -50 450 -50 {lab=Q1}
N 430 -30 450 -30 {lab=Q2}
N 430 -10 450 -10 {lab=Q3}
N 430 10 450 10 {lab=Q4}
N 430 30 450 30 {lab=Q5}
N 430 50 450 50 {lab=Q6}
N 430 70 450 70 {lab=Q7}
N 430 90 450 90 {lab=done}
C {vsource.sym} -200 -170 0 0 {name=V1 value=3.3}
C {lab_wire.sym} -200 -210 0 0 {name=l1 lab=VDD}
C {lab_wire.sym} -200 -130 0 0 {name=l2 lab=VSS}
C {vsource.sym} -150 100 0 0 {name=V2 value="PULSE(0 3.3 2n 0.1n 0.1n 4n 12n)"}
C {lab_wire.sym} -150 140 0 0 {name=l3 lab=VSS}
C {vsource.sym} -100 100 0 0 {name=V3 value="PULSE(0 3.3 1n 0.1n 0.1n 2.5n 5n)"}
C {lab_wire.sym} -100 140 0 0 {name=l4 lab=VSS}
C {vsource.sym} -50 100 0 0 {name=V4 value="PWL(0 0 0.5n 0 0.6n 3.3)"}
C {lab_wire.sym} -50 140 0 0 {name=l5 lab=VSS}
C {lab_wire.sym} 450 -70 0 0 {name=l17 lab=Q0}
C {lab_wire.sym} 450 -50 0 0 {name=l18 lab=Q1}
C {lab_wire.sym} 450 -30 0 0 {name=l19 lab=Q2}
C {lab_wire.sym} 450 -10 0 0 {name=l21 lab=Q3}
C {lab_wire.sym} 450 10 0 0 {name=l22 lab=Q4}
C {lab_wire.sym} 450 30 0 0 {name=l23 lab=Q5}
C {lab_wire.sym} 450 50 0 0 {name=l24 lab=Q6}
C {lab_wire.sym} 450 70 0 0 {name=l25 lab=Q7}
C {lab_wire.sym} 450 90 0 0 {name=l26 lab=done}
C {sar_adc/blocks/async_sar/shift_reg_8bit.sym} 280 10 0 0 {name=x1}
C {code_shown.sym} 30 -240 0 0 {name=s1 value=".param fnoicor=0
.param sw_stat_mismatch=0
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.tran 0.01n 50n
.save all"}
