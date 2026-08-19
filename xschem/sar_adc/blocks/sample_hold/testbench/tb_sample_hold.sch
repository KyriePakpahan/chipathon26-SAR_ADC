v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
C {vsource.sym} -400 -200 0 0 {name=V_VDD value=3.3}
C {lab_wire.sym} -400 -230 0 0 {name=l_vdd lab=vdd}
C {lab_wire.sym} -400 -170 0 0 {name=l_gnd1 lab=0}
C {vsource.sym} -400 -80 0 0 {name=V_VIN value="SINE(1.65 1.5 1Meg)"}
C {lab_wire.sym} -400 -110 0 0 {name=l_vin lab=vin}
C {lab_wire.sym} -400 -50 0 0 {name=l_gnd2 lab=0}
C {vsource.sym} -400 40 0 0 {name=V_SE value="PULSE(0 3.3 0 1n 1n 50n 100n)"}
C {lab_wire.sym} -400 10 0 0 {name=l_se lab=sample_en}
C {lab_wire.sym} -400 70 0 0 {name=l_gnd3 lab=0}
C {sar_adc/blocks/sample_hold/sample_hold.sym} 0 0 0 0 {name=x1}
C {lab_wire.sym} -20 -50 0 0 {name=l_sh_vin lab=vin}
C {lab_wire.sym} -20 -20 0 0 {name=l_sh_se lab=sample_en}
C {lab_wire.sym} 100 -50 2 0 {name=l_sh_vd lab=vdd}
C {lab_wire.sym} 100 -30 2 0 {name=l_sh_vh lab=vhold}
C {lab_wire.sym} 100 -10 2 0 {name=l_sh_vs lab=0}
C {code_shown.sym} 250 -150 0 0 {name=MODELS value="
.param fnoicor=0
.param sw_stat_mismatch=0
.include /foss/pdks/gf180mcuD/libs.tech/ngspice/design.ngspice
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice mimcap_typical
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice cap_mim
.control
save v(vin) v(sample_en) v(vhold)
tran 0.1n 500n
set filetype=ascii
write tb_sample_hold.raw
quit
.endc"}
C {title.sym} 0 250 0 0 {name=l_title author="Berkah Saluyu"}
