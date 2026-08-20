v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
C {vsource.sym} -400 -200 0 0 {name=V_VDD value=3.3}
C {lab_wire.sym} -400 -230 0 0 {name=l_vdd lab=vdd}
C {lab_wire.sym} -400 -170 2 0 {name=l_gnd1 lab=0}
C {vsource.sym} -400 -80 0 0 {name=V_VREF value=3.3}
C {lab_wire.sym} -400 -110 0 0 {name=l_vref lab=vref}
C {lab_wire.sym} -400 -50 2 0 {name=l_gnd2 lab=0}
C {vsource.sym} -400 40 0 0 {name=V_VSS value=0}
C {lab_wire.sym} -400 10 0 0 {name=l_vss lab=vss}
C {lab_wire.sym} -400 70 2 0 {name=l_gnd3 lab=0}
C {vsource.sym} -400 160 0 0 {name=V_D7 value="PULSE(0 3.3 0 1n 1n 2u 4u)"}
C {lab_wire.sym} -400 130 0 0 {name=l_vd7 lab=dac_in[7]}
C {lab_wire.sym} -400 190 0 0 {name=l_gnd4 lab=0}
C {vsource.sym} -400 280 0 0 {name=V_D6 value=0}
C {lab_wire.sym} -400 250 0 0 {name=l_vd6 lab=dac_in[6]}
C {lab_wire.sym} -400 310 2 0 {name=l_gnd_d6 lab=0}
C {vsource.sym} -400 380 0 0 {name=V_D5 value=0}
C {lab_wire.sym} -400 350 0 0 {name=l_vd5 lab=dac_in[5]}
C {lab_wire.sym} -400 410 2 0 {name=l_gnd_d5 lab=0}
C {vsource.sym} -400 480 0 0 {name=V_D4 value=0}
C {lab_wire.sym} -400 450 0 0 {name=l_vd4 lab=dac_in[4]}
C {lab_wire.sym} -400 510 2 0 {name=l_gnd_d4 lab=0}
C {vsource.sym} -400 580 0 0 {name=V_D3 value=0}
C {lab_wire.sym} -400 550 0 0 {name=l_vd3 lab=dac_in[3]}
C {lab_wire.sym} -400 610 2 0 {name=l_gnd_d3 lab=0}
C {vsource.sym} -400 680 0 0 {name=V_D2 value=0}
C {lab_wire.sym} -400 650 0 0 {name=l_vd2 lab=dac_in[2]}
C {lab_wire.sym} -400 710 2 0 {name=l_gnd_d2 lab=0}
C {vsource.sym} -400 780 0 0 {name=V_D1 value=0}
C {lab_wire.sym} -400 750 0 0 {name=l_vd1 lab=dac_in[1]}
C {lab_wire.sym} -400 810 2 0 {name=l_gnd_d1 lab=0}
C {vsource.sym} -400 880 0 0 {name=V_D0 value=0}
C {lab_wire.sym} -400 850 0 0 {name=l_vd0 lab=dac_in[0]}
C {lab_wire.sym} -400 910 2 0 {name=l_gnd_d0 lab=0}
C {sar_adc/blocks/cdac/cdac_8bit.sym} 100 0 0 0 {name=x1}
C {lab_wire.sym} -50 -100 0 0 {name=l_dut_vr lab=vref}
C {lab_wire.sym} -50 -80 0 0 {name=l_dut_di7 lab=dac_in[7]}
C {lab_wire.sym} -50 -60 0 0 {name=l_dut_di6 lab=dac_in[6]}
C {lab_wire.sym} -50 -40 0 0 {name=l_dut_di5 lab=dac_in[5]}
C {lab_wire.sym} -50 -20 0 0 {name=l_dut_di4 lab=dac_in[4]}
C {lab_wire.sym} -50 0 0 0 {name=l_dut_di3 lab=dac_in[3]}
C {lab_wire.sym} -50 20 0 0 {name=l_dut_di2 lab=dac_in[2]}
C {lab_wire.sym} -50 40 0 0 {name=l_dut_di1 lab=dac_in[1]}
C {lab_wire.sym} -50 60 0 0 {name=l_dut_di0 lab=dac_in[0]}
C {lab_wire.sym} 250 -100 2 0 {name=l_dut_vdac lab=vdac}
C {lab_wire.sym} 250 -80 2 0 {name=l_dut_vd lab=vdd}
C {lab_wire.sym} 250 -60 2 0 {name=l_dut_vs lab=vss}
C {res.sym} 350 -100 0 0 {name=R_load value=1G}
C {lab_wire.sym} 350 -130 0 0 {name=l_rl_p lab=vdac}
C {lab_wire.sym} 350 -70 2 0 {name=l_rl_m lab=0}
C {code_shown.sym} 450 -200 0 0 {name=MODELS value="
.include /foss/pdks/gf180mcuD/libs.tech/ngspice/design.ngspice
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice mimcap_typical
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice cap_mim
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice res_typical
.control
tran 10n 10u
set filetype=ascii
write tb_cdac_8bit.raw
quit
.endc"}
C {title.sym} 100 600 0 0 {name=l_title author="Berkah Saluyu"}
