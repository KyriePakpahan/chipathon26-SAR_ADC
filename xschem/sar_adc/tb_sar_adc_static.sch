v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
C {vsource.sym} -200 100 0 0 {name=V1 value=3.3}
C {lab_wire.sym} -200 70 0 0 {name=l_vdd lab=vdd}
C {lab_wire.sym} -200 130 0 0 {name=l_gnd1 lab=VSS}
C {vsource.sym} -200 220 0 0 {name=V2 value=3.3}
C {lab_wire.sym} -200 190 0 0 {name=l_vref lab=vref}
C {lab_wire.sym} -200 250 0 0 {name=l_gnd2 lab=VSS}
C {vsource.sym} -200 340 0 0 {name=V3 value="PULSE(0 3.3 0 25.6u 0 0 25.6u)"}
C {lab_wire.sym} -200 310 0 0 {name=l_vin lab=vin}
C {lab_wire.sym} -200 370 0 0 {name=l_gnd3 lab=VSS}
C {vsource.sym} -200 460 0 0 {name=V4 value="PULSE(3.3 0 5n 0.1n 0.1n 95n 100n)"}
C {lab_wire.sym} -200 430 0 0 {name=l_start lab=start}
C {lab_wire.sym} -200 490 0 0 {name=l_gnd4 lab=VSS}
C {sar_adc/sar_adc_top.sym} 250 300 0 0 {name=x1}
C {lab_wire.sym} 100 200 0 0 {name=l_p_vin lab=vin}
C {lab_wire.sym} 100 220 0 0 {name=l_p_vref lab=vref}
C {lab_wire.sym} 100 240 0 0 {name=l_p_start lab=start}
C {lab_wire.sym} 400 200 2 0 {name=l_p_vdd lab=vdd}
C {lab_wire.sym} 400 220 2 0 {name=l_p_vss lab=0}
C {lab_wire.sym} 400 240 2 0 {name=l_p_done lab=done}
C {lab_wire.sym} 400 260 2 0 {name=l_p_do7 lab=dout[7]}
C {lab_wire.sym} 400 280 2 0 {name=l_p_do6 lab=dout[6]}
C {lab_wire.sym} 400 300 2 0 {name=l_p_do5 lab=dout[5]}
C {lab_wire.sym} 400 320 2 0 {name=l_p_do4 lab=dout[4]}
C {lab_wire.sym} 400 340 2 0 {name=l_p_do3 lab=dout[3]}
C {lab_wire.sym} 400 360 2 0 {name=l_p_do2 lab=dout[2]}
C {lab_wire.sym} 400 380 2 0 {name=l_p_do1 lab=dout[1]}
C {lab_wire.sym} 400 400 2 0 {name=l_p_do0 lab=dout[0]}
C {netlist_at_end.sym} 100 50 0 0 {name=s1 value="
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
save all
set filetype=ascii
tran 0.2n 25.6u
write tb_sar_adc_static.raw
quit
.endc"}
C {title.sym} 100 600 0 0 {name=l_title author="Berkah Saluyu"}
