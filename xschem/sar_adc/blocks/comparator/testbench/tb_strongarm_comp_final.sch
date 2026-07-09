v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 670 -280 670 -250 {lab=0}
N 670 -380 670 -360 {lab=vdd}
N 670 -450 670 -440 {lab=0}
N 670 -450 710 -450 {lab=0}
N 450 -370 450 -360 {lab=vin_p}
N 450 -360 490 -360 {lab=vin_p}
N 450 -440 450 -430 {lab=0}
N 390 -440 450 -440 {lab=0}
N 450 -320 490 -320 {lab=rst_latch}
N 450 -260 450 -250 {lab=0}
N 670 -320 730 -320 {lab=out_n}
N 670 -340 730 -340 {lab=out_p}
N 320 -340 340 -340 {lab=0}
N 400 -340 490 -340 {lab=vin_n}
N 670 -300 730 -300 {lab=comp_done}
C {title.sym} 160 -40 0 0 {name=l1 author="Berkah Saluyu"}
C {gnd.sym} 670 -250 0 0 {name=l2 lab=0}
C {vsource.sym} 670 -410 2 0 {name=vdd value=3.3 savecurrent=false}
C {gnd.sym} 710 -450 0 0 {name=l3 lab=0}
C {vsource.sym} 450 -400 2 0 {name=vin_p value="pwl(0 0.8025 7n 0.8025 7.1n 0.7975 17n 0.7975 17.1n 2.5025 27n 2.5025 27.1n 2.4975 40n 2.4975)" savecurrent=false}
C {gnd.sym} 390 -440 0 0 {name=l4 lab=0}
C {vsource.sym} 370 -340 1 0 {name=vin_n value="pwl(0 0.7975 7n 0.7975 7.1n 0.8025 17n 0.8025 17.1n 2.4975 27n 2.4975 27.1n 2.5025 40n 2.5025)" savecurrent=false}
C {gnd.sym} 320 -340 0 0 {name=l5 lab=0}
C {vsource.sym} 450 -290 0 0 {name=vrst value="pulse(0 3.3 1n 100p 100p 4n 10n)" savecurrent=false}
C {gnd.sym} 450 -250 0 0 {name=l6 lab=0}
C {lab_pin.sym} 730 -340 2 0 {name=p1 sig_type=std_logic lab=out_p}
C {lab_pin.sym} 730 -320 2 0 {name=p2 sig_type=std_logic lab=out_n}
C {code_shown.sym} 110 -200 0 0 {name=s1 only_toplevel=true
value=".include /foss/pdks/ciel/gf180mcu/versions/7b70722e33c03fcb5dabcf4d479fb0822d9251c9/gf180mcuD/libs.tech/ngspice/design.ngspice
.lib /foss/pdks/ciel/gf180mcu/versions/7b70722e33c03fcb5dabcf4d479fb0822d9251c9/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.control
save v(vin_p) v(vin_n) v(rst_latch) v(out_p) v(out_n) v(comp_done)

tran 1p 40n

plot v(vin_p) v(vin_n) v(rst_latch) v(out_p) v(out_n) v(comp_done)

write tb_strongarm_comp_final.raw
.endc"}
C {lab_pin.sym} 670 -370 2 0 {name=p3 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 480 -360 1 0 {name=p4 sig_type=std_logic lab=vin_p}
C {lab_pin.sym} 410 -340 3 0 {name=p5 sig_type=std_logic lab=vin_n}
C {lab_pin.sym} 480 -320 3 0 {name=p6 sig_type=std_logic lab=rst_latch}
C {sar_adc/blocks/comparator/strongarm_comp.sym} 510 -270 0 0 {name=x1}
C {lab_pin.sym} 730 -300 2 0 {name=p7 sig_type=std_logic lab=comp_done}
