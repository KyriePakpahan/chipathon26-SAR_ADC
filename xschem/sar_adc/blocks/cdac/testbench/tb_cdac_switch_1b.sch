v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
C {vsource.sym} -400 -200 0 0 {name=V_VDD value=3.3}
C {lab_wire.sym} -400 -240 0 0 {name=l_vdd lab=vdd}
C {lab_wire.sym} -400 -160 0 0 {name=l_gnd1 lab=0}
C {vsource.sym} -400 -80 0 0 {name=V_VREF value=3.3}
C {lab_wire.sym} -400 -120 0 0 {name=l_vref lab=vref}
C {lab_wire.sym} -400 -40 0 0 {name=l_gnd2 lab=0}
C {vsource.sym} -400 40 0 0 {name=V_BIT value="pulse(0 3.3 1n 0.1n 0.1n 5n 10n)"}
C {lab_wire.sym} -400 0 0 0 {name=l_bit lab=bit}
C {lab_wire.sym} -400 80 0 0 {name=l_gnd3 lab=0}
C {sar_adc/blocks/cdac/cdac_switch_1b.sym} 0 0 0 0 {name=x1}
C {lab_wire.sym} -150 -30 0 0 {name=l_dut_b lab=bit}
C {lab_wire.sym} 150 -30 2 0 {name=l_dut_vr lab=vref}
C {lab_wire.sym} 150 -10 2 0 {name=l_dut_vd lab=vdd}
C {lab_wire.sym} 150 10 2 0 {name=l_dut_vs lab=vss}
C {lab_wire.sym} 150 30 2 0 {name=l_dut_bot lab=bot}
C {capa.sym} 250 30 0 0 {name=Cload value=10f}
C {lab_wire.sym} 250 0 2 0 {name=l_cl_p lab=bot}
C {lab_wire.sym} 250 60 0 0 {name=l_cl_m lab=0}
C {code_shown.sym} 350 -150 0 0 {name=MODELS value="
.include /foss/pdks/gf180mcuD/libs.tech/ngspice/design.ngspice
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.GLOBAL vdd vss
V_VSS vss 0 0
.control
tran 10p 30n
set filetype=ascii
write tb_cdac_switch_1b.raw
quit
.endc"}
C {title.sym} 0 250 0 0 {name=l_title author="Berkah Saluyu"}
