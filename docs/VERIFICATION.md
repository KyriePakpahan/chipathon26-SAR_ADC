# Panduan Verifikasi DRC & LVS (Chipathon 2026)

Dokumen ini berisi panduan bagi anggota tim untuk menjalankan verifikasi **Design Rule Checking (DRC)** dan **Layout Versus Schematic (LVS)** pada modul **8-Bit Asynchronous SAR ADC Logic** (`async_sar`) dan seluruh subcell-nya.

---

## 1. Lingkungan Kerja (Prerequisites)

Verifikasi menggunakan container standar **IIC-OSIC-Tools**:
- Docker image: `hpretl/iic-osic-tools:chipathon26`
- PDK: **GlobalFoundries GF180MCU (Variant D, 3.3V)**
- Tools: **KLayout 0.29+** (Layout & Extraction), **Netgen 1.5+** (LVS Comparator)

---

## 2. Cara Menjalankan Verifikasi Cepat (Quick Start)

### A. Masuk ke Lingkungan Docker (Interactive Shell)
```bash
docker run --rm -it \
  -v $(pwd):/foss/designs/chipathon26-SAR_ADC \
  -w /foss/designs/chipathon26-SAR_ADC \
  hpretl/iic-osic-tools:chipathon26 --skip bash
```

### B. Menjalankan Verifikasi via `make`
Di dalam container, jalankan:

1. **Jalankan DRC pada Top-Level (`async_sar.gds`):**
   ```bash
   make drc
   ```
   *Output yang diharapkan: `RESULT: [PASS] - Cell 'async_sar' HAS 0 DRC VIOLATIONS (CLEAN)!`*

2. **Jalankan Netgen LVS pada Top-Level (`async_sar`):**
   ```bash
   make lvs
   ```
   *Output yang diharapkan: `RESULT: [PASS] - Cell 'async_sar' MATCHES UNIQUELY!`*

3. **Jalankan Test Suite Lengkap (DRC & LVS seluruh 10 blok):**
   ```bash
   make verify
   ```

---

### C. Menjalankan Langsung via Perintah Satu Baris (Host / Non-Interactive)

Jika Anda ingin menjalankan langsung dari terminal host tanpa masuk ke dalam Docker:

```bash
# 1. DRC Top-Level
docker run --rm -v $(pwd):/foss/designs/chipathon26-SAR_ADC -w /foss/designs/chipathon26-SAR_ADC \
  hpretl/iic-osic-tools:chipathon26 --skip python3 scripts/run_drc.py

# 2. LVS Top-Level
docker run --rm -v $(pwd):/foss/designs/chipathon26-SAR_ADC -w /foss/designs/chipathon26-SAR_ADC \
  hpretl/iic-osic-tools:chipathon26 --skip python3 scripts/run_lvs.py

# 3. Full Suite (10 Cell)
docker run --rm -v $(pwd):/foss/designs/chipathon26-SAR_ADC -w /foss/designs/chipathon26-SAR_ADC \
  hpretl/iic-osic-tools:chipathon26 --skip python3 scripts/verify_all.py
```

---

## 3. Struktur File Konfigurasi & Netlist

| File / Folder | Keterangan |
| :--- | :--- |
| **[`info.yaml`](file:///home/kyrie/eda/designs/chipathon26-SAR_ADC/info.yaml)** | Manifest proyek resmi Chipathon 2026 (spesifikasi, pinout I/O, deskripsi arsitektur). |
| **[`lvs_config.json`](file:///home/kyrie/eda/designs/chipathon26-SAR_ADC/lvs_config.json)** | Konfigurasi LVS terpusat (path GDS, golden netlist CDL, setup rule GF180MCU). |
| **[`cdl/`](file:///home/kyrie/eda/designs/chipathon26-SAR_ADC/cdl)** | Folder penyimpan seluruh golden SPICE/CDL netlist standar LVS. |
| **[`layout/`](file:///home/kyrie/eda/designs/chipathon26-SAR_ADC/layout)** | Folder penyimpan seluruh file fisik layout `.gds`. |
| **`reports/`** | Folder penyimpan log hasil ekstraksi `.cir` dan perbandingan `comp.out`. |

---

## 4. Matriks Blok & Spesifikasi Perangkat

| Nama Cell / Blok | Lokasi GDS | Golden Netlist | Jumlah Transistor | DRC Status | LVS Status |
| :--- | :--- | :--- | :---: | :---: | :---: |
| **`async_sar` (TOP)** | `layout/async_sar.gds` | `cdl/async_sar.spice` | 736 MOSFETs | **0 Errors** | **Match** |
| `shift_reg_8bit` | `layout/shift_reg_8bit.gds` | `cdl/shift_reg_8bit.spice` | 184 MOSFETs | **0 Errors** | **Match** |
| `bit_reg` | `layout/bit_reg.gds` | `cdl/bit_reg.spice` | 28 MOSFETs | **0 Errors** | **Match** |
| `async_delay_chain`| `layout/async_delay_chain.gds`| `cdl/async_delay_chain.spice`| 42 MOSFETs | **0 Errors** | **Match** |
| `async_start_delay`| `layout/async_start_delay.gds`| `cdl/async_start_delay.spice`| 90 MOSFETs | **0 Errors** | **Match** |
| `dff_cell` | `layout/dff_cell.gds` | `cdl/dff_cell.spice` | 20 MOSFETs | **0 Errors** | **Match** |
| `dff_cell_set` | `layout/dff_cell_set.gds` | `cdl/dff_cell_set.spice` | 24 MOSFETs | **0 Errors** | **Match** |
| `async_nor2` | `layout/async_nor2.gds` | `cdl/async_nor2.spice` | 10 MOSFETs | **0 Errors** | **Match** |
| `async_nand2` | `layout/async_nand2.gds` | `cdl/async_nand2.spice` | 4 MOSFETs | **0 Errors** | **Match** |
| `async_inverter` | `layout/async_inverter.gds` | `cdl/async_inverter.spice` | 2 MOSFETs | **0 Errors** | **Match** |
