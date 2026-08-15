v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
C {ipin.sym} -1600 -400 0 0 {name=p_in lab=in}
C {lab_wire.sym} -1550 -400 0 0 {name=l_in lab=in}
C {opin.sym} 1600 400 0 0 {name=p_out lab=out}
C {lab_wire.sym} 1550 400 2 0 {name=l_out lab=out}

# 45 inverters in series (in -> out, giving ~1.2ns delay)
# Row 1 (y = -300, 15 inverters: in -> net1 -> ... -> net15)
C {sar_adc/blocks/async_sar/async_inverter.sym} -1400 -300 0 0 {name=x1}
C {lab_wire.sym} -1550 -300 0 0 {name=l_x1_in lab=in}
C {lab_wire.sym} -1250 -300 2 0 {name=l_x1_out lab=net1}

C {sar_adc/blocks/async_sar/async_inverter.sym} -1200 -300 0 0 {name=x2}
C {lab_wire.sym} -1350 -300 0 0 {name=l_x2_in lab=net1}
C {lab_wire.sym} -1050 -300 2 0 {name=l_x2_out lab=net2}

C {sar_adc/blocks/async_sar/async_inverter.sym} -1000 -300 0 0 {name=x3}
C {lab_wire.sym} -1150 -300 0 0 {name=l_x3_in lab=net2}
C {lab_wire.sym} -850 -300 2 0 {name=l_x3_out lab=net3}

C {sar_adc/blocks/async_sar/async_inverter.sym} -800 -300 0 0 {name=x4}
C {lab_wire.sym} -950 -300 0 0 {name=l_x4_in lab=net3}
C {lab_wire.sym} -650 -300 2 0 {name=l_x4_out lab=net4}

C {sar_adc/blocks/async_sar/async_inverter.sym} -600 -300 0 0 {name=x5}
C {lab_wire.sym} -750 -300 0 0 {name=l_x5_in lab=net4}
C {lab_wire.sym} -450 -300 2 0 {name=l_x5_out lab=net5}

C {sar_adc/blocks/async_sar/async_inverter.sym} -400 -300 0 0 {name=x6}
C {lab_wire.sym} -550 -300 0 0 {name=l_x6_in lab=net5}
C {lab_wire.sym} -250 -300 2 0 {name=l_x6_out lab=net6}

C {sar_adc/blocks/async_sar/async_inverter.sym} -200 -300 0 0 {name=x7}
C {lab_wire.sym} -350 -300 0 0 {name=l_x7_in lab=net6}
C {lab_wire.sym} -50 -300 2 0 {name=l_x7_out lab=net7}

C {sar_adc/blocks/async_sar/async_inverter.sym} 0 -300 0 0 {name=x8}
C {lab_wire.sym} -150 -300 0 0 {name=l_x8_in lab=net7}
C {lab_wire.sym} 150 -300 2 0 {name=l_x8_out lab=net8}

C {sar_adc/blocks/async_sar/async_inverter.sym} 200 -300 0 0 {name=x9}
C {lab_wire.sym} 50 -300 0 0 {name=l_x9_in lab=net8}
C {lab_wire.sym} 350 -300 2 0 {name=l_x9_out lab=net9}

C {sar_adc/blocks/async_sar/async_inverter.sym} 400 -300 0 0 {name=x10}
C {lab_wire.sym} 250 -300 0 0 {name=l_x10_in lab=net9}
C {lab_wire.sym} 550 -300 2 0 {name=l_x10_out lab=net10}

C {sar_adc/blocks/async_sar/async_inverter.sym} 600 -300 0 0 {name=x11}
C {lab_wire.sym} 450 -300 0 0 {name=l_x11_in lab=net10}
C {lab_wire.sym} 750 -300 2 0 {name=l_x11_out lab=net11}

C {sar_adc/blocks/async_sar/async_inverter.sym} 800 -300 0 0 {name=x12}
C {lab_wire.sym} 650 -300 0 0 {name=l_x12_in lab=net11}
C {lab_wire.sym} 950 -300 2 0 {name=l_x12_out lab=net12}

C {sar_adc/blocks/async_sar/async_inverter.sym} 1000 -300 0 0 {name=x13}
C {lab_wire.sym} 850 -300 0 0 {name=l_x13_in lab=net12}
C {lab_wire.sym} 1150 -300 2 0 {name=l_x13_out lab=net13}

C {sar_adc/blocks/async_sar/async_inverter.sym} 1200 -300 0 0 {name=x14}
C {lab_wire.sym} 1050 -300 0 0 {name=l_x14_in lab=net13}
C {lab_wire.sym} 1350 -300 2 0 {name=l_x14_out lab=net14}

C {sar_adc/blocks/async_sar/async_inverter.sym} 1400 -300 0 0 {name=x15}
C {lab_wire.sym} 1250 -300 0 0 {name=l_x15_in lab=net14}
C {lab_wire.sym} 1550 -300 2 0 {name=l_x15_out lab=net15}

# Row 2 (y = 0, 15 inverters: net15 -> ... -> net30)
C {sar_adc/blocks/async_sar/async_inverter.sym} -1400 0 0 0 {name=x16}
C {lab_wire.sym} -1550 0 0 0 {name=l_x16_in lab=net15}
C {lab_wire.sym} -1250 0 2 0 {name=l_x16_out lab=net16}

C {sar_adc/blocks/async_sar/async_inverter.sym} -1200 0 0 0 {name=x17}
C {lab_wire.sym} -1350 0 0 0 {name=l_x17_in lab=net16}
C {lab_wire.sym} -1050 0 2 0 {name=l_x17_out lab=net17}

C {sar_adc/blocks/async_sar/async_inverter.sym} -1000 0 0 0 {name=x18}
C {lab_wire.sym} -1150 0 0 0 {name=l_x18_in lab=net17}
C {lab_wire.sym} -850 0 2 0 {name=l_x18_out lab=net18}

C {sar_adc/blocks/async_sar/async_inverter.sym} -800 0 0 0 {name=x19}
C {lab_wire.sym} -950 0 0 0 {name=l_x19_in lab=net18}
C {lab_wire.sym} -650 0 2 0 {name=l_x19_out lab=net19}

C {sar_adc/blocks/async_sar/async_inverter.sym} -600 0 0 0 {name=x20}
C {lab_wire.sym} -750 0 0 0 {name=l_x20_in lab=net19}
C {lab_wire.sym} -450 0 2 0 {name=l_x20_out lab=net20}

C {sar_adc/blocks/async_sar/async_inverter.sym} -400 0 0 0 {name=x21}
C {lab_wire.sym} -550 0 0 0 {name=l_x21_in lab=net20}
C {lab_wire.sym} -250 0 2 0 {name=l_x21_out lab=net21}

C {sar_adc/blocks/async_sar/async_inverter.sym} -200 0 0 0 {name=x22}
C {lab_wire.sym} -350 0 0 0 {name=l_x22_in lab=net21}
C {lab_wire.sym} -50 0 2 0 {name=l_x22_out lab=net22}

C {sar_adc/blocks/async_sar/async_inverter.sym} 0 0 0 0 {name=x23}
C {lab_wire.sym} -150 0 0 0 {name=l_x23_in lab=net22}
C {lab_wire.sym} 150 0 2 0 {name=l_x23_out lab=net23}

C {sar_adc/blocks/async_sar/async_inverter.sym} 200 0 0 0 {name=x24}
C {lab_wire.sym} 50 0 0 0 {name=l_x24_in lab=net23}
C {lab_wire.sym} 350 0 2 0 {name=l_x24_out lab=net24}

C {sar_adc/blocks/async_sar/async_inverter.sym} 400 0 0 0 {name=x25}
C {lab_wire.sym} 250 0 0 0 {name=l_x25_in lab=net24}
C {lab_wire.sym} 550 0 2 0 {name=l_x25_out lab=net25}

C {sar_adc/blocks/async_sar/async_inverter.sym} 600 0 0 0 {name=x26}
C {lab_wire.sym} 450 0 0 0 {name=l_x26_in lab=net25}
C {lab_wire.sym} 750 0 2 0 {name=l_x26_out lab=net26}

C {sar_adc/blocks/async_sar/async_inverter.sym} 800 0 0 0 {name=x27}
C {lab_wire.sym} 650 0 0 0 {name=l_x27_in lab=net26}
C {lab_wire.sym} 950 0 2 0 {name=l_x27_out lab=net27}

C {sar_adc/blocks/async_sar/async_inverter.sym} 1000 0 0 0 {name=x28}
C {lab_wire.sym} 850 0 0 0 {name=l_x28_in lab=net27}
C {lab_wire.sym} 1150 0 2 0 {name=l_x28_out lab=net28}

C {sar_adc/blocks/async_sar/async_inverter.sym} 1200 0 0 0 {name=x29}
C {lab_wire.sym} 1050 0 0 0 {name=l_x29_in lab=net28}
C {lab_wire.sym} 1350 0 2 0 {name=l_x29_out lab=net29}

C {sar_adc/blocks/async_sar/async_inverter.sym} 1400 0 0 0 {name=x30}
C {lab_wire.sym} 1250 0 0 0 {name=l_x30_in lab=net29}
C {lab_wire.sym} 1550 0 2 0 {name=l_x30_out lab=net30}

# Row 3 (y = 300, 15 inverters: net30 -> ... -> out)
C {sar_adc/blocks/async_sar/async_inverter.sym} -1400 300 0 0 {name=x31}
C {lab_wire.sym} -1550 300 0 0 {name=l_x31_in lab=net30}
C {lab_wire.sym} -1250 300 2 0 {name=l_x31_out lab=net31}

C {sar_adc/blocks/async_sar/async_inverter.sym} -1200 300 0 0 {name=x32}
C {lab_wire.sym} -1350 300 0 0 {name=l_x32_in lab=net31}
C {lab_wire.sym} -1050 300 2 0 {name=l_x32_out lab=net32}

C {sar_adc/blocks/async_sar/async_inverter.sym} -1000 300 0 0 {name=x33}
C {lab_wire.sym} -1150 300 0 0 {name=l_x33_in lab=net32}
C {lab_wire.sym} -850 300 2 0 {name=l_x33_out lab=net33}

C {sar_adc/blocks/async_sar/async_inverter.sym} -800 300 0 0 {name=x34}
C {lab_wire.sym} -950 300 0 0 {name=l_x34_in lab=net33}
C {lab_wire.sym} -650 300 2 0 {name=l_x34_out lab=net34}

C {sar_adc/blocks/async_sar/async_inverter.sym} -600 300 0 0 {name=x35}
C {lab_wire.sym} -750 300 0 0 {name=l_x35_in lab=net34}
C {lab_wire.sym} -450 300 2 0 {name=l_x35_out lab=net35}

C {sar_adc/blocks/async_sar/async_inverter.sym} -400 300 0 0 {name=x36}
C {lab_wire.sym} -550 300 0 0 {name=l_x36_in lab=net35}
C {lab_wire.sym} -250 300 2 0 {name=l_x36_out lab=net36}

C {sar_adc/blocks/async_sar/async_inverter.sym} -200 300 0 0 {name=x37}
C {lab_wire.sym} -350 300 0 0 {name=l_x37_in lab=net36}
C {lab_wire.sym} -50 300 2 0 {name=l_x37_out lab=net37}

C {sar_adc/blocks/async_sar/async_inverter.sym} 0 300 0 0 {name=x38}
C {lab_wire.sym} -150 300 0 0 {name=l_x38_in lab=net37}
C {lab_wire.sym} 150 300 2 0 {name=l_x38_out lab=net38}

C {sar_adc/blocks/async_sar/async_inverter.sym} 200 300 0 0 {name=x39}
C {lab_wire.sym} 50 300 0 0 {name=l_x39_in lab=net38}
C {lab_wire.sym} 350 300 2 0 {name=l_x39_out lab=net39}

C {sar_adc/blocks/async_sar/async_inverter.sym} 400 300 0 0 {name=x40}
C {lab_wire.sym} 250 300 0 0 {name=l_x40_in lab=net39}
C {lab_wire.sym} 550 300 2 0 {name=l_x40_out lab=net40}

C {sar_adc/blocks/async_sar/async_inverter.sym} 600 300 0 0 {name=x41}
C {lab_wire.sym} 450 300 0 0 {name=l_x41_in lab=net40}
C {lab_wire.sym} 750 300 2 0 {name=l_x41_out lab=net41}

C {sar_adc/blocks/async_sar/async_inverter.sym} 800 300 0 0 {name=x42}
C {lab_wire.sym} 650 300 0 0 {name=l_x42_in lab=net41}
C {lab_wire.sym} 950 300 2 0 {name=l_x42_out lab=net42}

C {sar_adc/blocks/async_sar/async_inverter.sym} 1000 300 0 0 {name=x43}
C {lab_wire.sym} 850 300 0 0 {name=l_x43_in lab=net42}
C {lab_wire.sym} 1150 300 2 0 {name=l_x43_out lab=net43}

C {sar_adc/blocks/async_sar/async_inverter.sym} 1200 300 0 0 {name=x44}
C {lab_wire.sym} 1050 300 0 0 {name=l_x44_in lab=net43}
C {lab_wire.sym} 1350 300 2 0 {name=l_x44_out lab=net44}

C {sar_adc/blocks/async_sar/async_inverter.sym} 1400 300 0 0 {name=x45}
C {lab_wire.sym} 1250 300 0 0 {name=l_x45_in lab=net44}
C {lab_wire.sym} 1550 300 2 0 {name=l_x45_out lab=out}

C {title.sym} 160 500 0 0 {name=l_title author="Berkah Saluyu"}
