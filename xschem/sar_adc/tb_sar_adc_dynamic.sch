v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
C {title.sym} 160 -40 0 0 {name=l1 author="Berkah Saluyu"}

# DC Sources
C {vsource.sym} -150 100 0 0 {name=V1 value=3.3}
C {lab_wire.sym} -150 60 0 0 {name=l_vdd lab=vdd}
C {lab_wire.sym} -150 140 0 0 {name=l_gnd1 lab=0}
N -150 60 -150 70 {lab=vdd}
N -150 130 -150 140 {lab=0}

C {vsource.sym} -150 220 0 0 {name=V2 value=3.3}
C {lab_wire.sym} -150 180 0 0 {name=l_vref lab=vref}
C {lab_wire.sym} -150 260 0 0 {name=l_gnd2 lab=0}
N -150 180 -150 190 {lab=vref}
N -150 250 -150 260 {lab=0}

# Dynamic Coherent Sine Input (0.95V - 2.35V, coherent M=7 @ 10 MS/s)
C {vsource.sym} -150 340 0 0 {name=V3 value="SIN(1.65 0.70 4.53125MEG)"}
C {lab_wire.sym} -150 300 0 0 {name=l_vin lab=vin}
C {lab_wire.sym} -150 380 0 0 {name=l_gnd3 lab=0}
N -150 300 -150 310 {lab=vin}
N -150 370 -150 380 {lab=0}

# 10 MS/s Start Pulse (100ns Period, 5ns sample pulse every 100ns)
C {vsource.sym} -150 460 0 0 {name=V4 value="PULSE(3.3 0 5n 0.1n 0.1n 95n 100n)"}
C {lab_wire.sym} -150 420 0 0 {name=l_start lab=start}
C {lab_wire.sym} -150 500 0 0 {name=l_gnd4 lab=0}
N -150 420 -150 430 {lab=start}
N -150 490 -150 500 {lab=0}

# SAR ADC Top Instantiation
C {sar_adc/sar_adc_top.sym} 250 300 0 0 {name=x1}
C {lab_wire.sym} 100 270 0 0 {name=l_p_start lab=start}
C {lab_wire.sym} 100 290 0 0 {name=l_p_vin lab=vin}
C {lab_wire.sym} 100 310 0 0 {name=l_p_vref lab=vref}
C {lab_wire.sym} 400 270 2 0 {name=l_p_vdd lab=vdd}
C {lab_wire.sym} 400 290 2 0 {name=l_p_dout lab=dout[7:0]}
C {lab_wire.sym} 400 310 2 0 {name=l_p_done lab=done}
C {lab_wire.sym} 400 330 2 0 {name=l_p_vss lab=0}

# Global SPICE Code Block at End
C {netlist_at_end.sym} 100 50 0 0 {name=s1 value=".param fnoicor=0
.param sw_stat_mismatch=0
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.GLOBAL vdd vss
V_VSS vss 0 0
.options method=gear reltol=1e-3 vntol=1e-4 abstol=1e-12
.save all
.control
set filetype=ascii
tran 0.2n 6.4u
write tb_sar_adc_dynamic.raw
quit
.endc"}
