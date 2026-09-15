v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
C {iopin.sym} -400 -40 0 0 {name=p_vr lab=vref}
C {iopin.sym} -400 0 0 0 {name=p_vs lab=vss}
C {symbols/cap_mim_2f0fF.sym} 0 0 0 0 {name=C1 W=10e-6 L=10e-6 model=cap_mim_2f0fF spiceprefix=X m=20}
C {lab_wire.sym} 0 -30 2 0 {name=l_top lab=vref}
C {lab_wire.sym} 0 30 0 0 {name=l_bot lab=vss}
C {title.sym} -200 200 0 0 {name=l_title author="Berkah Saluyu"}
