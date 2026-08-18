v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 150 -30 180 -30 {lab=vref}
N 150 -10 180 -10 {lab=vdd}
N 150 10 180 10 {lab=0}
N -180 -30 -150 -30 {lab=bit}
N -250 -200 -250 -190 {lab=vdd}
N -250 -130 -250 -120 {lab=0}
N -170 -200 -170 -190 {lab=vref}
N -170 -130 -170 -120 {lab=0}
N -90 -200 -90 -190 {lab=bit}
N -90 -130 -90 -120 {lab=0}
N 220 30 220 50 {lab=#net1}
N 220 110 220 130 {lab=0}
N 150 30 160 30 {lab=bot}
N 160 30 160 40 {lab=bot}
C {title.sym} 160 200 0 0 {name=l1 author="Berkah Saluyu"}
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} 0 0 0 0 {name=x1}
C {vsource.sym} -250 -160 0 0 {name=Vvdd value=3.3}
C {lab_wire.sym} -250 -200 0 0 {name=l_vdd1 lab=VDD}
C {lab_wire.sym} -250 -120 0 0 {name=l_gnd1 lab=VSS}
C {vsource.sym} -170 -160 0 0 {name=Vref value=3.3}
C {lab_wire.sym} -170 -200 0 0 {name=l_vr1 lab=vref}
C {lab_wire.sym} -170 -120 0 0 {name=l_gnd2 lab=VSS}
C {vsource.sym} -90 -160 0 0 {name=Vbit value="pulse(0 3.3 1n 0.1n 0.1n 5n 10n)"}
C {lab_wire.sym} -90 -200 0 0 {name=l_b1 lab=bit}
C {lab_wire.sym} -90 -120 0 0 {name=l_gnd3 lab=VSS}
C {lab_wire.sym} -180 -30 0 0 {name=l_b2 lab=bit}
C {lab_wire.sym} 180 -30 2 0 {name=l_vr2 lab=vref}
C {lab_wire.sym} 180 -10 0 0 {name=l_vdd2 lab=VDD}
C {lab_wire.sym} 180 10 0 0 {name=l_gnd4 lab=VSS}
C {lab_wire.sym} 180 30 2 0 {name=l_bot lab=bot}
C {capa.sym} 220 80 0 0 {name=Cload m=1 value=0.01p}
C {lab_wire.sym} 220 130 0 0 {name=l_gnd5 lab=VSS}
C {code_shown.sym} 110 -150 0 0 {name=s1 only_toplevel=true
value=".include /foss/pdks/ciel/gf180mcu/versions/7b70722e33c03fcb5dabcf4d479fb0822d9251c9/gf180mcuD/libs.tech/ngspice/design.ngspice
.lib /foss/pdks/ciel/gf180mcu/versions/7b70722e33c03fcb5dabcf4d479fb0822d9251c9/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.control
save v(bit) v(bot)
tran 10p 30n
.endc"}
