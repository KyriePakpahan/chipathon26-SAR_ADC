v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 540 -377.5 540 -347.5 {lab=VDD}
N 540 -287.5 540 -257.5 {lab=GND}
N 690 -287.5 690 -257.5 {lab=GND}
N 690 -387.5 690 -347.5 {lab=in}
N 690 -387.5 790 -387.5 {lab=in}
N 835 -342.5 835 -312.5 {lab=GND}
N 835 -467.5 835 -440 {lab=VDD}
N 907.5 -390 947.5 -390 {lab=out}
C {title.sym} 170 -50 0 0 {name=l1 author="Afdhal Razaq"}
C {vsource.sym} 540 -317.5 0 0 {name=V1 value=3.3 savecurrent=false}
C {vsource.sym} 690 -317.5 0 0 {name=VIN value=3.3 savecurrent=false}
C {vdd.sym} 540 -377.5 0 0 {name=l2 lab=VDD}
C {vdd.sym} 835 -467.5 0 0 {name=l3 lab=VDD}
C {gnd.sym} 540 -257.5 0 0 {name=l4 lab=GND}
C {gnd.sym} 690 -257.5 0 0 {name=l5 lab=GND}
C {gnd.sym} 835 -312.5 0 0 {name=l6 lab=GND}
C {noconn.sym} 947.5 -390 2 0 {name=l7}
C {lab_wire.sym} 725 -387.5 0 0 {name=p1 sig_type=std_logic lab=in}
C {lab_wire.sym} 935 -390 0 0 {name=p2 sig_type=std_logic lab=out
}
C {devices/code_shown.sym} 0 -155 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value="
.include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
"}
C {devices/code_shown.sym} 0 -905 0 0 {name=NGSPICE only_toplevel=true
value="


.control
save all
** Define input signal
let fsig = 1k
let tper = 1/fsig
let tfr = 0.01*tper
let ton = 0.5*tper-2*tfr

** Define transien params
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

setplot tran1
let vout = v(out)
let vin = v(in)
let ivdd = -v1#branch*1e4
plot vout vin ivdd

setplot op1
write tb_comp_inv_3v3.raw
.endc
"}
C {launcher.sym} 517.5 -170 0 0 {name=h1
descr="Annotate OP"
tclcommand="set show_hidden_texts 1; xschem annotate_op"}
C {sar_adc/blocks/comparator/comp_inv_3v3.sym} 790 -440 0 0 {name=x1}
