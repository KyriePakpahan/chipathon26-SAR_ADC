v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 250 -760 280 -760 {lab=start}
N 250 -720 280 -720 {lab=out_p}
N 250 -680 280 -680 {lab=out_n}
N 250 -640 280 -640 {lab=comp_done}
N -20 -670 10 -670 {lab=VDD}
N -20 -630 10 -630 {lab=VSS}
N 490 -870 520 -870 {lab=sample_en}
N 490 -840 520 -840 {lab=rst_latch}
N 490 -810 520 -810 {lab=done}
N 490 -650 520 -650 {lab=dout[0]}
N 490 -480 520 -480 {lab=dac_in[0]}
N 490 -670 520 -670 {lab=dout[1]}
N 490 -500 520 -500 {lab=dac_in[1]}
N 490 -690 520 -690 {lab=dout[2]}
N 490 -520 520 -520 {lab=dac_in[2]}
N 490 -710 520 -710 {lab=dout[3]}
N 490 -540 520 -540 {lab=dac_in[3]}
N 490 -730 520 -730 {lab=dout[4]}
N 490 -560 520 -560 {lab=dac_in[4]}
N 490 -750 520 -750 {lab=dout[5]}
N 490 -580 520 -580 {lab=dac_in[5]}
N 490 -770 520 -770 {lab=dout[6]}
N 490 -600 520 -600 {lab=dac_in[6]}
N 490 -790 520 -790 {lab=dout[7]}
N 490 -620 520 -620 {lab=dac_in[7]}
C {title.sym} -1240 520 0 0 {name=l1 author="Berkah Saluyu"}
C {ipin.sym} 250 -760 0 0 {name=p1 lab=start}
C {ipin.sym} 250 -720 0 0 {name=p2 lab=out_p}
C {ipin.sym} 250 -680 0 0 {name=p3 lab=out_n}
C {ipin.sym} 250 -640 0 0 {name=p4 lab=comp_done}
C {lab_wire.sym} 280 -760 2 0 {name=l_p1 lab=start}
C {lab_wire.sym} 280 -720 2 0 {name=l_p2 lab=out_p}
C {lab_wire.sym} 280 -680 2 0 {name=l_p3 lab=out_n}
C {lab_wire.sym} 280 -640 2 0 {name=l_p4 lab=comp_done}
C {iopin.sym} -20 -670 3 0 {name=p6 lab=VDD}
C {iopin.sym} -20 -630 1 0 {name=p7 lab=VSS}
C {lab_wire.sym} 10 -670 2 0 {name=l_p6 lab=VDD}
C {lab_wire.sym} 10 -630 2 0 {name=l_p7 lab=VSS}
C {opin.sym} 490 -870 2 0 {name=p8 lab=sample_en}
C {opin.sym} 490 -840 2 0 {name=p9 lab=rst_latch}
C {opin.sym} 490 -810 2 0 {name=p12 lab=done}
C {lab_wire.sym} 520 -870 2 0 {name=l_p8 lab=sample_en}
C {lab_wire.sym} 520 -840 2 0 {name=l_p9 lab=rst_latch}
C {lab_wire.sym} 520 -810 2 0 {name=l_p12 lab=done}
C {opin.sym} 490 -650 2 0 {name=p_do0 lab=dout[0]}
C {lab_wire.sym} 520 -650 2 0 {name=l_pdo0 lab=dout[0]}
C {opin.sym} 490 -480 2 0 {name=p_di0 lab=dac_in[0]}
C {lab_wire.sym} 520 -480 2 0 {name=l_pdi0 lab=dac_in[0]}
C {opin.sym} 490 -670 2 0 {name=p_do1 lab=dout[1]}
C {lab_wire.sym} 520 -670 2 0 {name=l_pdo1 lab=dout[1]}
C {opin.sym} 490 -500 2 0 {name=p_di1 lab=dac_in[1]}
C {lab_wire.sym} 520 -500 2 0 {name=l_pdi1 lab=dac_in[1]}
C {opin.sym} 490 -690 2 0 {name=p_do2 lab=dout[2]}
C {lab_wire.sym} 520 -690 2 0 {name=l_pdo2 lab=dout[2]}
C {opin.sym} 490 -520 2 0 {name=p_di2 lab=dac_in[2]}
C {lab_wire.sym} 520 -520 2 0 {name=l_pdi2 lab=dac_in[2]}
C {opin.sym} 490 -710 2 0 {name=p_do3 lab=dout[3]}
C {lab_wire.sym} 520 -710 2 0 {name=l_pdo3 lab=dout[3]}
C {opin.sym} 490 -540 2 0 {name=p_di3 lab=dac_in[3]}
C {lab_wire.sym} 520 -540 2 0 {name=l_pdi3 lab=dac_in[3]}
C {opin.sym} 490 -730 2 0 {name=p_do4 lab=dout[4]}
C {lab_wire.sym} 520 -730 2 0 {name=l_pdo4 lab=dout[4]}
C {opin.sym} 490 -560 2 0 {name=p_di4 lab=dac_in[4]}
C {lab_wire.sym} 520 -560 2 0 {name=l_pdi4 lab=dac_in[4]}
C {opin.sym} 490 -750 2 0 {name=p_do5 lab=dout[5]}
C {lab_wire.sym} 520 -750 2 0 {name=l_pdo5 lab=dout[5]}
C {opin.sym} 490 -580 2 0 {name=p_di5 lab=dac_in[5]}
C {lab_wire.sym} 520 -580 2 0 {name=l_pdi5 lab=dac_in[5]}
C {opin.sym} 490 -770 2 0 {name=p_do6 lab=dout[6]}
C {lab_wire.sym} 520 -770 2 0 {name=l_pdo6 lab=dout[6]}
C {opin.sym} 490 -600 2 0 {name=p_di6 lab=dac_in[6]}
C {lab_wire.sym} 520 -600 2 0 {name=l_pdi6 lab=dac_in[6]}
C {opin.sym} 490 -790 2 0 {name=p_do7 lab=dout[7]}
C {lab_wire.sym} 520 -790 2 0 {name=l_pdo7 lab=dout[7]}
C {opin.sym} 490 -620 2 0 {name=p_di7 lab=dac_in[7]}
C {lab_wire.sym} 520 -620 2 0 {name=l_pdi7 lab=dac_in[7]}
C {xschem/sar_adc/async_inverter.sym} -1200 -150 0 0 {name=x_inv_rst}
C {lab_wire.sym} -1350 -150 0 0 {name=l_rst_in lab=start}
C {lab_wire.sym} -1050 -150 2 0 {name=l_rst_out lab=rst_n_int}
C {xschem/sar_adc/async_inverter.sym} -1200 -100 0 0 {name=x_inv_clk}
C {lab_wire.sym} -1350 -100 0 0 {name=l_clk_in lab=comp_done}
C {lab_wire.sym} -1050 -100 2 0 {name=l_clk_out lab=comp_done_n}
C {xschem/sar_adc/async_inverter.sym} -1200 -200 0 0 {name=x_inv_se1}
C {lab_wire.sym} -1350 -200 0 0 {name=l_se1_in lab=start}
C {lab_wire.sym} -1050 -200 2 0 {name=l_se1_out lab=sample_en_n}
C {xschem/sar_adc/async_inverter.sym} -1200 -250 0 0 {name=x_inv_se2}
C {lab_wire.sym} -1350 -250 0 0 {name=l_se2_in lab=sample_en_n}
C {lab_wire.sym} -1050 -250 2 0 {name=l_se2_out lab=sample_en}
C {xschem/sar_adc/dff_cell.sym} -600 150 0 0 {name=x_sin_dff}
C {lab_wire.sym} -750 130 0 0 {name=l_sin_d lab=VDD}
C {lab_wire.sym} -750 150 0 0 {name=l_sin_clk lab=comp_done}
C {lab_wire.sym} -750 170 0 0 {name=l_sin_rst lab=rst_n_int}
C {lab_wire.sym} -450 130 2 0 {name=l_sin_q lab=serial_in_q}
C {xschem/sar_adc/async_inverter.sym} -1200 -310 0 0 {name=x_sin_inv}
C {lab_wire.sym} -1350 -310 0 0 {name=l_isin_in lab=serial_in_q}
C {lab_wire.sym} -1050 -310 2 0 {name=l_isin_out lab=serial_in}
C {xschem/sar_adc/shift_reg_8bit.sym} -590 -70 0 0 {name=x_shift}
C {lab_wire.sym} -740 -150 0 0 {name=l_sh_sin lab=serial_in}
C {lab_wire.sym} -740 -130 0 0 {name=l_sh_clk lab=comp_done}
C {lab_wire.sym} -740 -110 0 0 {name=l_sh_rst lab=rst_n_int}
C {lab_wire.sym} -440 -150 2 0 {name=l_sh_q2 lab=Q2}
C {lab_wire.sym} -440 -130 2 0 {name=l_sh_q1 lab=Q1}
C {lab_wire.sym} -440 -110 2 0 {name=l_sh_q0 lab=Q0}
C {lab_wire.sym} -440 -90 2 0 {name=l_sh_q3 lab=Q3}
C {lab_wire.sym} -440 -70 2 0 {name=l_sh_q4 lab=Q4}
C {lab_wire.sym} -440 -50 2 0 {name=l_sh_q5 lab=Q5}
C {lab_wire.sym} -440 -30 2 0 {name=l_sh_q6 lab=Q6}
C {lab_wire.sym} -440 -10 2 0 {name=l_sh_q7 lab=Q7}
C {lab_wire.sym} -440 10 2 0 {name=l_sh_dn lab=done}
C {xschem/sar_adc/bit_reg.sym} -100 -380 0 0 {name=x_bit0}
C {lab_wire.sym} -250 -410 0 0 {name=l_bit_co0 lab=out_p}
C {lab_wire.sym} -250 -390 0 0 {name=l_bit_en0 lab=Q0}
C {lab_wire.sym} -250 -370 0 0 {name=l_bit_rst0 lab=rst_n_int}
C {lab_wire.sym} -250 -350 0 0 {name=l_bit_clk0 lab=comp_done}
C {lab_wire.sym} 50 -410 2 0 {name=l_bit_out0 lab=dout[0]}
C {xschem/sar_adc/bit_reg.sym} -100 -270 0 0 {name=x_bit1}
C {lab_wire.sym} -250 -300 0 0 {name=l_bit_co1 lab=out_p}
C {lab_wire.sym} -250 -280 0 0 {name=l_bit_en1 lab=Q1}
C {lab_wire.sym} -250 -260 0 0 {name=l_bit_rst1 lab=rst_n_int}
C {lab_wire.sym} -250 -240 0 0 {name=l_bit_clk1 lab=comp_done}
C {lab_wire.sym} 50 -300 2 0 {name=l_bit_out1 lab=dout[1]}
C {xschem/sar_adc/bit_reg.sym} -100 -160 0 0 {name=x_bit2}
C {lab_wire.sym} -250 -190 0 0 {name=l_bit_co2 lab=out_p}
C {lab_wire.sym} -250 -170 0 0 {name=l_bit_en2 lab=Q2}
C {lab_wire.sym} -250 -150 0 0 {name=l_bit_rst2 lab=rst_n_int}
C {lab_wire.sym} -250 -130 0 0 {name=l_bit_clk2 lab=comp_done}
C {lab_wire.sym} 50 -190 2 0 {name=l_bit_out2 lab=dout[2]}
C {xschem/sar_adc/bit_reg.sym} -100 -50 0 0 {name=x_bit3}
C {lab_wire.sym} -250 -80 0 0 {name=l_bit_co3 lab=out_p}
C {lab_wire.sym} -250 -60 0 0 {name=l_bit_en3 lab=Q3}
C {lab_wire.sym} -250 -40 0 0 {name=l_bit_rst3 lab=rst_n_int}
C {lab_wire.sym} -250 -20 0 0 {name=l_bit_clk3 lab=comp_done}
C {lab_wire.sym} 50 -80 2 0 {name=l_bit_out3 lab=dout[3]}
C {xschem/sar_adc/bit_reg.sym} -100 60 0 0 {name=x_bit4}
C {lab_wire.sym} -250 30 0 0 {name=l_bit_co4 lab=out_p}
C {lab_wire.sym} -250 50 0 0 {name=l_bit_en4 lab=Q4}
C {lab_wire.sym} -250 70 0 0 {name=l_bit_rst4 lab=rst_n_int}
C {lab_wire.sym} -250 90 0 0 {name=l_bit_clk4 lab=comp_done}
C {lab_wire.sym} 50 30 2 0 {name=l_bit_out4 lab=dout[4]}
C {xschem/sar_adc/bit_reg.sym} -100 170 0 0 {name=x_bit5}
C {lab_wire.sym} -250 140 0 0 {name=l_bit_co5 lab=out_p}
C {lab_wire.sym} -250 160 0 0 {name=l_bit_en5 lab=Q5}
C {lab_wire.sym} -250 180 0 0 {name=l_bit_rst5 lab=rst_n_int}
C {lab_wire.sym} -250 200 0 0 {name=l_bit_clk5 lab=comp_done}
C {lab_wire.sym} 50 140 2 0 {name=l_bit_out5 lab=dout[5]}
C {xschem/sar_adc/bit_reg.sym} -100 280 0 0 {name=x_bit6}
C {lab_wire.sym} -250 250 0 0 {name=l_bit_co6 lab=out_p}
C {lab_wire.sym} -250 270 0 0 {name=l_bit_en6 lab=Q6}
C {lab_wire.sym} -250 290 0 0 {name=l_bit_rst6 lab=rst_n_int}
C {lab_wire.sym} -250 310 0 0 {name=l_bit_clk6 lab=comp_done}
C {lab_wire.sym} 50 250 2 0 {name=l_bit_out6 lab=dout[6]}
C {xschem/sar_adc/bit_reg.sym} -100 390 0 0 {name=x_bit7}
C {lab_wire.sym} -250 360 0 0 {name=l_bit_co7 lab=out_p}
C {lab_wire.sym} -250 380 0 0 {name=l_bit_en7 lab=Q7}
C {lab_wire.sym} -250 400 0 0 {name=l_bit_rst7 lab=rst_n_int}
C {lab_wire.sym} -250 420 0 0 {name=l_bit_clk7 lab=comp_done}
C {lab_wire.sym} 50 360 2 0 {name=l_bit_out7 lab=dout[7]}
C {xschem/sar_adc/delay_line.sym} -1200 -40 0 0 {name=x_delay}
C {lab_wire.sym} -1350 -40 0 0 {name=l_del_in lab=comp_done}
C {lab_wire.sym} -1050 -40 2 0 {name=l_del_out lab=comp_done_delayed}
C {xschem/sar_adc/async_inverter.sym} -1200 30 0 0 {name=x_inv_cd}
C {lab_wire.sym} -1350 30 0 0 {name=l_cd_in lab=comp_done_delayed}
C {lab_wire.sym} -1050 30 2 0 {name=l_cd_out lab=comp_done_delayed_n}
C {xschem/sar_adc/async_inverter.sym} -1200 100 0 0 {name=x_inv_st}
C {lab_wire.sym} -1350 100 0 0 {name=l_st_in lab=start}
C {lab_wire.sym} -1050 100 2 0 {name=l_st_out lab=start_n}
C {xschem/sar_adc/async_inverter.sym} -1200 170 0 0 {name=x_inv_dn}
C {lab_wire.sym} -1350 170 0 0 {name=l_dn_in lab=done}
C {lab_wire.sym} -1050 170 2 0 {name=l_dn_out lab=done_n}
C {xschem/sar_adc/async_nand3.sym} -600 300 0 0 {name=x_nand3_clk}
C {lab_wire.sym} -750 280 0 0 {name=l_n3_c lab=comp_done_delayed_n}
C {lab_wire.sym} -750 300 0 0 {name=l_n3_a lab=start_n}
C {lab_wire.sym} -750 320 0 0 {name=l_n3_b lab=done_n}
C {lab_wire.sym} -450 280 2 0 {name=l_n3_out lab=nand_out}
C {xschem/sar_adc/async_inverter.sym} -1200 240 0 0 {name=x_inv_out}
C {lab_wire.sym} -1350 240 0 0 {name=l_io_in lab=nand_out}
C {lab_wire.sym} -1050 240 2 0 {name=l_io_out lab=rst_latch}
C {xschem/sar_adc/async_inverter.sym} 360 -400 0 0 {name=x_inv_dout0}
C {lab_wire.sym} 210 -400 0 0 {name=l_inv_di0 lab=dout[0]}
C {lab_wire.sym} 510 -400 2 0 {name=l_inv_do0 lab=dout_n0}
C {xschem/sar_adc/async_inverter.sym} 360 -350 0 0 {name=x_inv_q0}
C {lab_wire.sym} 210 -350 0 0 {name=l_inv_qi0 lab=Q0}
C {lab_wire.sym} 510 -350 2 0 {name=l_inv_qo0 lab=Q_n0}
C {xschem/sar_adc/async_nand2.sym} 840 -365 0 0 {name=x_nand_dac0}
C {lab_wire.sym} 690 -375 0 0 {name=l_nd_a0 lab=dout_n0}
C {lab_wire.sym} 690 -355 0 0 {name=l_nd_b0 lab=Q_n0}
C {lab_wire.sym} 990 -375 2 0 {name=l_nd_out0 lab=dac_in[0]}
C {xschem/sar_adc/async_inverter.sym} 360 -290 0 0 {name=x_inv_dout1}
C {lab_wire.sym} 210 -290 0 0 {name=l_inv_di1 lab=dout[1]}
C {lab_wire.sym} 510 -290 2 0 {name=l_inv_do1 lab=dout_n1}
C {xschem/sar_adc/async_inverter.sym} 360 -240 0 0 {name=x_inv_q1}
C {lab_wire.sym} 210 -240 0 0 {name=l_inv_qi1 lab=Q1}
C {lab_wire.sym} 510 -240 2 0 {name=l_inv_qo1 lab=Q_n1}
C {xschem/sar_adc/async_nand2.sym} 840 -255 0 0 {name=x_nand_dac1}
C {lab_wire.sym} 690 -265 0 0 {name=l_nd_a1 lab=dout_n1}
C {lab_wire.sym} 690 -245 0 0 {name=l_nd_b1 lab=Q_n1}
C {lab_wire.sym} 990 -265 2 0 {name=l_nd_out1 lab=dac_in[1]}
C {xschem/sar_adc/async_inverter.sym} 360 -180 0 0 {name=x_inv_dout2}
C {lab_wire.sym} 210 -180 0 0 {name=l_inv_di2 lab=dout[2]}
C {lab_wire.sym} 510 -180 2 0 {name=l_inv_do2 lab=dout_n2}
C {xschem/sar_adc/async_inverter.sym} 360 -130 0 0 {name=x_inv_q2}
C {lab_wire.sym} 210 -130 0 0 {name=l_inv_qi2 lab=Q2}
C {lab_wire.sym} 510 -130 2 0 {name=l_inv_qo2 lab=Q_n2}
C {xschem/sar_adc/async_nand2.sym} 840 -145 0 0 {name=x_nand_dac2}
C {lab_wire.sym} 690 -155 0 0 {name=l_nd_a2 lab=dout_n2}
C {lab_wire.sym} 690 -135 0 0 {name=l_nd_b2 lab=Q_n2}
C {lab_wire.sym} 990 -155 2 0 {name=l_nd_out2 lab=dac_in[2]}
C {xschem/sar_adc/async_inverter.sym} 360 -70 0 0 {name=x_inv_dout3}
C {lab_wire.sym} 210 -70 0 0 {name=l_inv_di3 lab=dout[3]}
C {lab_wire.sym} 510 -70 2 0 {name=l_inv_do3 lab=dout_n3}
C {xschem/sar_adc/async_inverter.sym} 360 -20 0 0 {name=x_inv_q3}
C {lab_wire.sym} 210 -20 0 0 {name=l_inv_qi3 lab=Q3}
C {lab_wire.sym} 510 -20 2 0 {name=l_inv_qo3 lab=Q_n3}
C {xschem/sar_adc/async_nand2.sym} 840 -35 0 0 {name=x_nand_dac3}
C {lab_wire.sym} 690 -45 0 0 {name=l_nd_a3 lab=dout_n3}
C {lab_wire.sym} 690 -25 0 0 {name=l_nd_b3 lab=Q_n3}
C {lab_wire.sym} 990 -45 2 0 {name=l_nd_out3 lab=dac_in[3]}
C {xschem/sar_adc/async_inverter.sym} 360 40 0 0 {name=x_inv_dout4}
C {lab_wire.sym} 210 40 0 0 {name=l_inv_di4 lab=dout[4]}
C {lab_wire.sym} 510 40 2 0 {name=l_inv_do4 lab=dout_n4}
C {xschem/sar_adc/async_inverter.sym} 360 90 0 0 {name=x_inv_q4}
C {lab_wire.sym} 210 90 0 0 {name=l_inv_qi4 lab=Q4}
C {lab_wire.sym} 510 90 2 0 {name=l_inv_qo4 lab=Q_n4}
C {xschem/sar_adc/async_nand2.sym} 840 75 0 0 {name=x_nand_dac4}
C {lab_wire.sym} 690 65 0 0 {name=l_nd_a4 lab=dout_n4}
C {lab_wire.sym} 690 85 0 0 {name=l_nd_b4 lab=Q_n4}
C {lab_wire.sym} 990 65 2 0 {name=l_nd_out4 lab=dac_in[4]}
C {xschem/sar_adc/async_inverter.sym} 360 150 0 0 {name=x_inv_dout5}
C {lab_wire.sym} 210 150 0 0 {name=l_inv_di5 lab=dout[5]}
C {lab_wire.sym} 510 150 2 0 {name=l_inv_do5 lab=dout_n5}
C {xschem/sar_adc/async_inverter.sym} 360 200 0 0 {name=x_inv_q5}
C {lab_wire.sym} 210 200 0 0 {name=l_inv_qi5 lab=Q5}
C {lab_wire.sym} 510 200 2 0 {name=l_inv_qo5 lab=Q_n5}
C {xschem/sar_adc/async_nand2.sym} 840 185 0 0 {name=x_nand_dac5}
C {lab_wire.sym} 690 175 0 0 {name=l_nd_a5 lab=dout_n5}
C {lab_wire.sym} 690 195 0 0 {name=l_nd_b5 lab=Q_n5}
C {lab_wire.sym} 990 175 2 0 {name=l_nd_out5 lab=dac_in[5]}
C {xschem/sar_adc/async_inverter.sym} 360 260 0 0 {name=x_inv_dout6}
C {lab_wire.sym} 210 260 0 0 {name=l_inv_di6 lab=dout[6]}
C {lab_wire.sym} 510 260 2 0 {name=l_inv_do6 lab=dout_n6}
C {xschem/sar_adc/async_inverter.sym} 360 310 0 0 {name=x_inv_q6}
C {lab_wire.sym} 210 310 0 0 {name=l_inv_qi6 lab=Q6}
C {lab_wire.sym} 510 310 2 0 {name=l_inv_qo6 lab=Q_n6}
C {xschem/sar_adc/async_nand2.sym} 840 295 0 0 {name=x_nand_dac6}
C {lab_wire.sym} 690 285 0 0 {name=l_nd_a6 lab=dout_n6}
C {lab_wire.sym} 690 305 0 0 {name=l_nd_b6 lab=Q_n6}
C {lab_wire.sym} 990 285 2 0 {name=l_nd_out6 lab=dac_in[6]}
C {xschem/sar_adc/async_inverter.sym} 360 370 0 0 {name=x_inv_dout7}
C {lab_wire.sym} 210 370 0 0 {name=l_inv_di7 lab=dout[7]}
C {lab_wire.sym} 510 370 2 0 {name=l_inv_do7 lab=dout_n7}
C {xschem/sar_adc/async_inverter.sym} 360 420 0 0 {name=x_inv_q7}
C {lab_wire.sym} 210 420 0 0 {name=l_inv_qi7 lab=Q7}
C {lab_wire.sym} 510 420 2 0 {name=l_inv_qo7 lab=Q_n7}
C {xschem/sar_adc/async_nand2.sym} 840 405 0 0 {name=x_nand_dac7}
C {lab_wire.sym} 690 395 0 0 {name=l_nd_a7 lab=dout_n7}
C {lab_wire.sym} 690 415 0 0 {name=l_nd_b7 lab=Q_n7}
C {lab_wire.sym} 990 395 2 0 {name=l_nd_out7 lab=dac_in[7]}
