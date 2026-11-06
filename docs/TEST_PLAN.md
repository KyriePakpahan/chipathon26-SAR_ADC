# Silicon Bring-Up and Test Plan: 8-Bit Asynchronous SAR ADC (`sar_adc_top`)

## 1. Slot, Database, and Pad-Ring Summary

| Field | Value |
| :--- | :--- |
| Project Title | 8-bit Asynchronous SAR ADC |
| Team | A49 Berkah Saluyu (Institut Teknologi Bandung) |
| Slot / Variant | `A49 / BV` (`A49_BV` padframe segment) |
| Technology | GlobalFoundries GF180MCU Variant D (180 nm, 3.3 V CMOS, 5LM, MIM-B 2.0 fF/µm²) |
| Project Tile Area | `605 µm × 1110 µm` (`PR_bndry` layer `0/0` rectangle at `(0, 0)` to `(605, 1110)`) |
| Final Handoff GDS | [`layout/sar_adc/sar_adc_top.gds`](../layout/sar_adc/sar_adc_top.gds) (top cell `sar_adc_top`) |
| Final GDS SHA-256 | `65a3fc540f6d61cff200960ef1d2098b872fb05319da3ef66eb130f4c018491e` |
| CDL Netlist | [`cdl/sar_adc_top.spice`](../cdl/sar_adc_top.spice) |

### Pin Plan (`info.yaml` Order)

The design uses 14 pads across the West (`W12–W22`) and North (`N01–N03`) edges of the `A49_BV` slot.

| Pad | Pin Name | `info.yaml` `io_type` | Pad Cell (`gf180mcu_fd_io`) | Hard-Wired On-Chip Pad Tie-Offs | Function |
| :---: | :--- | :--- | :--- | :--- | :--- |
| `W12` | `vss` | `ground` | `gf180mcu_fd_io__dvss` | Connected to internal M1/M2/M3 ground ring | 0 V ground return |
| `W13` | `vdd` | `power` | `gf180mcu_fd_io__dvdd` | Connected to internal M1/M2/M3 supply ring | 3.3 V supply (analog core, digital logic, and I/O segment) |
| `W14` | `start` | `input_schmitt` | `gf180mcu_fd_io__in_s` | `PU = 0`, `PD = 0` (tied to `vss`) | Active-high track/reset input; falling edge starts conversion |
| `W15` | `done` | `bidirectional` | `gf180mcu_fd_io__bi_t` | `OE = 1`, `IE = 0`, `PDRV = 11` (16 mA), `SL = 0` (fast), `CS = 0`, `PU = 0`, `PD = 0` | Active-high conversion-complete output flag |
| `W16–W22` | `dout[0:6]` | `bidirectional` | `gf180mcu_fd_io__bi_t` | `OE = 1`, `IE = 0`, `PDRV = 11` (16 mA), `SL = 0` (fast), `CS = 0`, `PU = 0`, `PD = 0` | Digital output bits 0 to 6 (`dout[0]` = LSB) |
| `N01` | `dout[7]` | `bidirectional` | `gf180mcu_fd_io__bi_t` | `OE = 1`, `IE = 0`, `PDRV = 11` (16 mA), `SL = 0` (fast), `CS = 0`, `PU = 0`, `PD = 0` | Digital output bit 7 (`dout[7]` = MSB) |
| `N02` | `vref` | `analog` | `gf180mcu_fd_io__asig_5p0` | Direct analog path (`ASIG5V`) + on-chip MIM decoupling (`dec_vref`) | CDAC positive reference voltage (3.3 V nominal) |
| `N03` | `vin` | `analog` | `gf180mcu_fd_io__asig_5p0` | Direct analog path (`ASIG5V`) to bootstrapped S/H switch | Single-ended analog input voltage |

### Pad-Ring Supply Isolation and Internal Nets

- Pad-ring power domain: In the `A49_BV` wrapper, `BRK_BEFORE` and `BRK_AFTER` break cells isolate the project pad-ring segment from adjacent slots. Pad `W13` (`vdd`, `gf180mcu_fd_io__dvdd`) and pad `W12` (`vss`, `gf180mcu_fd_io__dvss`) supply both the internal core rings and the 12 signal pads (`W14–W22`, `N01–N03`).
- Input pull configuration: Because `start_PU` and `start_PD` are hard-tied to `vss`, pad `W14` (`start`) has no internal pull-up or pull-down resistor. The bench setup must actively drive `start` with a 3.3 V CMOS source or terminate it with a 10 kΩ external pull-down resistor on the carrier PCB.
- Internal nets not brought out to pads: The layout contains internal probe labels (`vhold`, `vdac`, `sample_en`, `comp_done`) used for LVS and post-layout parasitic extraction (PEX). These nets have no external bond pads and are not accessible during silicon testing.

---

## 2. Asynchronous Timing Protocol

The converter uses an internal self-timed domino loop and does not require an external bit clock. One conversion cycle consists of three phases controlled by `start` (`W14`) and `done` (`W15`):

1. Track and Reset Phase (`start = 3.3 V`):
   - `start` passes through two internal inverters (`x_inv_se1 -> x_inv_se2`) to assert `sample_en = 3.3 V` and close the bootstrapped sample-and-hold (S/H) switch (`C_hold = 380 fF`, extracted PEX tracking time constant $\tau = 166.1\text{ ps}$, $6.24\tau = 1.04\text{ ns}$).
   - At the same time, `rst_n_int = 0 V` clears the 8-bit shift register and SAR data registers, sets `dac_in[7:0] = 0`, and discharges the capacitive DAC (CDAC) top plate (`vdac = 0 V`).
   - Required `start` pulse width ($T_{\text{samp}}$): 15.0 ns nominal ($\ge 10\text{ ns}$ minimum) to propagate through the internal delay chain (`async_start_delay`, 8.5 ns to 12.0 ns) and settle `C_hold` to within 0.0025 mV (14.5× margin below 0.5 LSB).
2. Asynchronous Conversion Phase (`start = 0 V`, triggered on the `start` falling edge):
   - The falling edge of `start` opens the S/H switch, releases internal reset, and starts the StrongARM comparator (`strongarm_comp`) for MSB (`dout[7]`) evaluation.
   - Each comparator completion pulse (`comp_done`) advances the shift register from `dout[7]` down to `dout[0]`.
   - Post-layout PEX conversion time ($t_{\text{conv}}$, measured from the 50% falling edge of `start` to the 50% rising edge of `done` on the `605 µm × 1110 µm` layout): 53.63 ns to 58.30 ns (55.06 ns mean across 32 continuous cycles at 3.3 V).
3. Data Readout Phase (`done = 3.3 V`):
   - When the LSB (`Q7`) latches, the internal gate `NAND(Q7, comp_done) -> INV` drives `done` to 3.3 V.
   - Output bus `dout[7:0]` is valid on the rising edge of `done` and remains latched until the next rising edge of `start`.

```text
          |<-- Tsamp = 15 ns -->|<------------ Thold = 85 ns (at 10 MS/s) ------------>|
          +---------------------+                                                      +---
start     |  Track & Reset      |                  Conversion Phase                    |
      ----+                     +------------------------------------------------------+
                                |<--- t_conv = 53.6..58.3 ns --->|
                                                                 +---------------------+
done                            |                                |   Data Valid        |
      --------------------------+--------------------------------+                     +---
                                                                 |====== dout[7:0] ====|
```

---

## 3. Bench Stimulus, Off-Chip Filtering, and Output Load

1. Power Supply (`vdd` at `W13`, `vss` at `W12`):
   - Apply a regulated 3.30 V DC supply with the current limit set to 20 mA during initial bring-up.
   - Place a 100 nF NP0/C0G (0402) capacitor in parallel with a 10 µF X5R ceramic capacitor within 3 mm of pins `W13` and `W12`.
2. Reference Voltage (`vref` at `N02`):
   - Apply a low-noise 3.30 V DC reference (for example, REF3033 or an OPA350 buffer) bypassed at pin `N02` with 100 nF NP0 + 10 µF X5R capacitors to supply dynamic CDAC reference current ($I_{\text{vref,avg}} \approx 0.35\text{ mA}$ at 10 MS/s).
3. Analog Input (`vin` at `N03`):
   - Calibrated linear input range: 0.85 V to 2.45 V ($1.60\text{ V}_{\text{pp}}$ centered at $V_{\text{cm}} = 1.65\text{ V}$; full-scale rail-to-rail span is 0 V to 3.3 V with $1\text{ LSB}_{3.3\text{V}} = 12.89\text{ mV}$).
   - Drive `vin` through a low-distortion op-amp buffer followed by a passive RC anti-kickback filter ($R_s = 22\ \Omega\text{ to }50\ \Omega$, $C_{\text{shunt}} = 47\text{ pF to }100\text{ pF}$ NP0 to ground at pin `N03`) to absorb S/H charge injection.
4. Digital Stimulus (`start` at `W14`) and Output Load (`done` at `W15`, `dout[7:0]` at `W16–W22`, `N01`):
   - Drive `start` with a 3.3 V CMOS pulse ($V_{\text{IH}} = 3.3\text{ V}$, $V_{\text{IL}} = 0\text{ V}$, pulse width $T_{\text{samp}} = 15\text{ ns}$).
   - Because all 9 output pads are hard-wired to 16 mA fast slew (`PDRV = 11`, `SL = 0`) and share the single `vdd`/`vss` pad pair with the analog core, place $47\ \Omega\text{ to }100\ \Omega$ series damping resistors at pins `W15–W22` and `N01` and keep probe/FPGA input capacitance $\le 10\text{ pF}$ per pin.

---

## 4. Required Test Equipment

All measurements use standard benchtop instruments at the Institut Teknologi Bandung (ITB) IC characterization laboratory:

- Dual-channel linear DC power supply (3.30 V for `vdd` and `vref`, with mA current measurement).
- 6.5-digit digital multimeter (DMM) for continuity, ESD diode verification, and static/active current measurement ($I_{\text{VDD}}$, $I_{\text{VREF}}$).
- Low-distortion arbitrary waveform / function generator (0.85 V to 2.45 V sine and ramp source, 100 kHz to 5 MHz) with passive bandpass filters.
- FPGA or high-speed microcontroller capture board to generate the `start` pulse ($f_s = 1\text{ MS/s}, 2.5\text{ MS/s}, 5\text{ MS/s}, 10\text{ MS/s}$) and latch `dout[7:0]` on the rising edge of `done`.
- 4-channel mixed-signal oscilloscope ($\ge 100\text{ MHz}$ bandwidth) to probe `start`, `done`, `vin`, and `dout[7]`.

---

## 5. Measurement Procedure and Pass Criteria

The reference values below come from post-layout parasitic-extracted (PEX) SPICE simulations in `ngspice-42` on the `605 µm × 1110 µm` layout (`layout/sar_adc/sar_adc_top.gds` and `lvs/reports/magic_ext_sar_adc_top/sar_adc_top.ext`).

| Step | Test | Stimulus and Condition | Measurement Method | Post-Layout PEX Reference | Silicon Pass Criterion |
| :---: | :--- | :--- | :--- | :---: | :---: |
| T0 | Continuity and ESD Diode Check | Unpowered chip; DMM in diode mode | Measure forward voltage from `vss` to each pad and from each pad to `vdd` | Valid ESD diode path on all 14 pads | No `vdd`-to-`vss` short; forward diode drop 0.45 V to 0.85 V on all pads |
| T1 | Power-Up and Static Current | `vdd = 3.30 V`, `vref = 3.30 V` (20 mA limit), `start = 0 V` | Measure quiescent $I_{\text{VDD,static}}$ with DMM | $< 10\ \mu\text{A}$ | No latch-up; $I_{\text{VDD,static}} < 100\ \mu\text{A}$ |
| T2 | DC Point Check and Handshake Timing | $f_s = 1\text{ MS/s}$ ($T_{\text{samp}} = 15\text{ ns}$); DC `vin` = 0.85 V, 1.65 V, 2.45 V | Measure `start`-to-`done` delay on oscilloscope; capture `dout[7:0]` at `done` rising edge | $t_{\text{conv}} = 55.06\text{ ns}$ mean (53.63 ns to 58.30 ns); output codes 66, 130, 191 | `done` asserts every cycle ($t_{\text{conv}} < 80\text{ ns}$); output codes monotonic within $\pm 6\text{ LSB}$ of reference |
| T3 | Static Linearity (DNL and INL) | 161-point DC sweep or slow linear ramp from 0.85 V to 2.45 V (10 mV step) at $f_s = 1\text{ MS/s to }10\text{ MS/s}$ | Compute endpoint and best-fit DNL/INL from code histogram | Monotonic across all 161 points; RMS DNL 0.35 LSB to 0.55 LSB; RMS INL 0.49 LSB to 0.59 LSB | Monotonic transfer curve with no missing codes across active window; RMS $\text{DNL} < 1.0\text{ LSB}$ |
| T4 | Dynamic Coherent FFT | Coherent sine wave ($V_{\text{cm}} = 1.65\text{ V}$, $A = 0.75\text{ V}$, $f_{\text{in}} = 2.1875\text{ MHz}$) at $f_s = 10\text{ MS/s}$ ($M/N = 7/32$) | Capture $N = 32\text{ to }1024$ coherent samples on `done` rising edge; run FFT | ENOB = 7.92 bits (raw 6.78 bits), SNDR = 49.44 dBFS (raw 42.59 dB), SFDR = 50.13 dBc, THD = -47.90 dBc | Calibrated ENOB $\ge 7.0\text{ bits}$ (uncalibrated $\ge 6.5\text{ bits}$), SNDR $\ge 44.0\text{ dBFS}$, SFDR $\ge 46.0\text{ dBc}$ |
| T5 | Sampling Rate Sweep | Sweep $f_s = 1, 2.5, 5, 10\text{ MS/s}$ with $T_{\text{samp}} = 15\text{ ns}$ | Record ENOB and conversion completion rate vs. $f_s$ | 0/32 stuck codes at 10 MS/s | Continuous conversion from 1 MS/s to 10 MS/s without missing `done` pulses |
| T6 | Active Power and Walden FoM | Continuous conversion at $f_s = 10\text{ MS/s}$, $V_{\text{DD}} = 3.30\text{ V}$ | Measure average $I_{\text{VDD}}$ and $I_{\text{VREF}}$; calculate $\text{FoM}_W = P / (2^{\text{ENOB}} \cdot f_s)$ | Core power 0.285 mW ($\text{FoM}_W = 117.7\text{ fJ/conv-step}$); total power with I/O 1.19 mW to 2.44 mW | Total active power within $\pm 35\%$ of PEX model; record power vs. $f_s$ |

---

## 6. Troubleshooting Fallbacks

- If `done` does not assert: Confirm that `start` reaches 3.3 V and remains high for at least 15 ns. Pulses narrower than 8 ns do not propagate through `async_start_delay`.
- If ground bounce from the 16 mA output drivers degrades ENOB at 10 MS/s: Reduce $f_s$ to 5 MS/s or 2.5 MS/s and increase the series damping resistors on `dout[7:0]` (`W16–W22`, `N01`) from $47\ \Omega$ to $100\ \Omega$.
