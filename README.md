# 8-Bit 10 MS/s Asynchronous SAR ADC

IEEE SSCS Chipathon 2026 (Track A)  
Team A49: Berkah Saluyu (Institut Teknologi Bandung)

[![DRC Status](https://img.shields.io/badge/DRC-PASS%20(0%20errors)-brightgreen)](docs/VERIFICATION.md)
[![LVS Status](https://img.shields.io/badge/LVS-MATCH%20(100%25)-brightgreen)](docs/VERIFICATION.md)
[![PDK](https://img.shields.io/badge/PDK-GF180MCU--D%20(3.3V)-blue)](info.yaml)
[![Team](https://img.shields.io/badge/Team-A49%20Berkah%20Saluyu-orange)](info.yaml)

This repository contains the schematics, physical layout, golden netlists, and verification scripts for an 8-bit 10 MS/s asynchronous successive-approximation register (SAR) analog-to-digital converter (ADC) in GlobalFoundries 180 nm MCU (GF180MCU Variant D, 3.3 V, 5LM).

---

## Project Overview

The converter (`sar_adc_top`) is a single-ended, self-timed 8-bit charge-redistribution SAR ADC inside the 550 µm × 1110 µm `A49_BV` project slot:
- Top-level integration (`sar_adc_top`): Combines all sub-blocks inside a P+ substrate guard ring with 5-layer staggered dummy metal fill (`dummy_metal_fill`) and 14 perimeter pins (`W12–W22`, `N01–N03`).
- Asynchronous SAR controller (`async_sar`): Self-timed domino loop, TSPC flip-flops (`dff_cell`, `dff_cell_set`), 8-bit shift register (`shift_reg_8bit`), bit registers (`bit_reg`), and delay chains (`async_start_delay`, `async_delay_chain`).
- Dynamic StrongARM comparator (`strongarm_comp`): Regenerative latch (`strongarm_comp_core`) with output buffers and completion detection (`comp_xor_fast`, `comp_nand2`).
- Bootstrapped sample-and-hold (`sample_hold`): Constant-$V_{\text{GS}}$ sampling switch driving a 380 fF sampling capacitor ($C_{\text{hold}}$).
- Capacitive DAC (`cdac_8bit`): 8-bit binary-weighted MIM-B capacitor array (`cap_mim_2f0m4m5_noshield`, 2.0 fF/µm²) with unit-sized CMOS bottom-plate drivers (`cdac_switch_1b`) and top-plate reset (`dac_rst`).

---

## Key Performance Specifications (Post-Layout PEX, `ngspice-42`)

| Parameter | Post-Layout PEX Value | Unit |
| :--- | :--- | :---: |
| Process technology | GlobalFoundries GF180MCU Variant D (5LM, MIM-B) | 180 nm |
| Project slot area (`PR_bndry` `0/0`) | 550 × 1110 | µm² |
| Supply voltage ($V_{\text{DD}}$) / Reference ($V_{\text{REF}}$) | 3.30 / 3.30 | V |
| Resolution | 8 | bits |
| Sampling rate ($f_s$) | 10 | MS/s |
| Track / reset pulse width ($T_{\text{samp}}$) | 15.0 | ns |
| Asynchronous conversion delay ($t_{\text{conv}}$, `start`↓ to `done`↑) | 55.06 mean (53.63 to 58.30) | ns |
| Calibrated linear input window ($V_{\text{in}}$) | 0.85 to 2.45 ($1.60\text{ V}_{\text{pp}}$ at $V_{\text{cm}} = 1.65\text{ V}$; 0 to 3.3 V full-scale) | V |
| Coherent dynamic test frequency ($f_{\text{in}}$, $M/N = 7/32$) | 2.1875 | MHz |
| Effective number of bits (ENOB) | 7.92 calibrated (6.78 raw) | bits |
| Signal-to-noise-and-distortion ratio (SNDR) | 49.44 calibrated (42.59 raw) | dBFS |
| Spurious-free dynamic range (SFDR) | 50.13 | dBc |
| Total harmonic distortion (THD) | -47.90 | dBc |
| Differential non-linearity (RMS DNL) | 0.35 to 0.55 | LSB |
| Integral non-linearity (RMS INL) | 0.49 to 0.59 | LSB |
| Core active power ($P_{\text{core}}$ at 10 MS/s) | 0.285 (total with 16 mA I/O pads: 1.19 to 2.44) | mW |
| Core Walden figure of merit ($\text{FoM}_W$) | 117.7 | fJ/conv-step |
| Physical verification (DRC / LVS) | 0 DRC violations / 100% LVS match | - |

---

## Tapeout and Silicon Test Documentation

| Document / Artifact | Path | Description |
| :--- | :--- | :--- |
| Project configuration | [`info.yaml`](info.yaml) | Chipathon 2026 metadata, 14-pin `A49_BV` pad mapping, and sign-off flags |
| Export control certification | [`documents/Export_Control_GF_Rev2.docx`](documents/Export_Control_GF_Rev2.docx) | Completed GlobalFoundries Export Control form (`EAR99`, HTS `8542.39.0030`) |
| Silicon bring-up and test plan | [`docs/TEST_PLAN.md`](docs/TEST_PLAN.md) | Pinout, timing protocol, PCB filtering, lab instruments, and pass criteria |
| Final handoff GDSII | [`layout/sar_adc/sar_adc_top.gds`](layout/sar_adc/sar_adc_top.gds) | Top-level layout (`550 µm × 1110 µm`, SHA-256 `7efe98ffebdbc31aa459ef9e9e21614b0f16f9c45d8e8711ee649c1336b70299`) |

---

## Physical Verification Guide (DRC and LVS)

All verification commands run inside the `hpretl/iic-osic-tools:chipathon26` Docker container against GF180MCU Variant D (`gf180mcuD`).

### 1. Start the Container

```bash
docker exec -it iic-osic-tools_chipathon_xserver_uid_1000 bash
# Or start a new container instance:
docker run --rm -it \
  -v $(pwd):/foss/designs/chipathon26-SAR_ADC \
  -w /foss/designs/chipathon26-SAR_ADC \
  hpretl/iic-osic-tools:chipathon26 --skip bash
```

### 2. Design Rule Checking (KLayout DRC)

#### A. Full Top-Level DRC (`sar_adc_top.gds`)
```bash
python3 /foss/pdks/gf180mcuD/libs.tech/klayout/tech/drc/run_drc.py \
  --path=layout/sar_adc/sar_adc_top.gds \
  --variant=D \
  --thr=8 \
  --run_dir=reports/drc_sar_adc_top
```

#### B. Metal Density DRC (`M1.d` to `M5.d`)
```bash
python3 /foss/pdks/gf180mcuD/libs.tech/klayout/tech/drc/run_drc.py \
  --path=layout/sar_adc/sar_adc_top.gds \
  --variant=D \
  --density_only \
  --thr=8 \
  --run_dir=reports/drc_sar_adc_top
```

#### C. Antenna Rule DRC
```bash
python3 /foss/pdks/gf180mcuD/libs.tech/klayout/tech/drc/run_drc.py \
  --path=layout/sar_adc/sar_adc_top.gds \
  --variant=D \
  --antenna_only \
  --thr=8 \
  --run_dir=reports/antenna_sar_adc_top
```

#### D. Sub-Block DRC
```bash
# Asynchronous SAR controller
python3 /foss/pdks/gf180mcuD/libs.tech/klayout/tech/drc/run_drc.py \
  --path=layout/sar_adc/blocks/async_sar/async_sar.gds --variant=D --thr=8 --run_dir=reports/drc_async_sar

# 8-bit CDAC array
python3 /foss/pdks/gf180mcuD/libs.tech/klayout/tech/drc/run_drc.py \
  --path=layout/sar_adc/blocks/cdac/cdac_8bit.gds --variant=D --thr=8 --run_dir=reports/drc_cdac_8bit

# StrongARM dynamic comparator
python3 /foss/pdks/gf180mcuD/libs.tech/klayout/tech/drc/run_drc.py \
  --path=layout/sar_adc/blocks/comparator/strongarm_comp.gds --variant=D --thr=8 --run_dir=reports/drc_strongarm_comp

# Bootstrapped sample-and-hold
python3 /foss/pdks/gf180mcuD/libs.tech/klayout/tech/drc/run_drc.py \
  --path=layout/sar_adc/blocks/sample_hold/sample_hold.gds --variant=D --thr=8 --run_dir=reports/drc_sample_hold
```

### 3. Layout Versus Schematic (Magic + Netgen LVS)

#### A. Top-Level LVS (`sar_adc_top`)
```bash
./scripts/run_netgen_lvs.sh \
  layout/sar_adc/sar_adc_top.gds \
  sar_adc_top \
  cdl/sar_adc_top.spice
```

#### B. Sub-Block LVS
```bash
./scripts/run_netgen_lvs.sh layout/sar_adc/blocks/async_sar/async_sar.gds async_sar cdl/async_sar.spice
./scripts/run_netgen_lvs.sh layout/sar_adc/blocks/cdac/cdac_8bit.gds cdac_8bit cdl/cdac_8bit.spice
./scripts/run_netgen_lvs.sh layout/sar_adc/blocks/comparator/strongarm_comp.gds strongarm_comp cdl/strongarm_comp.spice
./scripts/run_netgen_lvs.sh layout/sar_adc/blocks/sample_hold/sample_hold.gds sample_hold cdl/sample_hold.spice
```

#### C. Inspect LVS Report
```bash
cat lvs/reports/sar_adc_top_comp.out
```
Expected result:
```text
Device classes sar_adc_top and sar_adc_top are equivalent.
Circuits match uniquely.
```

---

## Sign-Off Verification Summary

| Cell / Block Name | Function | GDS Path | Golden Netlist | DRC Status | LVS Status |
| :--- | :--- | :--- | :--- | :---: | :---: |
| `sar_adc_top` (TOP) | Top-level 8-bit SAR ADC macro | `layout/sar_adc/sar_adc_top.gds` | `cdl/sar_adc_top.spice` | 0 violations | Match |
| `async_sar` | Self-timed SAR logic controller | `layout/sar_adc/blocks/async_sar/async_sar.gds` | `cdl/async_sar.spice` | 0 violations | Match |
| `cdac_8bit` | 8-bit MIM-B capacitor DAC array | `layout/sar_adc/blocks/cdac/cdac_8bit.gds` | `cdl/cdac_8bit.spice` | 0 violations | Match |
| `strongarm_comp` | Dynamic StrongARM comparator | `layout/sar_adc/blocks/comparator/strongarm_comp.gds` | `cdl/strongarm_comp.spice` | 0 violations | Match |
| `sample_hold` | Bootstrapped track-and-hold switch | `layout/sar_adc/blocks/sample_hold/sample_hold.gds` | `cdl/sample_hold.spice` | 0 violations | Match |
| `dummy_metal_fill` | 5-layer staggered dummy metal fill | `layout/sar_adc/blocks/dummy_metal_fill/dummy_metal_fill.gds` | Floating fill | 0 violations | N/A |

---

## Repository Structure

```text
chipathon26-SAR_ADC/
├── info.yaml                  # Chipathon 2026 project manifest and 14-pin pad mapping
├── lvs_config.json            # Automated LVS configuration
├── Makefile                   # Make targets for DRC and LVS
├── documents/
│   └── Export_Control_GF_Rev2.docx  # Signed GF export control questionnaire
├── docs/
│   ├── TEST_PLAN.md           # Silicon bring-up and bench test plan
│   ├── VERIFICATION.md        # DRC and LVS verification instructions
│   ├── LVS_GUIDE.md           # Magic + Netgen LVS guide
│   └── images/                # Schematic, layout, and simulation plots
├── cdl/                       # Golden SPICE netlists for LVS sign-off
│   ├── sar_adc_top.spice
│   ├── async_sar.spice
│   ├── cdac_8bit.spice
│   ├── strongarm_comp.spice
│   └── sample_hold.spice
├── layout/                    # Physical GDSII layouts
│   └── sar_adc/
│       ├── sar_adc_top.gds    # Final handoff GDSII (550 µm × 1110 µm)
│       └── blocks/            # Hierarchical sub-block GDSII cells
├── lvs/
│   └── gf180mcuD_setup.tcl    # Netgen setup deck for GF180MCU Variant D
├── reports/
│   ├── def_alignment.json     # Verified A49_BV pin coordinate alignment report
│   └── sar_adc_top_performance_panel.png
├── scripts/
│   ├── run_drc.py             # Batch KLayout DRC runner
│   ├── run_netgen_lvs.sh      # Magic extraction + Netgen LVS script
│   └── run_docker_iic.sh      # IIC-OSIC-Tools Docker wrapper
└── xschem/
    └── sar_adc/               # Xschem schematics, symbols, and SPICE testbenches
```

---

## License

Developed by Team A49 Berkah Saluyu (Institut Teknologi Bandung) for IEEE SSCS Chipathon 2026 under the [Apache-2.0](LICENSE) License.
