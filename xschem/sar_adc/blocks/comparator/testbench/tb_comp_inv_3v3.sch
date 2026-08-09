v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 40 -90 40 -80 {lab=VDD}
N 40 0 40 10 {lab=0}
N -30 -40 0 -40 {lab=vin}
N 100 -40 130 -40 {lab=vout}
N -150 -10 -150 0 {lab=VDD}
N -150 60 -150 70 {lab=0}
N -90 60 -90 70 {lab=0}
N -90 0 -90 10 {lab=vin}
C {sar_adc/blocks/comparator/comp_inv_3v3.sym} 0 -90 0 0 {name=x1}
C {vsource.sym} -150 30 0 0 {name=V1 value=3.3}
C {vdd.sym} -150 -10 0 0 {name=l1 lab=VDD}
C {gnd.sym} -150 70 0 0 {name=l2 lab=0}
C {vsource.sym} -90 30 0 0 {name=V2 value="PULSE(0 3.3 1n 0.1n 0.1n 5n 10n)"}
C {gnd.sym} -90 70 0 0 {name=l3 lab=0}
C {lab_wire.sym} -90 10 0 0 {name=l4 lab=vin}
C {lab_wire.sym} -30 -40 0 0 {name=l5 lab=vin}
C {lab_wire.sym} 130 -40 0 0 {name=l6 lab=vout}
C {vdd.sym} 40 -90 0 0 {name=l_vdd lab=VDD}
C {gnd.sym} 40 10 0 0 {name=l_gnd lab=0}
C {title.sym} 160 120 0 0 {name=l_title author="Berkah Saluyu"}
C {code_shown.sym} 170 10 0 0 {name=s1 value=".include /foss/pdks/ciel/gf180mcu/versions/7b70722e33c03fcb5dabcf4d479fb0822d9251c9/gf180mcuD/libs.tech/ngspice/design.ngspice
.lib /foss/pdks/ciel/gf180mcu/versions/7b70722e33c03fcb5dabcf4d479fb0822d9251c9/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.control
save v(vin) v(vout)
tran 10p 30n
.endc"}
