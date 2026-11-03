# Panduan Netgen LVS (Layout vs. Schematic) — GF180MCU Variant D

Dokumen ini menjelaskan prosedur verifikasi Layout Versus Schematic (LVS) untuk proyek 8-Bit Asynchronous SAR ADC (`sar_adc_top`) pada teknologi GF180MCU Variant D (5LM, MIM-B).

---

## 1. Alur LVS

Verifikasi LVS membandingkan dua netlist:
1. Golden schematic netlist: `cdl/sar_adc_top.spice` (atau sub-blok terkait di `cdl/`).
2. Layout-extracted netlist: Diekstrak dari `layout/sar_adc/sar_adc_top.gds` menggunakan Magic VLSI (`ext2spice lvs`).

File konfigurasi yang digunakan:
- Setup deck Netgen: [`lvs/gf180mcuD_setup.tcl`](../lvs/gf180mcuD_setup.tcl)
- Script runner: [`scripts/run_netgen_lvs.sh`](../scripts/run_netgen_lvs.sh)
- Konfigurasi otomatis Chipathon: [`lvs_config.json`](../lvs_config.json)

---

## 2. Menjalankan Netgen LVS

### A. Menggunakan Script Runner

```bash
# 1. Top-level SAR ADC macro (sar_adc_top)
./scripts/run_netgen_lvs.sh layout/sar_adc/sar_adc_top.gds sar_adc_top cdl/sar_adc_top.spice

# 2. Sub-blok individual (contoh: sample_hold dan cdac_8bit)
./scripts/run_netgen_lvs.sh layout/sar_adc/blocks/sample_hold/sample_hold.gds sample_hold cdl/sample_hold.spice
./scripts/run_netgen_lvs.sh layout/sar_adc/blocks/cdac/cdac_8bit.gds cdac_8bit cdl/cdac_8bit.spice
```

### B. Langkah Manual di Dalam Container IIC-OSIC-Tools

```bash
# Langkah 1: Ekstraksi netlist LVS dari GDS menggunakan Magic
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

# Langkah 2: Perbandingan netlist dengan Netgen
netgen -batch lvs \
  "lvs/reports/sar_adc_top_extracted.spice sar_adc_top" \
  "cdl/sar_adc_top.spice sar_adc_top" \
  "lvs/gf180mcuD_setup.tcl" \
  "lvs/reports/sar_adc_top_comp.out"
```

---

## 3. Membaca Laporan Hasil LVS (`*_comp.out`)

Buka file laporan di `lvs/reports/sar_adc_top_comp.out`.

### Hasil LVS Bersih (Match)
Bagian akhir laporan menampilkan:
```text
Device classes sar_adc_top and sar_adc_top are equivalent.
Circuits match uniquely.
Result: Netlist elements match completely.
Logging to comp.out finished with 0 errors.
```

### Jika Terjadi Pin Mismatch
Jika seluruh perangkat internal cocok tetapi nama port top-level berbeda, Netgen menampilkan:
```text
Device classes sar_adc_top and sar_adc_top are equivalent.
Final result: Top level cell failed pin matching.
```
Pastikan label teks pada layer metal di GDS sesuai dengan daftar 14 pin pada [`info.yaml`](../info.yaml) dan [`cdl/sar_adc_top.spice`](../cdl/sar_adc_top.spice).

---

## 4. Lokasi File Output

| File | Deskripsi |
| :--- | :--- |
| `lvs/reports/<cell>_extracted.spice` | Netlist SPICE hasil ekstraksi Magic dari GDS |
| `lvs/reports/<cell>_comp.out` | Laporan perbandingan perangkat, net, dan pin dari Netgen |
| `lvs/reports/<cell>_lvs.log` | Log eksekusi Netgen |
