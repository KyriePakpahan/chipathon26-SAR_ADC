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
C {vsource.sym} -400 -80 0 0 {name=V_VP value="pwl(0 0.8025 7n 0.8025 7.1n 0.7975 17n 0.7975 17.1n 1.6525 27n 1.6525 27.1n 1.6475 37n 1.6475 37.1n 2.5025 40n 2.5025)"}
C {lab_wire.sym} -400 -110 0 0 {name=l_vp lab=vin_p}
C {lab_wire.sym} -400 -50 0 0 {name=l_gnd2 lab=0}
C {vsource.sym} -400 40 0 0 {name=V_VN value="pwl(0 0.7975 7n 0.7975 7.1n 0.8025 17n 0.8025 17.1n 1.6475 27n 1.6475 27.1n 1.6525 37n 1.6525 37.1n 2.4975 40n 2.4975)"}
C {lab_wire.sym} -400 10 0 0 {name=l_vn lab=vin_n}
C {lab_wire.sym} -400 70 0 0 {name=l_gnd3 lab=0}
C {vsource.sym} -400 160 0 0 {name=V_RST value="pulse(0 3.3 1n 100p 100p 4n 10n)"}
C {lab_wire.sym} -400 130 0 0 {name=l_rst lab=rst_latch}
C {lab_wire.sym} -400 190 0 0 {name=l_gnd4 lab=0}
C {sar_adc/blocks/comparator/strongarm_comp_core.sym} 0 0 0 0 {name=x1}
C {lab_wire.sym} -150 -30 0 0 {name=l_c_vp lab=vin_p}
C {lab_wire.sym} -150 -10 0 0 {name=l_c_vn lab=vin_n}
C {lab_wire.sym} -150 10 0 0 {name=l_c_rl lab=rst_latch}
C {lab_wire.sym} 150 -30 2 0 {name=l_c_vd lab=vdd}
C {lab_wire.sym} 150 -10 2 0 {name=l_c_vs lab=0}
C {lab_wire.sym} 150 10 2 0 {name=l_c_op lab=out_p}
C {lab_wire.sym} 150 30 2 0 {name=l_c_on lab=out_n}
C {code_shown.sym} 250 -150 0 0 {name=MODELS value="
.include /foss/pdks/gf180mcuD/libs.tech/ngspice/design.ngspice
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.control
save v(vin_p) v(vin_n) v(rst_latch) v(out_p) v(out_n)
tran 10p 60n
set filetype=ascii
write tb_strongarm_comp_core.raw
quit
.endc"}
C {title.sym} 0 300 0 0 {name=l_title author="Berkah Saluyu"}
