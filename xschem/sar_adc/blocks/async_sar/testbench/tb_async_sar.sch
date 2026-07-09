v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -110 -170 -110 -160 {lab=vdd}
N -110 -100 -110 -90 {lab=0}
N -30 180 -30 250 {lab=start}
N -30 310 -30 320 {lab=0}
N -120 120 -120 170 {lab=out_p}
N -120 230 -120 240 {lab=0}
N -200 50 -200 70 {lab=out_n}
N -200 130 -200 150 {lab=0}
C {title.sym} -130 380 0 0 {name=l1 author="Berkah Saluyu"}
C {vsource.sym} -110 -130 0 0 {name=V1 value=3.3}
C {vdd.sym} -110 -170 0 0 {name=l1 lab=vdd}
C {gnd.sym} -110 -90 0 0 {name=l2 lab=0}
C {vsource.sym} -30 280 0 0 {name=V2 value="PULSE(0 3.3 0.1n 0.1n 0.1n 5n 1000n)"}
C {gnd.sym} -30 320 0 0 {name=l3 lab=0}
C {lab_wire.sym} -30 180 0 0 {name=l5 lab=start}
C {vsource.sym} -120 200 0 0 {name=V3 value=3.3}
C {gnd.sym} -120 240 0 0 {name=l4 lab=0}
C {lab_wire.sym} -120 120 0 0 {name=l6 lab=out_p}
C {lab_wire.sym} -200 50 0 0 {name=l_outn lab=out_n}
C {gnd.sym} -200 150 0 0 {name=l_gnd_outn lab=0}
C {sar_adc/blocks/async_sar/delay_line.sym} 40 50 0 0 {name=x_mock_comp}
C {lab_wire.sym} -110 50 0 0 {name=l_mc_in lab=rst_latch}
C {lab_wire.sym} 190 50 2 0 {name=l_mc_out lab=comp_done}
C {sar_adc/blocks/async_sar/async_sar.sym} 310 20 0 0 {name=x1}
C {lab_wire.sym} 480 -110 2 0 {name=l_l_0 lab=vdd}
C {lab_wire.sym} 290 -110 0 0 {name=l_l_1 lab=start}
C {lab_wire.sym} 290 -90 0 0 {name=l_l_2 lab=out_p}
C {lab_wire.sym} 290 -70 0 0 {name=l_l_3 lab=out_n}
C {lab_wire.sym} 290 -50 0 0 {name=l_l_4 lab=comp_done}
C {lab_wire.sym} 480 -10 2 0 {name=l_l_5 lab=0}
C {lab_wire.sym} 480 -50 2 0 {name=l_r_0 lab=sample_en}
C {lab_wire.sym} 480 -30 2 0 {name=l_r_1 lab=rst_latch}
C {lab_wire.sym} 480 10 2 0 {name=l_r_2 lab=done}
C {code_shown.sym} 70 -290 0 0 {name=s1 value=".param fnoicor=0
.param sw_stat_mismatch=0
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.options method=gear reltol=1e-3
.tran 0.1n 250n
.save all"}
C {lab_wire.sym} 480 -90 2 0 {name=p1 sig_type=std_logic lab=dout[7:0]}
C {lab_wire.sym} 480 -70 2 0 {name=p2 sig_type=std_logic lab=dac_in[7:0]}
C {vsource.sym} -200 100 0 0 {name=V4 value=0}
