# 8-Bit 10 MS/s Asynchronous SAR ADC

**IEEE SSCS Chipathon 2026 — Track A**  
**Team A49 — Berkah Saluyu**

[![DRC Status](https://img.shields.io/badge/DRC-PASS%20(0%20errors)-brightgreen)](docs/VERIFICATION.md)
[![LVS Status](https://img.shields.io/badge/LVS-MATCH%20(100%25)-brightgreen)](docs/VERIFICATION.md)
[![PDK](https://img.shields.io/badge/PDK-GF180MCU--D%20(3.3V)-blue)](info.yaml)
[![Team](https://img.shields.io/badge/Team-A49%20Berkah%20Saluyu%20Team-orange)](info.yaml)

This repository contains the complete design files, schematics, layout, and physical verification infrastructure for an **8-bit 10 MS/s Asynchronous Successive Approximation Register (SAR) Analog-to-Digital Converter (ADC)** designed in the open-source **GlobalFoundries 180nm MCU (GF180MCU Variant D, 3.3V, 5LM)** technology.

---

## Project Overview

The circuit implements an **8-bit Single-Ended Input**, self-timed asynchronous charge-redistribution SAR ADC architecture developed hierarchically:
- **SAR ADC Top-Level (`sar_adc_top`)**: Monolithic integration with 360° P+ substrate guard rings, precision interconnects, and 5-layer progressive dummy metal fill.
- **Asynchronous SAR Logic Controller (`async_sar`)**: Self-timed ring counter, TSPC DFFs, bit registers, delay chains, and DAC control drivers.
- **Dynamic StrongARM Comparator (`strongarm_comp`)**: High-speed regenerative latch comparing sampled voltage $V_{hold}$ with $V_{dac}$.
- **Sample-and-Hold Circuitry (`sample_hold`)**: Bootstrap sampling switch network with high linearity.
- **Capacitive DAC (`cdac_8bit`)**: 8-bit binary-weighted MiM charge-redistribution capacitor array (`cap_mim_2f0_n4`).
- **Hierarchical Dummy Metal Fill (`dummy_metal_fill`)**: Full-die density compliance with Progressive 5-Phase Interlayer Stagger.

---

## Key Performance Specifications

| Parameter | Value / Post-Layout PEX | Unit |
| :--- | :--- | :---: |
| **Process PDK** | GlobalFoundries GF180MCU (Variant D, 5LM) | 180 nm |
| **Supply Voltage ($V_{DD}$)** | 3.3 | V |
| **Resolution** | 8 | Bits |
| **Sampling Rate ($f_s$)** | 10 | MS/s |
| **Input Topology** | **Single-Ended** | - |
| **Input Signal Frequency ($f_{in}$)** | 1.09 (Coherent ~1 MHz) | MHz |
| **Conversion Period ($T_{conv}$)** | 100 | ns |
| **Clocking Paradigm** | Self-Timed Asynchronous (No high-speed external clock) | - |
| **Input Full-Scale ($V_{in}$)** | 0.45 – 2.85 ($2.4\text{ V}_{pp}$ single-ended swing) | V |
| **LSB Voltage** | 12.89 | mV |
| **Effective Number of Bits (ENOB)** | **7.62** | Bits |
| **SNDR / SINAD** | **47.62** | dB |
| **SFDR** | **54.21** | dB |
| **Differential Non-Linearity (DNL)** | **< 0.5** | LSB |
| **Integral Non-Linearity (INL)** | **< 0.8** | LSB |
| **Power Consumption ($P_{tot}$)** | **1.19** (@ 10 MS/s, 3.3V) | mW |
| **Walden Figure-of-Merit ($FoM_W$)** | **581** | fJ/conv-step |
| **Physical DRC & LVS Status** | **100% PASS / 0 Violations (CLEAN)** | - |

---

## Physical Verification Guide (DRC & LVS)

Physical verification follows the **GF180MCU Design Reference Manual (DRM)**, **IEEE SSCS Chipathon 2026 guidelines**, and the [`klayout-ic-layout`](https://github.com/wafer-space/gf180mcu) flow.

All verification commands are executed within the official `iic-osic-tools:chipathon26` Docker environment.

### 1. Interactive Container Shell

To start an interactive session:

```bash
docker exec -it iic-osic-tools_chipathon_xserver_uid_1000 bash
# Or run a new container instance:
docker run --rm -it \
  -v $(pwd):/foss/designs/chipathon26-SAR_ADC \
  -w /foss/designs/chipathon26-SAR_ADC \
  hpretl/iic-osic-tools:chipathon26 --skip bash
```

---

### 2. Running Design Rule Checking (DRC)

GF180MCU uses KLayout batch DRC scripts configured for **Variant D (5 Metal Layers, 3.3V)** with multi-threading:

#### A. Full DRC on Top-Level Layout (`sar_adc_top.gds`)
```bash
python3 /foss/pdks/gf180mcuD/libs.tech/klayout/tech/drc/run_drc.py \
  --path=layout/sar_adc/sar_adc_top.gds \
  --variant=D \
  --thr=8 \
  --run_dir=reports/drc_sar_adc_top
```

#### B. Metal Density DRC Only (`M1.d` – `M5.d`)
```bash
python3 /foss/pdks/gf180mcuD/libs.tech/klayout/tech/drc/run_drc.py \
  --path=layout/sar_adc/sar_adc_top.gds \
  --variant=D \
  --density_only \
  --thr=8 \
  --run_dir=reports/drc_sar_adc_top
```

#### C. Antenna Rule DRC Only
```bash
python3 /foss/pdks/gf180mcuD/libs.tech/klayout/tech/drc/run_drc.py \
  --path=layout/sar_adc/sar_adc_top.gds \
  --variant=D \
  --antenna_only \
  --thr=8 \
  --run_dir=reports/antenna_sar_adc_top
```

#### D. Sub-Block DRC Runs
```bash
# Asynchronous Logic Controller
python3 /foss/pdks/gf180mcuD/libs.tech/klayout/tech/drc/run_drc.py \
  --path=layout/sar_adc/blocks/async_sar/async_sar.gds --variant=D --thr=8 --run_dir=reports/drc_async_sar

# 8-Bit CDAC Array
python3 /foss/pdks/gf180mcuD/libs.tech/klayout/tech/drc/run_drc.py \
  --path=layout/sar_adc/blocks/cdac/cdac_8bit.gds --variant=D --thr=8 --run_dir=reports/drc_cdac_8bit

# StrongARM Dynamic Comparator
python3 /foss/pdks/gf180mcuD/libs.tech/klayout/tech/drc/run_drc.py \
  --path=layout/sar_adc/blocks/comparator/strongarm_comp.gds --variant=D --thr=8 --run_dir=reports/drc_strongarm_comp

# Sample-and-Hold
python3 /foss/pdks/gf180mcuD/libs.tech/klayout/tech/drc/run_drc.py \
  --path=layout/sar_adc/blocks/sample_hold/sample_hold.gds --variant=D --thr=8 --run_dir=reports/drc_sample_hold
```

#### E. Viewing DRC Markers in KLayout GUI
1. Launch KLayout: `klayout layout/sar_adc/sar_adc_top.gds`
2. Open the Marker Database: **Tools → Marker Browser**
3. Select `File → Open` and load: `reports/drc_sar_adc_top/sar_adc_top_main.lyrdb`

---

### 3. Running Layout Versus Schematic (LVS)

LVS verification uses **Magic** for parasitic-aware SPICE netlist extraction and **Netgen** for graph-isomorphism netlist comparison with the GF180MCU setup deck (`lvs/gf180mcuD_setup.tcl`).

#### A. Top-Level LVS (`sar_adc_top`)
```bash
./scripts/run_netgen_lvs.sh \
  layout/sar_adc/sar_adc_top.gds \
  sar_adc_top \
  cdl/sar_adc_top.spice
```

#### B. Major Sub-Block LVS Runs
```bash
# Asynchronous SAR Logic
./scripts/run_netgen_lvs.sh \
  layout/sar_adc/blocks/async_sar/async_sar.gds \
  async_sar \
  cdl/async_sar.spice

# 8-bit CDAC Array
./scripts/run_netgen_lvs.sh \
  layout/sar_adc/blocks/cdac/cdac_8bit.gds \
  cdac_8bit \
  cdl/cdac_8bit.spice

# StrongARM Comparator
./scripts/run_netgen_lvs.sh \
  layout/sar_adc/blocks/comparator/strongarm_comp.gds \
  strongarm_comp \
  cdl/strongarm_comp.spice

# Sample & Hold Network
./scripts/run_netgen_lvs.sh \
  layout/sar_adc/blocks/sample_hold/sample_hold.gds \
  sample_hold \
  cdl/sample_hold.spice
```

#### C. Inspecting LVS Results
Read the comparison log in `lvs/reports/`:
```bash
cat lvs/reports/sar_adc_top_comp.out
```
A successful match concludes with:
```text
Device classes sar_adc_top and sar_adc_top are equivalent.
```

---

### 4. Single-Line Host Execution Commands

Run verification directly from your host terminal without entering interactive mode:

```bash
# Top-Level Full DRC
docker exec -it iic-osic-tools_chipathon_xserver_uid_1000 \
  python3 /foss/pdks/gf180mcuD/libs.tech/klayout/tech/drc/run_drc.py \
  --path=layout/sar_adc/sar_adc_top.gds --variant=D --thr=8 --run_dir=reports/drc_sar_adc_top

# Top-Level Netgen LVS
docker exec -it iic-osic-tools_chipathon_xserver_uid_1000 \
  ./scripts/run_netgen_lvs.sh layout/sar_adc/sar_adc_top.gds sar_adc_top cdl/sar_adc_top.spice
```

---

## Physical Verification Matrix

```text
================================================================================
FINAL SIGNOFF MATRIX (CHIPATHON 2026 VERIFICATION SUITE)
================================================================================
| Cell / Block Name       | Type / Function        | DRC Status  | LVS Status   |
| ----------------------- | ---------------------- | ----------- | ------------ |
| sar_adc_top (TOP)       | Monolithic Top Wrapper | CLEAN (0)   | EQUIVALENT    |
| async_sar               | SAR Logic Controller   | CLEAN (0)   | EQUIVALENT    |
| cdac_8bit               | 8-Bit MiM CDAC Array   | CLEAN (0)   | EQUIVALENT    |
| strongarm_comp          | Dynamic Comparator     | CLEAN (0)   | EQUIVALENT    |
| sample_hold             | Bootstrap Track & Hold | CLEAN (0)   | EQUIVALENT    |
| dummy_metal_fill        | Progressive Stagger    | CLEAN (0)   | N/A (Floating)|
================================================================================
>> ALL CELLS AND TOP-LEVEL 100% PASSED (0 DRC VIOLATIONS & 100% LVS MATCH) <<
```

---

## Repository Structure

```text
chipathon26-SAR_ADC/
├── info.yaml                  # Chipathon 2026 Project Specification Manifest
├── lvs_config.json            # Centralized LVS Automation Configuration
├── Makefile                   # Make targets (drc, lvs, verify)
├── cdl/                       # Golden SPICE Netlists for LVS
│   ├── sar_adc_top.spice      # Top-Level Golden Netlist (1,073 Devices)
│   ├── async_sar.spice        # Async SAR Controller (736 MOSFETs)
│   ├── cdac_8bit.spice        # 8-Bit MiM Capacitor DAC Array
│   ├── strongarm_comp.spice   # Dynamic Comparator
│   └── sample_hold.spice      # Bootstrap Track & Hold
├── layout/                    # Physical GDSII Layouts (100% DRC Clean)
│   └── sar_adc/               # Top-Level Layout & Sub-Block Hierarchy
│       ├── sar_adc_top.gds    # Complete Top-Level Layout with Guard Rings & Met-Fill
│       ├── sar_adc_chip.gds   # Padframe Top-Level Integration
│       └── blocks/            # Hierarchical leaf and macro cells
├── lvs/                       # Netgen LVS Setup Scripts & Reports
│   ├── gf180mcuD_setup.tcl    # PDK Variant D Setup Deck for Netgen
│   └── reports/               # LVS Comparison Reports (*_comp.out)
├── scripts/                   # Physical Verification & Layout Builders
│   ├── run_netgen_lvs.sh      # Production Magic+Netgen LVS Runner
│   ├── render_layout_png.py   # High-Resolution Layout PNG Renderer
│   └── ...
├── reports/                   # Active DRC and LVS Signoff Reports
│   ├── drc_sar_adc_top/       # Top-level DRC reports and marker databases (.lyrdb)
│   └── archive_drc_backups/   # Historical verification archives
└── xschem/                    # Xschem Schematics and Testbenches
    └── sar_adc/               # Schematics for SAR ADC, CDAC, Comparator, & SH
```

---

## License
Developed by **A49 Berkah Saluyu Team** for **IEEE SSCS Chipathon 2026** under the [Apache-2.0](LICENSE) License.
