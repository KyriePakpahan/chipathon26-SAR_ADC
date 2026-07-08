v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -280 190 -230 190 {lab=reset}
N -330 170 -230 170 {lab=clk}
N -370 150 -230 150 {lab=en}
N -410 130 -230 130 {lab=comp_out}
C {bit_reg.sym} -80 160 0 0 {name=x1}
C {vsource.sym} -200 340 0 0 {name=V1 value=5 savecurrent=false}
C {gnd.sym} -200 370 0 0 {name=l1 lab=0}
C {vdd.sym} -200 310 0 0 {name=l2 lab=VDD}
C {vsource.sym} -410 160 0 0 {name=V2 value="PULSE(0 5 50ns 1ns 1ns 150ns 300ns)" savecurrent=false}
C {gnd.sym} -410 190 0 0 {name=l3 lab=0}
C {vsource.sym} -370 180 0 0 {name=V3 value="PULSE(5 0 100ns 1ns 1ns 300ns 2us)" savecurrent=false}
C {gnd.sym} -370 210 0 0 {name=l4 lab=0}
C {vsource.sym} -330 200 0 0 {name=V4 value="PULSE(0 5 0 1ns 1ns 50ns 100ns)" savecurrent=false}
C {gnd.sym} -330 230 0 0 {name=l5 lab=0}
C {vsource.sym} -280 220 0 0 {name=V5 value="PULSE(5 0 0 1ns 1ns 40ns 2us)" savecurrent=false}
C {gnd.sym} -280 250 0 0 {name=l6 lab=0}
C {lab_wire.sym} -380 130 0 0 {name=p1 sig_type=std_logic lab=comp_out}
C {lab_wire.sym} -350 150 0 0 {name=p2 sig_type=std_logic lab=en}
C {lab_wire.sym} -310 170 0 0 {name=p3 sig_type=std_logic lab=clk}
C {lab_wire.sym} -260 190 0 0 {name=p4 sig_type=std_logic lab=reset}
C {code_shown.sym} -260 470 0 0 {name=s1 only_toplevel=false value=".param fnoicor=0
.param sw_stat_mismatch=0
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.tran 0.1n 500n
.save all"}
