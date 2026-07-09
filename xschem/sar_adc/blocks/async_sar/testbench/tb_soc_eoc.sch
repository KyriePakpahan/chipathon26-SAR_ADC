v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -110 -170 -110 -160 {lab=VDD}
N -110 -100 -110 -90 {lab=0}
N -30 310 -30 320 {lab=0}
N -120 230 -120 240 {lab=0}
N -30 180 -30 250 {lab=clk}
N -120 160 -120 170 {lab=RST}
N 500 -40 500 -30 {lab=0}
N 560 -40 560 -30 {lab=0}
N 620 -40 620 -30 {lab=0}
N 680 -40 680 -30 {lab=0}
N 740 -40 740 -30 {lab=0}
N -30 140 160 140 {lab=clk}
N -30 140 -30 180 {lab=clk}
N -120 120 160 120 {lab=RST}
N -120 120 -120 160 {lab=RST}
C {sar_adc/blocks/async_sar/soc_eoc.sym} 310 160 0 0 {name=x1}
C {vsource.sym} -110 -130 0 0 {name=V1 value=5}
C {vdd.sym} -110 -170 0 0 {name=l1 lab=VDD}
C {gnd.sym} -110 -90 0 0 {name=l2 lab=0}
C {vsource.sym} -30 280 0 0 {name=V2 value="PULSE(0 5 15n 0.1n 0.1n 10n 20n)"}
C {gnd.sym} -30 320 0 0 {name=l3 lab=0}
C {vsource.sym} -120 200 0 0 {name=V3 value="PULSE(0 5 0 0.1n 0.1n 3n 100n)"}
C {gnd.sym} -120 240 0 0 {name=l4 lab=0}
C {lab_wire.sym} -30 140 0 0 {name=l5 lab=clk}
C {lab_wire.sym} -120 120 0 0 {name=l6 lab=RST}
C {lab_wire.sym} 460 120 2 0 {name=l7 lab=iter_2}
C {lab_wire.sym} 460 140 2 0 {name=l8 lab=iter_1}
C {lab_wire.sym} 460 160 2 0 {name=l9 lab=iter_0
}
C {lab_wire.sym} 460 180 2 0 {name=l10 lab=EOC}
C {lab_wire.sym} 460 200 2 0 {name=l11 lab=SOC}
C {res.sym} 500 -70 0 0 {name=R1 value=1Meg}
C {gnd.sym} 500 -30 0 0 {name=l12 lab=0}
C {lab_wire.sym} 500 -100 0 0 {name=l13 lab=iter_2}
C {res.sym} 560 -70 0 0 {name=R2 value=1Meg}
C {gnd.sym} 560 -30 0 0 {name=l14 lab=0}
C {lab_wire.sym} 560 -100 0 0 {name=l15 lab=iter_1}
C {res.sym} 620 -70 0 0 {name=R3 value=1Meg}
C {gnd.sym} 620 -30 0 0 {name=l16 lab=0}
C {lab_wire.sym} 620 -100 0 0 {name=l17 lab=iter_0}
C {res.sym} 680 -70 0 0 {name=R4 value=1Meg}
C {gnd.sym} 680 -30 0 0 {name=l18 lab=0}
C {lab_wire.sym} 680 -100 0 0 {name=l19 lab=EOC}
C {res.sym} 740 -70 0 0 {name=R5 value=1Meg}
C {gnd.sym} 740 -30 0 0 {name=l20 lab=0}
C {lab_wire.sym} 740 -100 0 0 {name=l21 lab=SOC}
C {code_shown.sym} 100 -200 0 0 {name=s1 value=".param fnoicor=0
.param sw_stat_mismatch=0
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.tran 0.1n 200n
.save all"}
