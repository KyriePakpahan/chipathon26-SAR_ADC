# Product Requirements Document — 8-bit Asynchronous SAR ADC

**Target Technology:** GlobalFoundries GF180MCU (180 nm CMOS, open-source PDK)
**Target Supply Voltage:** 3.3 V (single supply)

## Technology Adaptation Notes

This PRD consolidates literature-derived specifications for asynchronous SAR ADCs (originally spanning 28/45/90/180 nm nodes at 1 V–3 V supplies) into requirements for a single target: **GF180MCU at 3.3 V**. Two labels are used throughout:

- **Target (GF180MCU, 3.3 V)** — the requirement as it applies to this design. Where the source material has no data point at this node/voltage, this is marked *"Not specified in sources — flag for design decision."*
- **Literature reference** — the closest available data point(s) from prior-art sources, kept for sanity-checking and as a simulation starting point, not assumed to transfer directly (power scales ~V², area and matching scale with node).

Among the source designs, **Gaikwad (180 nm, 3 V)** is the closest electrical/node match to GF180MCU at 3.3 V. **Bekal (180 nm)** and **Xiong (180 nm, 1.2 V/1.8 V)** are same-node but different-supply references.

---

## 1. Overview & Purpose

- Ultra-low-power, moderate-resolution ADC with a scalable data rate.
- Target applications:
  - Low-energy ISM-band radios (e.g., low-energy Bluetooth, IEEE 802.15.6 body-area networks).
  - Wireless medical/physiological sensors (e.g., ECG, wireless body sensor nodes).
  - Compute-in-memory cores for AI applications.
  - Subsampling of wideband RF signals.
  - Low-cost battery-powered portable tools, industrial commands, data acquisition.

## 2. Key Specifications

**Resolution:** 8-bit.

**Architecture:** Asynchronous Successive Approximation Register (SAR) ADC.
- Eliminates the need for an external, power-hungry high-speed master clock by using dynamic asynchronous logic triggered sequentially like dominoes.
- Self-synchronization/handshake loop: each state transition tests specific conditions — the comparator triggers only after the DAC output has settled, and the comparison result is stored before initiating the next bit-cycle.
- Ready-signal generation: dynamic comparator outputs (`OUTP`/`OUTN`) are pre-charged low; when a decision resolves, one output goes high and a NOR (or XOR) gate detects the transition to generate a ready-indication signal that triggers the digital control logic.
- Optional multi-bit-per-cycle mode (Xiong-style, 2 bits/cycle using three comparators and an asynchronous clock generator) — worth evaluating for GF180MCU as a speed/power trade-off, not yet a committed requirement.

**Sampling Rate / Conversion Time**
- Target (GF180MCU, 3.3 V): 20 - 50 MS/s.
- Literature reference: Gaikwad (180 nm, 3 V) — 330 MS/s, 2.7 ns clock pulse (upper-bound feasibility reference for this node family). Harpe (90 nm, 1 V) — scalable 1 kS/s–10.24 MS/s concept (different node; architecture concept only, numbers not transferable).

**Supply Voltage**
- Target: 3.3 V single supply (per requirement).
- Literature reference range across cited designs: 1 V / 1.05 V / 1.2 V+1.8 V (dual) / 3 V — none exactly at 3.3 V; Gaikwad's 3 V design is closest.

**Process Node / Technology**
- Target: GF180MCU, 180 nm CMOS.
- Literature 180 nm references: Bekal, Xiong (1.2 V/1.8 V), Gaikwad (3 V). 45 nm/90 nm/28 nm entries below are cross-node reference only.

**Power Budget**
- Target: < 1 mW.
- Literature reference (cross-node/voltage, NOT directly transferable):
  - Active: 26.3 µW @ 10.24 MS/s (90 nm, 1 V) · 32.419–32.45 µW (180 nm, voltage not stated — Bekal) · 49.124 µW @ 20 MS/s (45 nm, 1 V) · 2.07 mW @ 65 MS/s (180 nm, 1.2 V/1.8 V — Xiong).
  - Standby: 6 nW @ VDD = 1 V (90 nm).

**Input Range and Type**
- Target: Not specified in sources for 3.3 V — flag for design decision.
- Literature reference: differential, peak-to-peak input 0.83 V (90 nm, 1 V) / 1.2 V (45 nm, 1 V) / 1.6 V (28 nm, 1.05 V). Single-ended: not specified (Bekal simulation used a 200 mV DC input only).

## 3. Functional Requirements

1. **Analog Input Sampling** — sample the input voltage on the top plates of the capacitive array using bootstrapped switches (for linearity) or complementary switches.
2. **Asynchronous Successive Approximation** — execute an 8-bit binary-search algorithm sequentially via a feedback loop and charge-redistribution DAC, without a global oversampled clock.
3. **Dynamic Reference Comparison** — perform regenerative voltage comparisons using a low-power dynamic comparator with no static bias current.
4. **Self-Triggered Handshake** — generate an internal `Ready`/`VALID` signal upon comparator resolution to drive the asynchronous control logic and advance to the next bit cycle.
5. **DAC Code Storage** — save comparator decisions in temporary digital registers (code register/bit caches) at each approximation phase.
6. **EOC Generation** — generate an active-high or active-low End-of-Conversion signal once all 8 bits are resolved.
7. **Standby Mode Control** — automatically disable the internal clock after conversion, holding the ADC in a low-leakage standby state so power scales linearly with sampling frequency.
8. **Radix Compensation / Subranged Decoders** — support switching decoders that control the capacitor array per binary weights or subranged multi-bit voltage references.

## 4. Non-Functional / Performance Requirements

| Metric | Target (GF180MCU, 3.3 V) | Literature reference (cross-node/voltage) |
|---|---|---|
| INL | < 1.0 LSB | 0.73–0.9 LSB (90 nm) · < 1 LSB (180 nm, Bekal) |
| DNL | < 1.0 LSB | 0.84–0.9 LSB (90 nm) · < 1 LSB (180 nm, Bekal) |
| ENOB | > 7.5 bit | 7.77 bit (90 nm) · 7.53 bit (180 nm, Bekal) · 7.35 bit @ 20 MS/s (45 nm) · 7.2 bit post-layout (180 nm, Xiong) |
| SNR | > 48.0 dB | 46 dB (45 nm) · ~65 dB implied (90 nm) |
| SNDR | > 47.0 dB | 46.7 dB (90 nm) · 46.0 dB SINAD (45 nm) · 45.16 dB near Nyquist (180 nm, Xiong) |
| THD | < -50.0 dB | Not directly given; SFDR reported instead: 61.8 dB (90 nm) · 57.29 dB (180 nm, Xiong) |
| Latency | < 100 ns (1 clock cycle) | Not explicitly quantified in sources (set by internal delay-cap charging) |
| Area | < 0.05 mm² | 228×240 µm (core 90×228 µm) (90 nm) · 0.045 mm² / 280×160 µm² (180 nm, Xiong) |
| Power (active/standby) | < 1 mW | See Power Budget above |

## 5. Interfaces

**Analog Input**
- Fully differential `INP`/`INN` (`VIP`/`VIN`) — one source (Bekal) used single-ended `Vin` for simulation only.
- Common-mode input level — Target: not specified in sources for 3.3 V; by common SAR-ADC convention this is typically VDD/2 (≈1.65 V for 3.3 V), to be confirmed during design. Literature reference: 0.5 V reported at ~1 V-supply designs (consistent with the same VDD/2 convention there).

**Digital Output**
- 8-bit parallel output: `D7`–`D0` (or `O7`–`O0`).
- Status output: `EOC` / `Conversion RDY`, asserted when output data is valid.

**Clock / Control / Calibration**
- `External CLK` / `Sample CLK` — defines the sampling interval.
- `Reset` / `External Trigger` — initializes shift registers and code registers.
- Reference inputs: `VREFP` (high reference — target: VDD = 3.3 V) and `VREFN` (target: GND).
- Calibration controls: not specified in sources — flag for design decision.

## 6. Design Constraints & Assumptions

- **GF180MCU device selection (new, target-specific):** GF180MCU offers 3.3 V/5 V-tolerant I/O devices alongside 1.8 V core devices. Decide whether to implement the comparator, DAC switches, and digital logic entirely in 3.3 V I/O devices, or use 1.8 V core devices with level-shifting for area/power savings — not specified in sources, flag for design decision.
- **Process node constraints (literature reference, needs re-derivation at 3.3 V):**
  - 90 nm design: leakage-critical paths (comparator tail switch, NOR ready-gate) used high-VT devices; speed-critical paths used low-VT devices.
  - 180 nm (Xiong) design: used MIM capacitors and resistor ladders — same device class available in GF180MCU, but sizing must be redone for 3.3 V swing.
- **Comparator:** dynamic-latch topology (e.g., StrongArm + RS latch) is transferable in principle. Sizing/biasing for 3.3 V devices must be redesigned. Literature reference only: preamp gain ~6, input-referred noise ≤ 90×10⁻⁹ V² (90 nm, 1 V); must resolve ≤1 LSB differences to avoid metastability.
- **Capacitor-DAC sizing:** literature unit-cap values are not directly transferable — must be resized for a 3.3 V dynamic range using GF180MCU's MIM/poly cap models. Literature reference: 0.5 fF unit cap, 128 fF total DAC cap, 180 fF attenuation cap (90 nm); 168 fF MIM unit caps, 32 units, extracted comparator parasitic Cp = 65 fF (180 nm, Xiong); 17.6 µF unit capacitance (180 nm, Bekal — unit as stated in source; a value this large is atypical for an on-chip unit cap, likely intended as fF, verify against the original reference). Matching reference (180 nm, Xiong): σ = 0.31% (caps), σ = 0.66% (resistors) — voltage-dependent, re-verify at 3.3 V.
- **Digital logic:** custom dynamic logic or True Single-Phase Clocked Registers (TSPCRs) with asynchronous reset, to be implemented with GF180MCU 3.3 V-tolerant cells or full-custom logic.

## 7. Verification & Test Plan Requirements

- **Transient timing:** verify DAC settling time (literature reference: 2.5 ns to 0.5 LSB) is shorter than comparator reset time (literature reference: 3 ns), across GF180MCU process corners (TT/FF/SS) and a 3.3 V ± 10% supply range and temperature range.
- Confirm edge-sensitive asynchronous pulse generators function reliably across those corners.
- **Offset/noise:** Monte Carlo simulation (literature reference: 500–1000 iterations) of comparator dynamic offset, thermal noise, and component mismatch.
- Overdrive recovery testing — confirm the comparator resolves ≤1 LSB differences immediately after a full-scale, opposite-polarity input.
- **Characterization:**
  - INL/DNL across all 256 codes.
  - Separate systematic vs. random INL/DNL components across multiple die samples (literature reference: 9 chips) to catch layout-dependent linearity loss.
  - FFT spectral testing (literature reference: 4096-point FFT) for SNDR, SNR, SFDR, ENOB up to Nyquist.

## 8. Risks & Open Issues

- **Cross-node/voltage extrapolation risk (new, target-specific):** the INL/DNL/ENOB/power/SNDR figures above come from other nodes and supply voltages. None should be treated as validated for GF180MCU at 3.3 V without post-layout re-simulation.
- **Parasitic interconnect capacitance:** CDAC top-plate parasitics consumed up to 46% of total power in a 90 nm post-layout case; can distort the binary division ratio without common-centroid layout.
- **ENOB loss at high frequency:** sampling-switch coupling (2.4 fF in the 90 nm reference) causes sampled-voltage fluctuation during conversion, degrading ENOB at high input frequencies.
- **Common-mode charge injection:** signal-dependent charge injection from sampling switches produced a 4–12 mV common-mode step in the absence of bottom-plate sampling.
- **Asynchronous clock stall/metastability:** near-zero input differences can make comparator decision time grow exponentially, risking a stall of the async logic cascade — a watchdog or skewed-NAND timeout mechanism is needed to override metastability.
- **Comparator parasitic Cp in R-DAC variants:** in the Xiong (180 nm) architecture, comparator input parasitic Cp (65 fF) degraded the passive divider ratio and reduced ENOB; complex R-DAC routing also limited reference settling time.

## 9. Success Criteria / Acceptance Metrics

- Target (GF180MCU, 3.3 V):
  - Sampling Rate: 20 - 50 MS/s
  - Power: < 1 mW
  - ENOB: > 7.5 bit
  - SNDR: > 47.0 dB
  - INL / DNL: < 1.0 LSB
- Literature sanity-check range (180 nm designs only; supply differs from 3.3 V target in all cases, so treat as rough order-of-magnitude bounds, not pass/fail thresholds):
  - ENOB: 7.2–7.53 bit
  - SNDR: ~45.2–46.7 dB (mixed across nodes; 180 nm value is 45.16 dB)
  - Power: 32.4 µW (Bekal, 180 nm) to 2.07 mW @ 65 MS/s (Xiong, 180 nm, 1.2 V/1.8 V)
  - INL/DNL: < 1 LSB
