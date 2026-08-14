v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
C {ipin.sym} -1600 -200 0 0 {name=p_in lab=in}
C {lab_wire.sym} -1550 -200 0 0 {name=l_in lab=in}
C {opin.sym} 1600 200 0 0 {name=p_out lab=out}
C {lab_wire.sym} 1550 200 2 0 {name=l_out lab=out}

# 21-Stage Robust Delay Chain (Spacing = 400)
# Row 1 (y = -100, 7 inverters)
C {sar_adc/blocks/async_sar/async_inverter.sym} -1200 -100 0 0 {name=x1}
C {lab_wire.sym} -1350 -100 0 0 {name=l_x1_in lab=in}
C {lab_wire.sym} -1050 -100 2 0 {name=l_x1_out lab=net1}

C {sar_adc/blocks/async_sar/async_inverter.sym} -800 -100 0 0 {name=x2}
C {lab_wire.sym} -950 -100 0 0 {name=l_x2_in lab=net1}
C {lab_wire.sym} -650 -100 2 0 {name=l_x2_out lab=net2}

C {sar_adc/blocks/async_sar/async_inverter.sym} -400 -100 0 0 {name=x3}
C {lab_wire.sym} -550 -100 0 0 {name=l_x3_in lab=net2}
C {lab_wire.sym} -250 -100 2 0 {name=l_x3_out lab=net3}

C {sar_adc/blocks/async_sar/async_inverter.sym} 0 -100 0 0 {name=x4}
C {lab_wire.sym} -150 -100 0 0 {name=l_x4_in lab=net3}
C {lab_wire.sym} 150 -100 2 0 {name=l_x4_out lab=net4}

C {sar_adc/blocks/async_sar/async_inverter.sym} 400 -100 0 0 {name=x5}
C {lab_wire.sym} 250 -100 0 0 {name=l_x5_in lab=net4}
C {lab_wire.sym} 550 -100 2 0 {name=l_x5_out lab=net5}

C {sar_adc/blocks/async_sar/async_inverter.sym} 800 -100 0 0 {name=x6}
C {lab_wire.sym} 650 -100 0 0 {name=l_x6_in lab=net5}
C {lab_wire.sym} 950 -100 2 0 {name=l_x6_out lab=net6}

C {sar_adc/blocks/async_sar/async_inverter.sym} 1200 -100 0 0 {name=x7}
C {lab_wire.sym} 1050 -100 0 0 {name=l_x7_in lab=net6}
C {lab_wire.sym} 1350 -100 2 0 {name=l_x7_out lab=net7}

# Row 2 (y = 50, 7 inverters)
C {sar_adc/blocks/async_sar/async_inverter.sym} -1200 50 0 0 {name=x8}
C {lab_wire.sym} -1350 50 0 0 {name=l_x8_in lab=net7}
C {lab_wire.sym} -1050 50 2 0 {name=l_x8_out lab=net8}

C {sar_adc/blocks/async_sar/async_inverter.sym} -800 50 0 0 {name=x9}
C {lab_wire.sym} -950 50 0 0 {name=l_x9_in lab=net8}
C {lab_wire.sym} -650 50 2 0 {name=l_x9_out lab=net9}

C {sar_adc/blocks/async_sar/async_inverter.sym} -400 50 0 0 {name=x10}
C {lab_wire.sym} -550 50 0 0 {name=l_x10_in lab=net9}
C {lab_wire.sym} -250 50 2 0 {name=l_x10_out lab=net10}

C {sar_adc/blocks/async_sar/async_inverter.sym} 0 50 0 0 {name=x11}
C {lab_wire.sym} -150 50 0 0 {name=l_x11_in lab=net10}
C {lab_wire.sym} 150 50 2 0 {name=l_x11_out lab=net11}

C {sar_adc/blocks/async_sar/async_inverter.sym} 400 50 0 0 {name=x12}
C {lab_wire.sym} 250 50 0 0 {name=l_x12_in lab=net11}
C {lab_wire.sym} 550 50 2 0 {name=l_x12_out lab=net12}

C {sar_adc/blocks/async_sar/async_inverter.sym} 800 50 0 0 {name=x13}
C {lab_wire.sym} 650 50 0 0 {name=l_x13_in lab=net12}
C {lab_wire.sym} 950 50 2 0 {name=l_x13_out lab=net13}

C {sar_adc/blocks/async_sar/async_inverter.sym} 1200 50 0 0 {name=x14}
C {lab_wire.sym} 1050 50 0 0 {name=l_x14_in lab=net13}
C {lab_wire.sym} 1350 50 2 0 {name=l_x14_out lab=net14}

# Row 3 (y = 200, 7 inverters)
C {sar_adc/blocks/async_sar/async_inverter.sym} -1200 200 0 0 {name=x15}
C {lab_wire.sym} -1350 200 0 0 {name=l_x15_in lab=net14}
C {lab_wire.sym} -1050 200 2 0 {name=l_x15_out lab=net15}

C {sar_adc/blocks/async_sar/async_inverter.sym} -800 200 0 0 {name=x16}
C {lab_wire.sym} -950 200 0 0 {name=l_x16_in lab=net15}
C {lab_wire.sym} -650 200 2 0 {name=l_x16_out lab=net16}

C {sar_adc/blocks/async_sar/async_inverter.sym} -400 200 0 0 {name=x17}
C {lab_wire.sym} -550 200 0 0 {name=l_x17_in lab=net16}
C {lab_wire.sym} -250 200 2 0 {name=l_x17_out lab=net17}

C {sar_adc/blocks/async_sar/async_inverter.sym} 0 200 0 0 {name=x18}
C {lab_wire.sym} -150 200 0 0 {name=l_x18_in lab=net17}
C {lab_wire.sym} 150 200 2 0 {name=l_x18_out lab=net18}

C {sar_adc/blocks/async_sar/async_inverter.sym} 400 200 0 0 {name=x19}
C {lab_wire.sym} 250 200 0 0 {name=l_x19_in lab=net18}
C {lab_wire.sym} 550 200 2 0 {name=l_x19_out lab=net19}

C {sar_adc/blocks/async_sar/async_inverter.sym} 800 200 0 0 {name=x20}
C {lab_wire.sym} 650 200 0 0 {name=l_x20_in lab=net19}
C {lab_wire.sym} 950 200 2 0 {name=l_x20_out lab=net20}

C {sar_adc/blocks/async_sar/async_inverter.sym} 1200 200 0 0 {name=x21}
C {lab_wire.sym} 1050 200 0 0 {name=l_x21_in lab=net20}
C {lab_wire.sym} 1350 200 2 0 {name=l_x21_out lab=out}

C {title.sym} 160 400 0 0 {name=l_title author="Berkah Saluyu"}
