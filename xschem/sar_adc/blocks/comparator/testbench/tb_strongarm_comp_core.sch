v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 0 -380 50 -380 {lab=vin_p}
N 0 -360 50 -360 {lab=vin_n}
N 0 -340 50 -340 {lab=rst_latch}
N 350 -380 400 -380 {lab=vdd}
N 350 -360 420 -360 {lab=out_n}
N 350 -340 420 -340 {lab=out_p}
N 350 -320 400 -320 {lab=0}
N -150 -480 -150 -470 {lab=vdd}
N -150 -410 -150 -400 {lab=0}
N -80 -480 -80 -470 {lab=vin_p}
N -80 -410 -80 -400 {lab=0}
N -10 -480 -10 -470 {lab=vin_n}
N -10 -410 -10 -400 {lab=0}
N 60 -480 60 -470 {lab=rst_latch}
N 60 -410 60 -400 {lab=0}
C {title.sym} 160 -100 0 0 {name=l1 author="Berkah Saluyu"}
C {sar_adc/blocks/comparator/strongarm_comp_core.sym} 200 -350 0 0 {name=x1}
C {vsource.sym} -150 -440 0 0 {name=Vvdd value=3.3}
C {vdd.sym} -150 -480 0 0 {name=l_vdd1 lab=vdd}
C {gnd.sym} -150 -400 0 0 {name=l_gnd1 lab=0}
C {vsource.sym} -80 -440 0 0 {name=Vp value="pwl(0 0.8025 7n 0.8025 7.1n 0.7975 17n 0.7975 17.1n 2.5025 27n 2.5025 27.1n 2.4975 40n 2.4975)"}
C {gnd.sym} -80 -400 0 0 {name=l_gnd2 lab=0}
C {lab_wire.sym} -80 -480 0 0 {name=l_vp lab=vin_p}
C {vsource.sym} -10 -440 0 0 {name=Vn value="pwl(0 0.7975 7n 0.7975 7.1n 0.8025 17n 0.8025 17.1n 2.4975 27n 2.4975 27.1n 2.5025 40n 2.5025)"}
C {gnd.sym} -10 -400 0 0 {name=l_gnd3 lab=0}
C {lab_wire.sym} -10 -480 0 0 {name=l_vn lab=vin_n}
C {vsource.sym} 60 -440 0 0 {name=Vrst value="pulse(0 3.3 1n 100p 100p 4n 10n)"}
C {gnd.sym} 60 -400 0 0 {name=l_gnd4 lab=0}
C {lab_wire.sym} 60 -480 0 0 {name=l_vrst lab=rst_latch}
C {lab_wire.sym} 0 -380 0 0 {name=l_inp lab=vin_p}
C {lab_wire.sym} 0 -360 0 0 {name=l_inn lab=vin_n}
C {lab_wire.sym} 0 -340 0 0 {name=l_inrst lab=rst_latch}
C {vdd.sym} 400 -380 0 0 {name=l_vdd2 lab=vdd}
C {gnd.sym} 400 -320 0 0 {name=l_gnd5 lab=0}
C {lab_wire.sym} 420 -360 0 0 {name=l_outn lab=out_n}
C {lab_wire.sym} 420 -340 0 0 {name=l_outp lab=out_p}
C {code_shown.sym} 110 -220 0 0 {name=s1 only_toplevel=true
value=".include /foss/pdks/ciel/gf180mcu/versions/7b70722e33c03fcb5dabcf4d479fb0822d9251c9/gf180mcuD/libs.tech/ngspice/design.ngspice
.lib /foss/pdks/ciel/gf180mcu/versions/7b70722e33c03fcb5dabcf4d479fb0822d9251c9/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.control
  save v(vin_p) v(vin_n) v(rst_latch) v(out_p) v(out_n)
  tran 10p 40n
  plot out_n 
  plot out_p 
.endc"}
