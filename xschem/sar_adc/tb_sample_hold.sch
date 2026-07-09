v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 490 -440 490 -380 {lab=vhold}
N 470 -380 490 -380 {lab=vhold}
N 100 -460 270 -460 {lab=vin}
N 100 -460 100 -450 {lab=vin}
N 260 -430 270 -430 {lab=sample_en}
N 260 -430 260 -280 {lab=sample_en}
N 560 -460 560 -420 {lab=vdd}
N 390 -460 560 -460 {lab=vdd}
N 390 -440 490 -440 {lab=vhold}
N 390 -420 410 -420 {lab=0}
N 410 -420 410 -400 {lab=0}
C {vsource.sym} 560 -390 0 0 {name=V1 value=3.3 savecurrent=false}
C {gnd.sym} 560 -360 0 0 {name=l1 lab=0}
C {gnd.sym} 410 -400 0 0 {name=l2 lab=0}
C {vsource.sym} 100 -420 0 0 {name=V2 value="SINE(1.65 1.65 1Meg)" savecurrent=false}
C {gnd.sym} 100 -390 0 0 {name=l3 lab=0}
C {vsource.sym} 260 -250 0 0 {name=V3 value="PULSE(0 3.3 0 1n 1n 50n 100n)" savecurrent=false}
C {gnd.sym} 260 -220 0 0 {name=l4 lab=0}
C {capa.sym} 470 -350 0 0 {name=C1
m=1
value=100f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 470 -320 0 0 {name=l5 lab=0}
C {sample_hold.sym} 230 -340 0 0 {name=x1}
C {code_shown.sym} 10 -150 0 0 {name=MODELS
only_toplevel=true
value="
.include /foss/pdks/gf180mcuD/libs.tech/ngspice/design.ngspice
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
"}
C {code_shown.sym} 10 -670 0 0 {name=SIMULATION
only_toplevel=true
value="
.control
  save all
  tran 1n 500n
  plot v(vin) v(vhold) v(sample_en)
.endc
"}
C {lab_pin.sym} 200 -460 1 0 {name=p1 sig_type=std_logic lab=vin}
C {lab_pin.sym} 260 -360 2 0 {name=p2 sig_type=std_logic lab=sample_en}
C {lab_pin.sym} 500 -460 1 0 {name=p3 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 490 -410 2 0 {name=p4 sig_type=std_logic lab=vhold}
C {title.sym} 160 -40 0 0 {name=l6 author="Berkah Saluyu"}
