v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 40 -480 40 -440 {lab=vref}
N 40 -480 160 -480 {lab=vref}
N 500 -480 500 -440 {lab=vdd}
N 290 -480 500 -480 {lab=vdd}
N 110 -450 160 -450 {lab=dac_in[7:0]}
N 290 -460 420 -460 {lab=vdac}
N 420 -460 420 -410 {lab=vdac}
N 690 -380 730 -380 {lab=dac_in[6]}
N 690 -350 730 -350 {lab=dac_in[5]}
N 690 -200 730 -200 {lab=dac_in[0]}
N 690 -230 730 -230 {lab=dac_in[1]}
N 690 -260 730 -260 {lab=dac_in[2]}
N 690 -290 730 -290 {lab=dac_in[3]}
N 690 -320 730 -320 {lab=dac_in[4]}
C {title.sym} 160 -30 0 0 {name=l1 author="Berkah Saluyu"}
C {vsource.sym} 40 -410 0 0 {name=V1 value=3.3 savecurrent=false}
C {vsource.sym} 500 -410 0 0 {name=V2 value=3.3 savecurrent=false}
C {gnd.sym} 40 -380 0 0 {name=l2 lab=0}
C {gnd.sym} 500 -380 0 0 {name=l3 lab=0}
C {lab_pin.sym} 500 -480 1 0 {name=p1 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 40 -480 1 0 {name=p2 sig_type=std_logic lab=vref}
C {gnd.sym} 290 -440 0 0 {name=l4 lab=0}
C {res.sym} 420 -380 0 0 {name=R1
value=1G
footprint=1206
device=resistor
m=1}
C {gnd.sym} 420 -350 0 0 {name=l5 lab=0}
C {lab_pin.sym} 110 -450 3 0 {name=p3 sig_type=std_logic lab=dac_in[7:0]}
C {lab_pin.sym} 240 -250 1 0 {name=p4 sig_type=std_logic lab=dac_in[7]}
C {vsource.sym} 240 -220 0 0 {name=V3 value="PULSE(0 3.3 0 1n 1n 2u 4u)" savecurrent=false}
C {gnd.sym} 240 -190 0 0 {name=l6 lab=0}
C {lab_pin.sym} 690 -380 0 0 {name=p5 sig_type=std_logic lab=dac_in[6]}
C {lab_pin.sym} 690 -350 0 0 {name=p6 sig_type=std_logic lab=dac_in[5]}
C {lab_pin.sym} 690 -320 0 0 {name=p7 sig_type=std_logic lab=dac_in[4]}
C {lab_pin.sym} 690 -290 0 0 {name=p8 sig_type=std_logic lab=dac_in[3]}
C {lab_pin.sym} 690 -260 0 0 {name=p9 sig_type=std_logic lab=dac_in[2]}
C {lab_pin.sym} 690 -230 0 0 {name=p10 sig_type=std_logic lab=dac_in[1]}
C {lab_pin.sym} 690 -200 0 0 {name=p11 sig_type=std_logic lab=dac_in[0]}
C {code_shown.sym} 10 -150 0 0 {name=MODELS
only_toplevel=true
value="
.include /foss/pdks/gf180mcuD/libs.tech/ngspice/design.ngspice
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
"}
C {code_shown.sym} 10 -680 0 0 {name=SIMULATION
only_toplevel=true
value="
.control
  tran 10n 10u
  plot vdac
  plot x1.bot7 x1.bot6
.endc
"}
C {vsource.sym} 760 -380 3 0 {name=V4 value=0 savecurrent=false}
C {gnd.sym} 790 -380 3 0 {name=l7 lab=0}
C {vsource.sym} 760 -350 3 0 {name=V5 value=0 savecurrent=false}
C {gnd.sym} 790 -350 3 0 {name=l8 lab=0}
C {vsource.sym} 760 -320 3 0 {name=V6 value=0 savecurrent=false}
C {gnd.sym} 790 -320 3 0 {name=l9 lab=0}
C {vsource.sym} 760 -290 3 0 {name=V7 value=0 savecurrent=false}
C {gnd.sym} 790 -290 3 0 {name=l10 lab=0}
C {vsource.sym} 760 -260 3 0 {name=V8 value=0 savecurrent=false}
C {gnd.sym} 790 -260 3 0 {name=l11 lab=0}
C {vsource.sym} 760 -230 3 0 {name=V9 value=0 savecurrent=false}
C {gnd.sym} 790 -230 3 0 {name=l12 lab=0}
C {vsource.sym} 760 -200 3 0 {name=V10 value=0 savecurrent=false}
C {gnd.sym} 790 -200 3 0 {name=l13 lab=0}
C {lab_pin.sym} 420 -460 2 0 {name=p12 sig_type=std_logic lab=vdac}
C {cdac_8bit.sym} 180 -430 0 0 {name=x1}
