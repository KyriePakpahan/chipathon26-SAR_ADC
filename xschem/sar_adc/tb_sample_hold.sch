v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 480 -360 480 -300 {lab=vhold}
N 460 -300 480 -300 {lab=vhold}
N 90 -380 260 -380 {lab=vin}
N 90 -380 90 -370 {lab=vin}
N 250 -350 260 -350 {lab=sample_en}
N 250 -350 250 -200 {lab=sample_en}
N 550 -380 550 -340 {lab=vdd}
N 380 -380 550 -380 {lab=vdd}
N 380 -360 480 -360 {lab=vhold}
N 380 -340 400 -340 {lab=0}
N 400 -340 400 -320 {lab=0}
C {vsource.sym} 550 -310 0 0 {name=V1 value=3.3 savecurrent=false}
C {gnd.sym} 550 -280 0 0 {name=l1 lab=0}
C {gnd.sym} 400 -320 0 0 {name=l2 lab=0}
C {vsource.sym} 90 -340 0 0 {name=V2 value="SINE(1.65 1.65 1Meg)" savecurrent=false}
C {gnd.sym} 90 -310 0 0 {name=l3 lab=0}
C {vsource.sym} 250 -170 0 0 {name=V3 value="PULSE(0 3.3 0 1n 1n 50n 100n)" savecurrent=false}
C {gnd.sym} 250 -140 0 0 {name=l4 lab=0}
C {capa.sym} 460 -270 0 0 {name=C1
m=1
value=100f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 460 -240 0 0 {name=l5 lab=0}
C {sample_hold.sym} 220 -260 0 0 {name=x1}
C {code_shown.sym} 0 -70 0 0 {name=MODELS
only_toplevel=true
value="
.include /foss/pdks/gf180mcuD/libs.tech/ngspice/design.ngspice
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
"}
C {code_shown.sym} 0 -590 0 0 {name=SIMULATION
only_toplevel=true
value="
.control
  save all
  tran 1n 500n
  plot v(vin) v(vhold) v(sample_en)
.endc
"}
C {lab_pin.sym} 190 -380 1 0 {name=p1 sig_type=std_logic lab=vin}
C {lab_pin.sym} 250 -280 2 0 {name=p2 sig_type=std_logic lab=sample_en}
C {lab_pin.sym} 490 -380 1 0 {name=p3 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 480 -330 2 0 {name=p4 sig_type=std_logic lab=vhold}
