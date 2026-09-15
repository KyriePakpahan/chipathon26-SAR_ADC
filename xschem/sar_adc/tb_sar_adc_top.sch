v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
C {vsource.sym} -400 100 0 0 {name=V1 value=3.3}
C {lab_wire.sym} -400 70 0 0 {name=l_vdd lab=vdd}
C {lab_wire.sym} -400 130 0 0 {name=l_gnd1 lab=vss}
C {vsource.sym} -400 200 0 0 {name=V2 value=3.3}
C {lab_wire.sym} -400 170 0 0 {name=l_vref lab=vref}
C {lab_wire.sym} -400 230 0 0 {name=l_gnd2 lab=vss}
C {vsource.sym} -400 300 0 0 {name=V3 value=1.65}
C {lab_wire.sym} -400 270 0 0 {name=l_vp lab=vin}
C {lab_wire.sym} -400 330 0 0 {name=l_gnd3 lab=vss}
C {vsource.sym} -400 400 0 0 {name=V4 value="PULSE(3.3 0 5n 0.1n 0.1n 95n 100n)"}
C {lab_wire.sym} -400 370 0 0 {name=l_start lab=start}
C {lab_wire.sym} -400 430 0 0 {name=l_gnd4 lab=vss}
C {sar_adc/sar_adc_top.sym} 100 300 0 0 {name=x1}
C {lab_wire.sym} -50 200 0 0 {name=l_p_vin lab=vin}
C {lab_wire.sym} -50 220 0 0 {name=l_p_vref lab=vref}
C {lab_wire.sym} -50 240 0 0 {name=l_p_start lab=start}
C {lab_wire.sym} 250 200 2 0 {name=l_p_done lab=done}
C {lab_wire.sym} 250 220 2 0 {name=l_p_do7 lab=dout[7]}
C {lab_wire.sym} 250 240 2 0 {name=l_p_do6 lab=dout[6]}
C {lab_wire.sym} 250 260 2 0 {name=l_p_do5 lab=dout[5]}
C {lab_wire.sym} 250 280 2 0 {name=l_p_do4 lab=dout[4]}
C {lab_wire.sym} 250 300 2 0 {name=l_p_do3 lab=dout[3]}
C {lab_wire.sym} 250 320 2 0 {name=l_p_do2 lab=dout[2]}
C {lab_wire.sym} 250 340 2 0 {name=l_p_do1 lab=dout[1]}
C {lab_wire.sym} 250 360 2 0 {name=l_p_vdd lab=vdd}
C {lab_wire.sym} 250 380 2 0 {name=l_p_do0 lab=dout[0]}
C {lab_wire.sym} 250 400 2 0 {name=l_p_vss lab=vss}
C {netlist_at_end.sym} 520 -80 0 0 {name=s1 value="
.param fnoicor=0
.param sw_stat_mismatch=0
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice mimcap_typical
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice cap_mim
C_Ldone done 0 10f
C_L0 dout[0] 0 10f
C_L1 dout[1] 0 10f
C_L2 dout[2] 0 10f
C_L3 dout[3] 0 10f
C_L4 dout[4] 0 10f
C_L5 dout[5] 0 10f
C_L6 dout[6] 0 10f
C_L7 dout[7] 0 10f
.GLOBAL vdd vss
V_VSS vss 0 0
.options method=gear reltol=1e-3 vntol=1e-4 abstol=1e-12
.control
set filetype=ascii
tran 0.1n 80n
meas tran t_done WHEN v(done)=1.65 RISE=1
meas tran v_d7 FIND v(dout[7]) AT=70n
meas tran v_d6 FIND v(dout[6]) AT=70n
meas tran v_d5 FIND v(dout[5]) AT=70n
meas tran v_d4 FIND v(dout[4]) AT=70n
meas tran v_d3 FIND v(dout[3]) AT=70n
meas tran v_d2 FIND v(dout[2]) AT=70n
meas tran v_d1 FIND v(dout[1]) AT=70n
meas tran v_d0 FIND v(dout[0]) AT=70n
meas tran v_sh FIND v(x1.vhold) AT=4.5n
meas tran v_dac_rst FIND v(x1.vdac) AT=4.5n
print t_done v_d7 v_d6 v_d5 v_d4 v_d3 v_d2 v_d1 v_d0 v_sh v_dac_rst
write netlist/tb_sar_adc_top.raw
quit
.endc"}
C {title.sym} 100 600 0 0 {name=l_title author="Berkah Saluyu"}
