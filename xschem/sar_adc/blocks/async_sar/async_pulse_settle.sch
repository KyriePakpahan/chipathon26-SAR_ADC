v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
C {ipin.sym} -800 -120 0 0 {name=p_in lab=in}
C {iopin.sym} -800 -80 0 0 {name=p_vdd lab=vdd}
C {iopin.sym} -800 -40 0 0 {name=p_vss lab=vss}
C {opin.sym} 800 0 0 0 {name=p_out lab=out}
C {sar_adc/blocks/async_sar/async_inverter.sym} -450 -120 0 0 {name=x_inv}
C {lab_wire.sym} -600 -140 0 0 {name=l_inv_in lab=in}
C {lab_wire.sym} -300 -140 2 0 {name=l_inv_vdd lab=vdd}
C {lab_wire.sym} -300 -120 2 0 {name=l_inv_out lab=in_inv}
C {lab_wire.sym} -300 -100 2 0 {name=l_inv_vss lab=vss}
C {sar_adc/blocks/async_sar/async_delay_chain.sym} -450 60 0 0 {name=x_del}
C {lab_wire.sym} -600 40 0 0 {name=l_del_in lab=in}
C {lab_wire.sym} -300 40 2 0 {name=l_del_vdd lab=vdd}
C {lab_wire.sym} -300 60 2 0 {name=l_del_out lab=in_del_n}
C {lab_wire.sym} -300 80 2 0 {name=l_del_vss lab=vss}
C {sar_adc/blocks/async_sar/async_nand2.sym} 150 0 0 0 {name=x_nand}
C {lab_wire.sym} 0 -20 0 0 {name=l_nd_a lab=in_inv}
C {lab_wire.sym} 0 0 0 0 {name=l_nd_b lab=in_del_n}
C {lab_wire.sym} 300 -20 2 0 {name=l_nd_vdd lab=vdd}
C {lab_wire.sym} 300 0 2 0 {name=l_nd_out lab=out}
C {lab_wire.sym} 300 20 2 0 {name=l_nd_vss lab=vss}
C {title.sym} 0 250 0 0 {name=l_title author="Berkah Saluyu"}
