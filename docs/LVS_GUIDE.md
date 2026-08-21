# GF180MCU Netgen LVS (Layout vs Schematic) Guide

Panduan resmi dan instruksi eksekusi verifikasi **Layout vs. Schematic (LVS)** untuk proyek **8-Bit Asynchronous SAR ADC** (`chipathon26-SAR_ADC`) pada proses **GF180MCU 5LM Option B (Variant D)**.

---

## 1. Ikhtisar Arsitektur LVS

Proses LVS membandingkan konektivitas jaringan, jenis perangkat, dan parameter geometris antara:
1. **Rangkaian Skematik (Circuit 1 / Circuit 2)**: Berasal dari skematik Xschem (`xschem/sar_adc/sar_adc_top.spice`).
2. **Tata Letak Fisik (Layout Extraction)**: Diekstrak dari file GDSII (`layout/sar_adc/sar_adc_top.gds`) menggunakan Magic VLSI (`ext2spice lvs`).

### File Konfigurasi LVS
- **Setup File Netgen**: `lvs/gf180mcuD_setup.tcl`
  - Mengatur ekuivalensi nama pin, permutasi gerbang simetris (*parallel/series reduction*), dan toleransi dimensi komponen (*W, L, Area, Perimeter*).
- **Skrip Eksekusi Runner**: `scripts/run_netgen_lvs.sh`

---

## 2. Cara Menjalankan Netgen LVS

### A. Verifikasi Otomatis Menggunakan Script Runner (Direkomendasikan)

Untuk menjalankan LVS satu-perintah pada top-level ADC atau sub-blok:

```bash
# 1. Menjalankan LVS pada SAR ADC Core Macro:
./scripts/run_netgen_lvs.sh layout/sar_adc/sar_adc_top.gds sar_adc_top xschem/sar_adc/sar_adc_top.spice

# 2. Menjalankan LVS pada Full Chip (dengan Bondpad Ring):
./scripts/run_netgen_lvs.sh layout/sar_adc/sar_adc_chip.gds sar_adc_chip xschem/sar_adc/sar_adc_top.spice

# 3. Menjalankan LVS pada Sub-Blok Individual (misal Sample & Hold):
./scripts/run_netgen_lvs.sh layout/sar_adc/blocks/sample_hold/sample_hold.gds sample_hold xschem/sar_adc/sample_hold.spice
```

---

### B. Menjalankan Manual di Dalam Lingkungan IIC-OSIC-Tools Docker

Jika Anda masuk ke dalam container Docker (`iic-osic-tools`):

```bash
# Langkah 1: Ekstraksi LVS dari Layout GDS menggunakan Magic
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

# Langkah 2: Eksekusi Perbandingan Netgen LVS
netgen -batch lvs \
    "lvs/reports/sar_adc_top_extracted.spice sar_adc_top" \
    "xschem/sar_adc/sar_adc_top.spice sar_adc_top" \
    "lvs/gf180mcuD_setup.tcl" \
    "lvs/reports/sar_adc_top_comp.out"
```

---

## 3. Membaca & Memahami Laporan Hasil LVS (`*.comp.out`)

Setelah Netgen selesai, buka file laporan di `lvs/reports/<cell_name>_comp.out`:

### Status 1: Lolos Bersih (100% LVS Clean)
Ditandai dengan pesan di akhir file laporan:
```
Circuits match uniquely.
Result: Netlist elements match completely.
Logging to comp.out finished with 0 errors.
```

### Status 2: Pin / Port Mismatch
Jika seluruh transistor dan jaringan internal identik namun ada perbedaan nama pin pada port top-level (misal `vin` vs `vin_p`), Netgen akan melaporkan:
```
Device classes sar_adc_top and sar_adc_top are equivalent.
Final result: Top level cell failed pin matching.
```
*Solusi: Pastikan label teks port pada lapisan Metal di GDS (Layer 42/10 M3 text atau 81/10 M5 text) sama persis dengan nama pin pada skematik.*

---

## 4. Lokasi Laporan & File Output

| File | Deskripsi |
| :--- | :--- |
| **`lvs/reports/<cell>_extracted.spice`** | Netlist SPICE hasil ekstraksi bersih (*flat/hierarchical*) dari Magic GDS. |
| **`lvs/reports/<cell>_comp.out`** | Laporan perbandingan visual detail Netgen (tabel perangkat, jala, dan pin). |
| **`lvs/reports/<cell>_lvs.log`** | Catatan eksekusi Netgen CLI. |
