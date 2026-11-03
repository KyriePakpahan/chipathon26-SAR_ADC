# Panduan Verifikasi DRC dan LVS (Chipathon 2026)

Dokumen ini menjelaskan cara menjalankan verifikasi Design Rule Checking (DRC) dan Layout Versus Schematic (LVS) pada desain 8-Bit Asynchronous SAR ADC (`sar_adc_top`) beserta seluruh sub-bloknya.

---

## 1. Lingkungan Kerja

Verifikasi fisik menggunakan container IIC-OSIC-Tools:
- Docker image: `hpretl/iic-osic-tools:chipathon26`
- PDK: GlobalFoundries GF180MCU Variant D (3.3 V, 5LM, MIM-B)
- Perangkat lunak: KLayout (DRC), Magic VLSI (ekstraksi netlist layout), dan Netgen (LVS)

---

## 2. Cara Menjalankan Verifikasi

### A. Masuk ke Shell Container
```bash
docker run --rm -it \
  -v $(pwd):/foss/designs/chipathon26-SAR_ADC \
  -w /foss/designs/chipathon26-SAR_ADC \
  hpretl/iic-osic-tools:chipathon26 --skip bash
```

### B. Menjalankan DRC dan LVS Top-Level (`sar_adc_top`)
Di dalam container, jalankan:

1. KLayout DRC pada top-level (`layout/sar_adc/sar_adc_top.gds`):
   ```bash
   python3 /foss/pdks/gf180mcuD/libs.tech/klayout/tech/drc/run_drc.py \
     --path=layout/sar_adc/sar_adc_top.gds \
     --variant=D \
     --thr=8 \
     --run_dir=reports/drc_sar_adc_top
   ```

2. Magic + Netgen LVS pada top-level (`sar_adc_top`):
   ```bash
   ./scripts/run_netgen_lvs.sh \
     layout/sar_adc/sar_adc_top.gds \
     sar_adc_top \
     cdl/sar_adc_top.spice
   ```

3. Verifikasi sub-blok logika via `Makefile`:
   ```bash
   make drc
   make lvs
   make verify
   ```

---

## 3. Struktur File Konfigurasi dan Netlist

| File / Direktori | Fungsi |
| :--- | :--- |
| [`info.yaml`](../info.yaml) | Manifest proyek Chipathon 2026 dan pemetaan 14 pin padframe `A49_BV` |
| [`lvs_config.json`](../lvs_config.json) | Konfigurasi LVS otomatis (`layout/sar_adc/sar_adc_top.gds` terhadap `cdl/sar_adc_top.spice`) |
| [`cdl/`](../cdl) | Direktori golden SPICE/CDL netlist untuk sign-off LVS |
| [`layout/sar_adc/`](../layout/sar_adc) | Direktori file layout fisik `.gds` (`sar_adc_top.gds` dan `blocks/`) |
| `lvs/reports/` | Direktori output ekstraksi `.spice` dan laporan perbandingan Netgen `*_comp.out` |

---

## 4. Matriks Sign-Off Blok

| Nama Cell / Blok | Lokasi GDS | Golden Netlist | Status DRC | Status LVS |
| :--- | :--- | :--- | :---: | :---: |
| `sar_adc_top` (TOP) | `layout/sar_adc/sar_adc_top.gds` | `cdl/sar_adc_top.spice` | 0 Errors | Match |
| `async_sar` | `layout/sar_adc/blocks/async_sar/async_sar.gds` | `cdl/async_sar.spice` | 0 Errors | Match |
| `cdac_8bit` | `layout/sar_adc/blocks/cdac/cdac_8bit.gds` | `cdl/cdac_8bit.spice` | 0 Errors | Match |
| `strongarm_comp` | `layout/sar_adc/blocks/comparator/strongarm_comp.gds` | `cdl/strongarm_comp.spice` | 0 Errors | Match |
| `sample_hold` | `layout/sar_adc/blocks/sample_hold/sample_hold.gds` | `cdl/sample_hold.spice` | 0 Errors | Match |
| `shift_reg_8bit` | `layout/sar_adc/blocks/async_sar/shift_reg_8bit.gds` | `cdl/shift_reg_8bit.spice` | 0 Errors | Match |
| `bit_reg` | `layout/sar_adc/blocks/async_sar/bit_reg.gds` | `cdl/bit_reg.spice` | 0 Errors | Match |
| `async_delay_chain` | `layout/sar_adc/blocks/async_sar/async_delay_chain.gds` | `cdl/async_delay_chain.spice` | 0 Errors | Match |
| `async_start_delay` | `layout/sar_adc/blocks/async_sar/async_start_delay.gds` | `cdl/async_start_delay.spice` | 0 Errors | Match |
| `dff_cell` | `layout/sar_adc/blocks/async_sar/dff_cell.gds` | `cdl/dff_cell.spice` | 0 Errors | Match |
| `dff_cell_set` | `layout/sar_adc/blocks/async_sar/dff_cell_set.gds` | `cdl/dff_cell_set.spice` | 0 Errors | Match |
| `async_nor2` | `layout/sar_adc/blocks/async_sar/async_nor2.gds` | `cdl/async_nor2.spice` | 0 Errors | Match |
| `async_nand2` | `layout/sar_adc/blocks/async_sar/async_nand2.gds` | `cdl/async_nand2.spice` | 0 Errors | Match |
| `async_inverter` | `layout/sar_adc/blocks/async_sar/async_inverter.gds` | `cdl/async_inverter.spice` | 0 Errors | Match |
