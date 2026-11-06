# DRC and LVS Verification Guide: Chipathon 2026

This document specifies the verification procedure for Design Rule Checking (DRC) and Layout Versus Schematic (LVS) on the 8-bit asynchronous SAR ADC macro (`sar_adc_top`) and its constituent sub-blocks.

---

## 1. Execution Environment

Physical verification runs inside the IIC-OSIC-Tools Docker container:
- Image: `hpretl/iic-osic-tools:chipathon26`
- Target PDK: GlobalFoundries GF180MCU Variant D (3.3 V, 5LM, MIM-B)
- Software tools: KLayout (DRC), Magic VLSI (layout netlist extraction), and Netgen (LVS)

---

## 2. Verification Procedure

### A. Enter the Container Shell
```bash
docker run --rm -it \
  -v $(pwd):/foss/designs/chipathon26-SAR_ADC \
  -w /foss/designs/chipathon26-SAR_ADC \
  hpretl/iic-osic-tools:chipathon26 --skip bash
```

### B. Run Top-Level DRC and LVS (`sar_adc_top`)
Inside the container, run:

1. KLayout DRC on the top-level layout (`layout/sar_adc/sar_adc_top.gds`):
   ```bash
   python3 /foss/pdks/gf180mcuD/libs.tech/klayout/tech/drc/run_drc.py \
     --path=layout/sar_adc/sar_adc_top.gds \
     --variant=D \
     --thr=8 \
     --run_dir=reports/drc_sar_adc_top
   ```

2. Magic + Netgen LVS on the top-level layout (`sar_adc_top`):
   ```bash
   ./scripts/run_netgen_lvs.sh \
     layout/sar_adc/sar_adc_top.gds \
     sar_adc_top \
     cdl/sar_adc_top.spice
   ```

3. Sub-block verification via `Makefile`:
   ```bash
   make drc
   make lvs
   make verify
   ```

---

## 3. Configuration Files and Reference Netlists

| File / Directory | Function |
| :--- | :--- |
| [`info.yaml`](../info.yaml) | Chipathon 2026 project manifest and 14-pin `A49_BV` padframe mapping |
| [`lvs_config.json`](../lvs_config.json) | Automated LVS configuration (`layout/sar_adc/sar_adc_top.gds` vs. `cdl/sar_adc_top.spice`) |
| [`cdl/`](../cdl) | Golden SPICE/CDL netlist directory for LVS sign-off |
| [`layout/sar_adc/`](../layout/sar_adc) | Physical GDSII layout directory (`sar_adc_top.gds` and `blocks/`) |
| `lvs/reports/` | Extracted SPICE netlists and Netgen comparison reports (`*_comp.out`) |

---

## 4. Block Sign-Off Matrix

| Cell / Block Name | GDS Path | Golden Netlist | DRC Status | LVS Status |
| :--- | :--- | :--- | :---: | :---: |
| `sar_adc_top` (TOP) | `layout/sar_adc/sar_adc_top.gds` | `cdl/sar_adc_top.spice` | 0 violations | Match |
| `async_sar` | `layout/sar_adc/blocks/async_sar/async_sar.gds` | `cdl/async_sar.spice` | 0 violations | Match |
| `cdac_8bit` | `layout/sar_adc/blocks/cdac/cdac_8bit.gds` | `cdl/cdac_8bit.spice` | 0 violations | Match |
| `strongarm_comp` | `layout/sar_adc/blocks/comparator/strongarm_comp.gds` | `cdl/strongarm_comp.spice` | 0 violations | Match |
| `sample_hold` | `layout/sar_adc/blocks/sample_hold/sample_hold.gds` | `cdl/sample_hold.spice` | 0 violations | Match |
| `shift_reg_8bit` | `layout/sar_adc/blocks/async_sar/shift_reg_8bit.gds` | `cdl/shift_reg_8bit.spice` | 0 violations | Match |
| `bit_reg` | `layout/sar_adc/blocks/async_sar/bit_reg.gds` | `cdl/bit_reg.spice` | 0 violations | Match |
| `async_delay_chain` | `layout/sar_adc/blocks/async_sar/async_delay_chain.gds` | `cdl/async_delay_chain.spice` | 0 violations | Match |
| `async_start_delay` | `layout/sar_adc/blocks/async_sar/async_start_delay.gds` | `cdl/async_start_delay.spice` | 0 violations | Match |
| `dff_cell` | `layout/sar_adc/blocks/async_sar/dff_cell.gds` | `cdl/dff_cell.spice` | 0 violations | Match |
| `dff_cell_set` | `layout/sar_adc/blocks/async_sar/dff_cell_set.gds` | `cdl/dff_cell_set.spice` | 0 violations | Match |
| `async_nor2` | `layout/sar_adc/blocks/async_sar/async_nor2.gds` | `cdl/async_nor2.spice` | 0 violations | Match |
| `async_nand2` | `layout/sar_adc/blocks/async_sar/async_nand2.gds` | `cdl/async_nand2.spice` | 0 violations | Match |
| `async_inverter` | `layout/sar_adc/blocks/async_sar/async_inverter.gds` | `cdl/async_inverter.spice` | 0 violations | Match |
