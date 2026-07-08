v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -580 -130 -560 -130 {lab=rst}
N -580 -110 -560 -110 {lab=rst}
N -600 -120 -580 -120 {lab=rst}
N -580 -130 -580 -110 {lab=rst}
N -260 -130 -190 -130 {lab=rst_n_int}
N 110 -170 150 -170 {lab=iter_0}
N 110 -240 130 -240 {lab=iter_0}
N 110 -220 130 -220 {lab=iter_0}
N 130 -240 130 -220 {lab=iter_0}
N 130 -230 150 -230 {lab=iter_0}
N -210 -220 -190 -220 {lab=Q0_n}
N -210 -220 -210 -170 {lab=Q0_n}
N -210 -170 -190 -170 {lab=Q0_n}
N 170 -150 210 -150 {lab=rst_n_int}
N 190 -250 210 -250 {lab=Q1_n}
N 190 -250 190 -190 {lab=Q1_n}
N 190 -190 210 -190 {lab=Q1_n}
N 510 -270 530 -270 {lab=iter_1}
N 510 -250 530 -250 {lab=iter_1}
N 530 -270 530 -250 {lab=iter_1}
N 510 -190 560 -190 {lab=iter_1}
N 560 -300 560 -190 {lab=iter_1}
N 530 -260 560 -260 {lab=iter_1}
N 630 -270 650 -270 {lab=Q2_n}
N 630 -270 630 -210 {lab=Q2_n}
N 630 -210 650 -210 {lab=Q2_n}
N 610 -170 650 -170 {lab=rst_n_int}
N 950 -210 980 -210 {lab=iter_2}
N 950 -270 970 -270 {lab=iter_2}
N 970 -290 970 -270 {lab=iter_2}
N 950 -290 970 -290 {lab=iter_2}
N 980 -210 990 -210 {lab=iter_2}
N 990 -320 990 -210 {lab=iter_2}
N 970 -280 990 -280 {lab=iter_2}
N -250 60 -190 60 {lab=iter_0}
N -250 80 -190 80 {lab=iter_1}
N -250 100 -190 100 {lab=iter_2}
N 140 50 160 50 {lab=#net1}
N 140 50 140 70 {lab=#net1}
N 140 70 160 70 {lab=#net1}
N 110 60 140 60 {lab=#net1}
N 460 50 490 50 {lab=EOC}
N -250 180 -190 180 {lab=Q2_n}
N -250 200 -190 200 {lab=Q1_n}
N -250 220 -190 220 {lab=Q0_n}
N 140 170 160 170 {lab=#net2}
N 140 190 160 190 {lab=#net2}
N 140 170 140 190 {lab=#net2}
N 110 180 140 180 {lab=#net2}
N 460 170 490 170 {lab=SOC}
N 560 -340 560 -300 {lab=iter_1}
N 990 -350 990 -320 {lab=iter_2}
N 150 -310 150 -170 {lab=iter_0}
N 190 -170 210 -170 {lab=iter_0}
N 630 -190 650 -190 {lab=iter_1}
C {ipin.sym} -770 -170 0 0 {name=p_clk lab=clk}
C {ipin.sym} -770 -210 0 0 {name=p_rst lab=rst}
C {opin.sym} 150 -310 3 0 {name=p_iter0 lab=iter_0}
C {opin.sym} 490 50 0 0 {name=p_eoc lab=EOC}
C {lab_wire.sym} -600 -120 0 0 {name=l22 sig_type=std_logic lab=rst}
C {lab_wire.sym} -250 180 0 0 {name=l31 sig_type=std_logic lab=Q2_n}
C {lab_wire.sym} -250 200 0 0 {name=l32 sig_type=std_logic lab=Q1_n}
C {lab_wire.sym} -250 220 0 0 {name=l33 sig_type=std_logic lab=Q0_n}
C {xschem/sar_adc/async_nand2.sym} -410 -120 0 0 {name=x5}
C {xschem/sar_adc/dff_cell.sym} -40 -150 0 0 {name=x4}
C {lab_wire.sym} -770 -210 2 0 {name=l23 sig_type=std_logic lab=rst}
C {lab_wire.sym} -770 -170 2 0 {name=l37 sig_type=std_logic lab=clk}
C {lab_wire.sym} -190 -150 0 0 {name=l38 sig_type=std_logic lab=clk}
C {xschem/sar_adc/async_nand2.sym} -40 -230 2 0 {name=x6}
C {xschem/sar_adc/dff_cell.sym} 360 -170 0 0 {name=x1}
C {xschem/sar_adc/async_nand2.sym} 360 -260 2 0 {name=x7}
C {lab_wire.sym} -220 -130 3 0 {name=l1 sig_type=std_logic lab=rst_n_int}
C {lab_wire.sym} 170 -150 3 0 {name=l2 sig_type=std_logic lab=rst_n_int}
C {opin.sym} 560 -340 3 0 {name=p_iter3 lab=iter_1
}
C {xschem/sar_adc/dff_cell.sym} 800 -190 0 0 {name=x8}
C {xschem/sar_adc/async_nand2.sym} 800 -280 2 0 {name=x9}
C {lab_wire.sym} 610 -170 3 0 {name=l3 sig_type=std_logic lab=rst_n_int}
C {opin.sym} 990 -350 3 0 {name=p_iter4 lab=iter_2
}
C {xschem/sar_adc/async_nand3.sym} -40 80 0 0 {name=x2}
C {xschem/sar_adc/async_nand2.sym} 310 60 0 0 {name=x3}
C {xschem/sar_adc/async_nand3.sym} -40 200 0 0 {name=x10}
C {xschem/sar_adc/async_nand2.sym} 310 180 0 0 {name=x11}
C {lab_wire.sym} 630 -240 2 0 {name=l5 sig_type=std_logic lab=Q2_n}
C {lab_wire.sym} 190 -220 2 0 {name=l6 sig_type=std_logic lab=Q1_n}
C {lab_wire.sym} -210 -190 0 0 {name=l7 sig_type=std_logic lab=Q0_n}
C {opin.sym} 490 170 0 0 {name=p_soc1 lab=SOC}
C {lab_wire.sym} 190 -170 0 0 {name=l10 sig_type=std_logic lab=iter_0}
C {lab_wire.sym} 630 -190 0 0 {name=l11 sig_type=std_logic lab=iter_1}
C {lab_wire.sym} -250 60 0 0 {name=l4 sig_type=std_logic lab=iter_0
}
C {lab_wire.sym} -250 80 0 0 {name=l8 sig_type=std_logic lab=iter_1}
C {lab_wire.sym} -250 100 0 0 {name=l9 sig_type=std_logic lab=iter_2

}
