v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 920 -360 920 -330 {lab=0}
N 820 -360 820 -330 {lab=0}
N 820 -470 820 -420 {lab=VDD}
N 920 -450 920 -420 {lab=in}
N 920 -450 1070 -450 {lab=in}
N 1170 -570 1170 -520 {lab=VDD}
N 1170 -380 1170 -340 {lab=0}
N 1270 -450 1330 -450 {lab=out}
C {title.sym} 160 -30 0 0 {name=l1 author="IIC-OSIC-TUTOR INV Tutorials"}
C {vsource.sym} 820 -390 0 0 {name=V1 value=3.3 savecurrent=false}
C {vsource.sym} 920 -390 0 0 {name=VIN value=3.3 savecurrent=false}
C {vdd.sym} 820 -470 0 0 {name=l2 lab=VDD}
C {vdd.sym} 1170 -570 0 0 {name=l3 lab=VDD}
C {gnd.sym} 820 -330 0 0 {name=l4 lab=0}
C {gnd.sym} 920 -330 0 0 {name=l5 lab=0}
C {gnd.sym} 1170 -340 0 0 {name=l6 lab=0}
C {noconn.sym} 1330 -450 2 0 {name=l7}
C {lab_wire.sym} 1000 -450 0 0 {name=p1 sig_type=std_logic lab=in}
C {devices/code_shown.sym} 10 -140 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value="
.include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
"}
C {devices/code_shown.sym} -10 -900 0 0 {name=NGSPICE only_toplevel=true
value="

.control
save all
** Define input signal
let fsig = 1k
let tper = 1/fsig
let tfr = 0.01*tper
let ton = 0.5*tper-2*tfr

** Define transient params
let tstop = 2*tper
let tstep = 0.001*tper

** Set Sources
alter @VIN[DC] = 0.0
alter @VIN[PULSE] = [ 0 3.3 0 $&tfr $&tfr $&ton $&tper 0 ]

** Simulations
op
dc vin 0 3.3 0.01
tran $&tstep $&tstop 

** Plots
setplot dc1
let vout = v(out)
plot vout

setplot trans1
let vout = v(out)
let vin = v(in)
let ivdd = -v1#branch*1e4
plot vout vin ivdd


setplot op1
write inv_sh_tb.raw
.endc
"}
C {lab_wire.sym} 1310 -450 0 0 {name=p2 sig_type=std_logic lab=out}
C {launcher.sym} 770 -180 0 0 {name=h1
descr="Annotate OP"
tclcommand="set show_hidden_texts 1; xschem annotate_op"}
C {sar_adc/blocks/sample_hold/inv_sh.sym} 1070 -520 0 0 {name=xinv1}
