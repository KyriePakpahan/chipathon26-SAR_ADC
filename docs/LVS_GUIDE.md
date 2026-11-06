# Netgen LVS Guide: Layout Versus Schematic (GF180MCU Variant D)

This document describes the Layout Versus Schematic (LVS) verification procedure for the 8-bit asynchronous SAR ADC (`sar_adc_top`) in GlobalFoundries GF180MCU Variant D (5LM, MIM-B).

---

## 1. Verification Flow

LVS verification compares two netlists:
1. Golden schematic netlist: `cdl/sar_adc_top.spice` (or respective sub-block netlists in `cdl/`).
2. Layout-extracted netlist: Extracted from `layout/sar_adc/sar_adc_top.gds` using Magic VLSI (`ext2spice lvs`).

Configuration files:
- Netgen setup deck: [`lvs/gf180mcuD_setup.tcl`](../lvs/gf180mcuD_setup.tcl)
- Runner script: [`scripts/run_netgen_lvs.sh`](../scripts/run_netgen_lvs.sh)
- Chipathon automated LVS configuration: [`lvs_config.json`](../lvs_config.json)

---

## 2. Running Netgen LVS

### A. Using the Runner Script

```bash
# 1. Top-level SAR ADC macro (sar_adc_top)
./scripts/run_netgen_lvs.sh layout/sar_adc/sar_adc_top.gds sar_adc_top cdl/sar_adc_top.spice

# 2. Individual sub-blocks (e.g., sample_hold and cdac_8bit)
./scripts/run_netgen_lvs.sh layout/sar_adc/blocks/sample_hold/sample_hold.gds sample_hold cdl/sample_hold.spice
./scripts/run_netgen_lvs.sh layout/sar_adc/blocks/cdac/cdac_8bit.gds cdac_8bit cdl/cdac_8bit.spice
```

### B. Manual Steps Inside the IIC-OSIC-Tools Container

```bash
# Step 1: Extract the LVS netlist from GDS using Magic
magic -dnull -noconsole -rcfile /foss/pdks/gf180mcuD/libs.tech/magic/gf180mcuD.magicrc << 'MAG_EOF'
gds read layout/sar_adc/sar_adc_top.gds
load sar_adc_top
select top cell
extract all
ext2spice lvs
ext2spice format ngspice
ext2spice -o lvs/reports/sar_adc_top_extracted.spice
quit -noprompt
MAG_EOF

# Step 2: Compare netlists using Netgen
netgen -batch lvs \
  "lvs/reports/sar_adc_top_extracted.spice sar_adc_top" \
  "cdl/sar_adc_top.spice sar_adc_top" \
  "lvs/gf180mcuD_setup.tcl" \
  "lvs/reports/sar_adc_top_comp.out"
```

---

## 3. Interpreting LVS Output (`*_comp.out`)

Open the comparison report at `lvs/reports/sar_adc_top_comp.out`.

### Clean Result (Circuits Match)
The final section of the report states:
```text
Device classes sar_adc_top and sar_adc_top are equivalent.
Circuits match uniquely.
Result: Netlist elements match completely.
Logging to comp.out finished with 0 errors.
```

### Handling Pin Mismatch
If all internal devices and nets match but top-level port names differ, Netgen reports:
```text
Device classes sar_adc_top and sar_adc_top are equivalent.
Final result: Top level cell failed pin matching.
```
Ensure text labels on metal layers in the GDS match the 14 pins specified in [`info.yaml`](../info.yaml) and [`cdl/sar_adc_top.spice`](../cdl/sar_adc_top.spice).

---

## 4. Output Files

| File | Description |
| :--- | :--- |
| `lvs/reports/<cell>_extracted.spice` | SPICE netlist extracted from GDS by Magic |
| `lvs/reports/<cell>_comp.out` | Device, net, and pin comparison report from Netgen |
| `lvs/reports/<cell>_lvs.log` | Netgen execution log |
