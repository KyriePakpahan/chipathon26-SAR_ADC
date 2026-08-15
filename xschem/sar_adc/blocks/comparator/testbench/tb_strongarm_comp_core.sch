v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 360 -570 360 -500 {lab=vin_n}
N 360 -570 480 -570 {lab=vin_n}
N 430 -550 430 -430 {lab=rst_latch}
N 430 -550 480 -550 {lab=rst_latch}
N 320 -500 320 -470 {lab=0}
N 360 -440 360 -410 {lab=0}
N 430 -370 430 -340 {lab=0}
N 780 -590 820 -590 {lab=vdd}
N 820 -630 820 -590 {lab=vdd}
N 780 -570 820 -570 {lab=out_n}
N 780 -550 820 -550 {lab=out_p}
N 820 -710 820 -690 {lab=0}
N 320 -590 480 -590 {lab=vin_p}
N 320 -590 320 -560 {lab=vin_p}
N 780 -530 820 -530 {lab=0}
N 820 -530 820 -500 {lab=0}
C {title.sym} 160 -100 0 0 {name=l1 author="Berkah Saluyu"}
C {sar_adc/blocks/comparator/strongarm_comp_core.sym} 630 -560 0 0 {name=x1}
C {vsource.sym} 320 -530 0 0 {name=V1 value="pwl(0 0.8025 7n 0.8025 7.1n 0.7975 17n 0.7975 17.1n 1.6525 27n 1.6525 27.1n 1.6475 37n 1.6475 37.1n 2.5025 40n 2.5025)" savecurrent=false}
C {vsource.sym} 360 -470 0 0 {name=V2 value="pwl(0 0.7975 7n 0.7975 7.1n 0.8025 17n 0.8025 17.1n 1.6475 27n 1.6475 27.1n 1.6525 37n 1.6525 37.1n 2.4975 40n 2.4975)" savecurrent=false}
C {vsource.sym} 430 -400 0 0 {name=V3 value="pulse(0 3.3 1n 100p 100p 4n 10n)" savecurrent=false}
C {gnd.sym} 430 -340 0 0 {name=l2 lab=0}
C {gnd.sym} 360 -410 0 0 {name=l3 lab=0}
C {gnd.sym} 320 -470 0 0 {name=l4 lab=0}
C {vsource.sym} 820 -660 2 0 {name=V5 value=3.3 savecurrent=false}
C {gnd.sym} 820 -710 2 0 {name=l6 lab=0}
C {gnd.sym} 820 -500 0 0 {name=l5 lab=0}
C {lab_pin.sym} 820 -550 2 0 {name=p2 sig_type=std_logic lab=out_p
}
C {lab_pin.sym} 820 -570 2 0 {name=p1 sig_type=std_logic lab=out_n}
C {lab_pin.sym} 320 -590 0 0 {name=p3 sig_type=std_logic lab=vin_p}
C {lab_pin.sym} 390 -570 0 0 {name=p4 sig_type=std_logic lab=vin_n}
C {lab_pin.sym} 430 -550 0 0 {name=p5 sig_type=std_logic lab=rst_latch
}
C {lab_pin.sym} 820 -590 2 0 {name=p6 sig_type=std_logic lab=vdd}
C {code_shown.sym} 210 -310 0 0 {name=s1 only_toplevel=true value=".include /foss/pdks/ciel/gf180mcu/versions/7b70722e33c03fcb5dabcf4d479fb0822d9251c9/gf180mcuD/libs.tech/ngspice/design.ngspice
.lib /foss/pdks/ciel/gf180mcu/versions/7b70722e33c03fcb5dabcf4d479fb0822d9251c9/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.control
save v(vin_p) v(vin_n) v(rst_latch) v(out_p) v(out_n)
tran 10p 60n
plot vin_p vin_n rst_latch out_p out_n
.endc"}
