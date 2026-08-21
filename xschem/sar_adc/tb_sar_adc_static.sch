v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
C {vsource.sym} -400 100 0 0 {name=V1 value=3.3}
C {lab_wire.sym} -400 70 0 0 {name=l_vdd lab=vdd}
C {lab_wire.sym} -400 130 0 0 {name=l_gnd1 lab=VSS}
C {vsource.sym} -400 200 0 0 {name=V2 value=3.3}
C {lab_wire.sym} -400 170 0 0 {name=l_vref lab=vref}
C {lab_wire.sym} -400 230 0 0 {name=l_gnd2 lab=VSS}
C {vsource.sym} -400 300 0 0 {name=V3 value="PULSE(0.85 2.85 0 2.5u 0 0 2.5u)"}
C {lab_wire.sym} -400 270 0 0 {name=l_vp lab=vin_p}
C {lab_wire.sym} -400 330 0 0 {name=l_gnd3 lab=VSS}
C {vsource.sym} -400 400 0 0 {name=V3n value=1.45}
C {lab_wire.sym} -400 370 0 0 {name=l_vn lab=vin_n}
C {lab_wire.sym} -400 430 0 0 {name=l_gnd3n lab=VSS}
C {vsource.sym} -400 500 0 0 {name=V4 value="PULSE(3.3 0 5n 0.1n 0.1n 95n 100n)"}
C {lab_wire.sym} -400 470 0 0 {name=l_start lab=start}
C {lab_wire.sym} -400 530 0 0 {name=l_gnd4 lab=VSS}
C {sar_adc/sar_adc_top.sym} 100 300 0 0 {name=x1}
C {lab_wire.sym} -50 230 0 0 {name=l_p_vp lab=vin_p}
C {lab_wire.sym} -50 250 0 0 {name=l_p_vn lab=vin_n}
C {lab_wire.sym} -50 280 0 0 {name=l_p_vref lab=vref}
C {lab_wire.sym} -50 310 0 0 {name=l_p_start lab=start}
C {lab_wire.sym} 100 180 0 0 {name=l_p_vdd lab=vdd}
C {lab_wire.sym} 100 420 0 0 {name=l_p_vss lab=VSS}
C {lab_wire.sym} 250 230 2 0 {name=l_p_done lab=done}
C {lab_wire.sym} 250 250 2 0 {name=l_p_do7 lab=dout7}
C {lab_wire.sym} 250 270 2 0 {name=l_p_do6 lab=dout6}
C {lab_wire.sym} 250 290 2 0 {name=l_p_do5 lab=dout5}
C {lab_wire.sym} 250 310 2 0 {name=l_p_do4 lab=dout4}
C {lab_wire.sym} 250 330 2 0 {name=l_p_do3 lab=dout3}
C {lab_wire.sym} 250 350 2 0 {name=l_p_do2 lab=dout2}
C {lab_wire.sym} 250 370 2 0 {name=l_p_do1 lab=dout1}
C {lab_wire.sym} 250 390 2 0 {name=l_p_do0 lab=dout0}
C {netlist_at_end.sym} 520 -80 0 0 {name=s1 value="
.param fnoicor=0
.param sw_stat_mismatch=0
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice mimcap_typical
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice cap_mim
C_Ldone done 0 10f
C_L0 dout0 0 10f
C_L1 dout1 0 10f
C_L2 dout2 0 10f
C_L3 dout3 0 10f
C_L4 dout4 0 10f
C_L5 dout5 0 10f
C_L6 dout6 0 10f
C_L7 dout7 0 10f
.GLOBAL vdd vss
V_VSS vss 0 0
.options method=gear reltol=1e-3 vntol=1e-4 abstol=1e-12
.control
save all
tran 0.1n 2.5u
plot v(vin_p) v(vin_n) v(start) v(done)
plot v(dout7)+28 v(dout6)+24 v(dout5)+20 v(dout4)+16 v(dout3)+12 v(dout2)+8 v(dout1)+4 v(dout0)
.endc"}
C {title.sym} 100 600 0 0 {name=l_title author="Berkah Saluyu"}
