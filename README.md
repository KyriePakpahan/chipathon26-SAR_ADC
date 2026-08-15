# 8-Bit 10 MS/s Asynchronous SAR ADC

**IEEE CASS / SSCS Chipathon 2026 — Track A**  
**Team A49 — Berkah Saluyu**

[![DRC Status](https://img.shields.io/badge/DRC-PASS%20(0%20errors)-brightgreen)](docs/VERIFICATION.md)
[![LVS Status](https://img.shields.io/badge/LVS-MATCH%20(100%25)-brightgreen)](docs/VERIFICATION.md)
[![PDK](https://img.shields.io/badge/PDK-GF180MCU--D%20(3.3V)-blue)](info.yaml)
[![Team](https://img.shields.io/badge/Team-A49%20Berkah%20Saluyu%20Team-orange)](info.yaml)

This repository contains the complete design files, schematics, layout, and physical verification infrastructure for an **8-bit 10 MS/s Asynchronous Successive Approximation Register (SAR) Analog-to-Digital Converter (ADC)** designed in the open-source **GlobalFoundries 180nm MCU (GF180MCU Variant D, 3.3V)** technology.

---

## Project Overview

The circuit implements a self-timed asynchronous SAR ADC architecture developed hierarchically:
- **Asynchronous SAR Logic Controller**: Self-timed ring counter, TSPC DFFs, bit registers, and DAC drivers.
- **Dynamic StrongARM Comparator**: High-speed regenerative latch with completion detector.
- **Sample-and-Hold Circuitry**: Bootstrap sampling switch with high linearity.
- **Capacitive DAC (CDAC)**: 8-bit charge-redistribution capacitor array.
- **SAR ADC Top-Level Integration**: Full system integration and padframe mapping.

---

## Key Performance Specifications

| Parameter | Value / Target | Unit |
| :--- | :--- | :---: |
| **Process PDK** | GlobalFoundries GF180MCU (Variant D) | 180 nm |
| **Supply Voltage ($V_{DD}$)** | 3.3 | V |
| **Resolution** | 8 | Bits |
| **Sampling Rate ($f_s$)** | 10 | MS/s |
| **Conversion Period ($T_{conv}$)** | 100 | ns |
| **Clocking Paradigm** | Self-Timed Asynchronous (Internal Completion Detection) | - |
| **Input Full-Scale ($V_{in}$)** | 0.45 – 2.85 ($2.4\text{ V}_{pp}$ differential swing) | V |
| **LSB Voltage** | 12.89 | mV |
| **Target ENOB** | **> 7.0** | Bits |
| **Target SNDR** | **> 44.0** | dB |
| **Total MOSFET Devices (Async Logic)** | 736 (368 PMOS + 368 NMOS) | Devices |
| **Physical DRC & LVS Status** | **100% PASS / 0 Violations (CLEAN)** | - |

---

## Quickstart: Running DRC & LVS Verification

To run **Design Rule Checking (DRC)** and **Layout Versus Schematic (LVS)** verification instantly, use the official Docker container `hpretl/iic-osic-tools:chipathon26`:

### 1. Interactive Container Shell
```bash
docker run --rm -it \
  -v $(pwd):/foss/designs/chipathon26-SAR_ADC \
  -w /foss/designs/chipathon26-SAR_ADC \
  hpretl/iic-osic-tools:chipathon26 --skip bash
```

### 2. Verification Commands (Make Targets)
Inside the container, run:

```bash
# 1. Run DRC on Top-Level Layout (async_sar.gds)
make drc

# 2. Run Netgen LVS on Top-Level (async_sar.gds vs cdl/async_sar.spice)
make lvs

# 3. Run Full Verification Suite across all 10 layout blocks
make verify
```

---

### Alternative: Single-Line Execution from Host Terminal

```bash
# DRC Top-Level
docker run --rm -v $(pwd):/foss/designs/chipathon26-SAR_ADC -w /foss/designs/chipathon26-SAR_ADC \
  hpretl/iic-osic-tools:chipathon26 --skip make drc

# LVS Top-Level
docker run --rm -v $(pwd):/foss/designs/chipathon26-SAR_ADC -w /foss/designs/chipathon26-SAR_ADC \
  hpretl/iic-osic-tools:chipathon26 --skip make lvs

# Full Verification Suite
docker run --rm -v $(pwd):/foss/designs/chipathon26-SAR_ADC -w /foss/designs/chipathon26-SAR_ADC \
  hpretl/iic-osic-tools:chipathon26 --skip make verify
```

---

## Physical Verification Matrix (10/10 Cells Clean)

```text
================================================================================
FINAL SUMMARY MATRIX (CHIPATHON 2026 VERIFICATION SUITE)
================================================================================
| Cell / Block Name      | DRC Status           | LVS Status         |
| ---------------------- | -------------------- | ------------------ |
| async_sar (TOP)        | PASS (0 errors)      | PASS (Match)       |
| async_inverter         | PASS (0 errors)      | PASS (Match)       |
| async_nand2            | PASS (0 errors)      | PASS (Match)       |
| async_nor2             | PASS (0 errors)      | PASS (Match)       |
| dff_cell               | PASS (0 errors)      | PASS (Match)       |
| dff_cell_set           | PASS (0 errors)      | PASS (Match)       |
| shift_reg_8bit         | PASS (0 errors)      | PASS (Match)       |
| bit_reg                | PASS (0 errors)      | PASS (Match)       |
| async_delay_chain      | PASS (0 errors)      | PASS (Match)       |
| async_start_delay      | PASS (0 errors)      | PASS (Match)       |
================================================================================
>> ALL CELLS AND TOP-LEVEL 100% PASSED (0 DRC VIOLATIONS & 100% LVS MATCH) <<
```

---

## Repository Structure

```text
chipathon26-SAR_ADC/
├── info.yaml                  # Chipathon 2026 Project Specification Manifest
├── lvs_config.json            # Centralized LVS Automation Configuration
├── Makefile                   # Make targets (make drc, make lvs, make verify)
├── cdl/                       # Golden SPICE Netlists for LVS
│   ├── async_sar.spice        # Golden Top-Level Netlist (736 MOSFETs, 355 Nets)
│   ├── bit_reg.spice
│   ├── shift_reg_8bit.spice
│   └── ... (all subcell golden netlists)
├── layout/                    # Physical GDSII Layouts (100% DRC Clean)
│   ├── async_sar.gds          # Async SAR Top-Level Layout
│   ├── bit_reg.gds
│   ├── shift_reg_8bit.gds
│   └── sar_adc/               # Sub-block layout hierarchy (comparator, sample_hold)
├── scripts/                   # Automated Layout Builders & Test Runners
│   ├── build_async_sar.py     # Top-Level Python Layout Generator
│   ├── run_drc.py             # Official GF180MCU DRC Runner
│   ├── run_lvs.py             # Official Netgen LVS Runner (reads lvs_config.json)
│   ├── verify_all.py          # Complete 10-Cell Verification Suite
│   └── ...
├── docs/                      # Technical Documentation & Guides
│   ├── VERIFICATION.md        # Step-by-Step Team Verification Guide
│   ├── PRD_8bit_Async_SAR_... # Circuit PRD & Optimization Architecture
│   └── images/                # Simulation waveforms and characterization plots
└── xschem/                    # Xschem Schematics and Testbenches
    └── sar_adc/               # Schematics for SAR ADC, CDAC, Comparator, & SH
```

---

## Top-Level Pinout (`async_sar`)

| Pin Name | Type | Description |
| :--- | :---: | :--- |
| `vdd` | Power | Main 3.3V power supply rail |
| `vss` | Ground | Main 0.0V ground reference rail |
| `start` | Input | Conversion trigger and bottom-plate sampling control |
| `comp_done` | Input | Active-high comparator completion handshake |
| `comp_out_p` | Input | Positive comparator decision bit |
| `sample_en` | Output | Sampling switch driver enable pulse |
| `rst_latch` | Output | StrongARM comparator reset and evaluation signal |
| `done` | Output | Active-high End-of-Conversion (EOC) flag |
| `dout[7:0]` | Output Bus | 8-bit registered digital output word (MSB: `dout[7]`) |
| `dac_in[7:0]` | Output Bus | 8-bit CDAC capacitor bottom-plate switching control lines |

---

## Project Timeline

| Milestone | Target Date | Status |
| :--- | :---: | :---: |
| **Analog Design & Architecture** | Week 26 (June 26) | Completed |
| **Schematic Design & Simulation** | Week 27–29 (July) | Completed |
| **Sub-Block Layout & Verification** | Week 33 (August 14) | Completed |
| **Top-Level Integration & Physical Sign-off** | Week 34–35 (August) | In Progress / Verified Clean |
| **Final GDS Submission (Tapeout)** | TBD | Ready for Packaging |

---

## License
Developed by **A49 Berkah Saluyu Team** for **IEEE CASS / SSCS Chipathon 2026** under the [Apache-2.0](LICENSE) License.
