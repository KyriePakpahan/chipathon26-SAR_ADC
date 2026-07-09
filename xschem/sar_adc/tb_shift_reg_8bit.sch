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
N -150 -60 -150 70 {lab=serial_in}
N -160 -60 110 -60 {lab=serial_in}
N -100 0 -100 70 {lab=clk}
N -50 60 -50 70 {lab=rst_n}
N 110 -60 130 -60 {lab=serial_in}
N -100 -40 130 -40 {lab=clk}
N -100 -30 -100 -0 {lab=clk}
N -100 -40 -100 -30 {lab=clk}
N -50 -20 130 -20 {lab=rst_n}
N -50 -20 -50 60 {lab=rst_n}
C {vsource.sym} -200 -170 0 0 {name=V1 value=5}
C {vdd.sym} -200 -210 0 0 {name=l1 lab=VDD}
C {gnd.sym} -200 -130 0 0 {name=l2 lab=0}
C {vsource.sym} -150 100 0 0 {name=V2 value="PULSE(0 5 2n 0.1n 0.1n 4n 12n)"}
C {gnd.sym} -150 140 0 0 {name=l3 lab=0}
C {vsource.sym} -100 100 0 0 {name=V3 value="PULSE(0 5 1n 0.1n 0.1n 2.5n 5n)"}
C {gnd.sym} -100 140 0 0 {name=l4 lab=0}
C {vsource.sym} -50 100 0 0 {name=V4 value="PWL(0 0 0.5n 0 0.6n 5)"}
C {gnd.sym} -50 140 0 0 {name=l5 lab=0}
C {lab_wire.sym} -150 -60 0 0 {name=l14 lab=serial_in}
C {lab_wire.sym} -100 -40 0 0 {name=l15 lab=clk}
C {lab_wire.sym} -50 -20 0 0 {name=l20 lab=rst_n}
C {lab_wire.sym} 430 -20 2 0 {name=l17 lab=Q0}
C {lab_wire.sym} 430 -40 2 0 {name=l18 lab=Q1}
C {lab_wire.sym} 430 -60 2 0 {name=l19 lab=Q2}
C {lab_wire.sym} 430 0 2 0 {name=l21 lab=Q3}
C {lab_wire.sym} 430 20 2 0 {name=l22 lab=Q4}
C {lab_wire.sym} 430 40 2 0 {name=l23 lab=Q5}
C {lab_wire.sym} 430 60 2 0 {name=l24 lab=Q6}
C {lab_wire.sym} 430 80 2 0 {name=l25 lab=Q7}
C {res.sym} 400 150 0 0 {name=R1 value=1Meg}
C {gnd.sym} 400 180 0 0 {name=l26 lab=0}
C {lab_wire.sym} 400 120 0 0 {name=l27 lab=Q0}
C {res.sym} 460 150 0 0 {name=R2 value=1Meg}
C {gnd.sym} 460 180 0 0 {name=l28 lab=0}
C {lab_wire.sym} 460 120 0 0 {name=l29 lab=Q1}
C {res.sym} 520 150 0 0 {name=R3 value=1Meg}
C {gnd.sym} 520 180 0 0 {name=l30 lab=0}
C {lab_wire.sym} 520 120 0 0 {name=l31 lab=Q2}
C {res.sym} 580 150 0 0 {name=R4 value=1Meg}
C {gnd.sym} 580 180 0 0 {name=l32 lab=0}
C {lab_wire.sym} 580 120 0 0 {name=l33 lab=Q3}
C {res.sym} 640 150 0 0 {name=R5 value=1Meg}
C {gnd.sym} 640 180 0 0 {name=l34 lab=0}
C {lab_wire.sym} 640 120 0 0 {name=l35 lab=Q4}
C {res.sym} 700 150 0 0 {name=R6 value=1Meg}
C {gnd.sym} 700 180 0 0 {name=l36 lab=0}
C {lab_wire.sym} 700 120 0 0 {name=l37 lab=Q5}
C {res.sym} 760 150 0 0 {name=R7 value=1Meg}
C {gnd.sym} 760 180 0 0 {name=l38 lab=0}
C {lab_wire.sym} 760 120 0 0 {name=l39 lab=Q6}
C {res.sym} 820 150 0 0 {name=R8 value=1Meg}
C {gnd.sym} 820 180 0 0 {name=l40 lab=0}
C {lab_wire.sym} 820 120 0 0 {name=l41 lab=Q7}
C {code_shown.sym} 30 -240 0 0 {name=s1 value=".param fnoicor=0
.param sw_stat_mismatch=0
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.tran 0.01n 50n
.save all"}
C {xschem/sar_adc/shift_reg_8bit.sym} 280 10 0 0 {name=x1}
