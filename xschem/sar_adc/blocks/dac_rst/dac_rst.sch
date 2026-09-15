v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
C {iopin.sym} -400 -60 0 0 {name=p_vdac lab=vdac}
C {ipin.sym} -400 -20 0 0 {name=p_se lab=sample_en}
C {iopin.sym} -400 20 0 0 {name=p_vss lab=vss}
C {symbols/nfet_03v3.sym} 0 0 0 0 {name=M1 L=0.28u W=24.00u nf=6 m=1 model=nfet_03v3 spiceprefix=X}
C {lab_wire.sym} -20 0 0 0 {name=l_g lab=sample_en}
C {lab_wire.sym} 20 -30 2 0 {name=l_d lab=vdac}
C {lab_wire.sym} 20 0 2 0 {name=l_b lab=vss}
C {lab_wire.sym} 20 30 0 0 {name=l_s lab=vss}
C {title.sym} -200 200 0 0 {name=l_title author="Berkah Saluyu"}
