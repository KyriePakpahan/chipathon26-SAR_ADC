# 8-Bit 10 MS/s Asynchronous SAR ADC (Chipathon 2026)

[![DRC Status](https://img.shields.io/badge/DRC-PASS%20(0%20errors)-brightgreen)](docs/VERIFICATION.md)
[![LVS Status](https://img.shields.io/badge/LVS-MATCH%20(100%25)-brightgreen)](docs/VERIFICATION.md)
[![PDK](https://img.shields.io/badge/PDK-GF180MCU--D%20(3.3V)-blue)](info.yaml)
[![Team](https://img.shields.io/badge/Team-A49%20Berkah%20Saluyu%20Team-orange)](info.yaml)

Rancangan sirkuit terpadu monolitik **8-Bit 10 MS/s Asynchronous Successive Approximation Register (SAR) Analog-to-Digital Converter (ADC)** menggunakan proses semikonduktor terbuka **GlobalFoundries 180nm MCU (GF180MCU Variant D, 3.3V)** untuk kompetisi **IEEE CASS Chipathon 2026**.

---

## Ringkasan Spesifikasi Kinerja

| Parameter | Spesifikasi / Nilai | Satuan |
| :--- | :--- | :---: |
| **Teknologi PDK** | GlobalFoundries GF180MCU (Variant D) | 180 nm |
| **Tegangan Suplai ($V_{DD}$)** | 3.3 | V |
| **Resolusi** | 8 | Bit |
| **Kecepatan Sampling ($f_s$)** | 10 | MS/s |
| **Periode Konversi ($T_{conv}$)** | 100 | ns |
| **Metode Clocking** | Asynchronous / Self-Timed (Internal Completion Detector) | - |
| **Rentang Sinyal Input ($V_{in}$)** | 0.45 – 2.85 ($2.4\text{ V}_{pp}$ differential swing) | V |
| **Resolusi Tegangan (1 LSB)** | 12.89 | mV |
| **Target ENOB** | **> 7.0** | Bit |
| **Target SNDR** | **> 44.0** | dB |
| **Jumlah Total Transistor** | 736 (368 PMOS + 368 NMOS) | Devices |
| **Status Fisik DRC & LVS** | **100% PASS / 0 Violations (HIJAU)** | - |

---

## Panduan Cepat Menjalankan Verifikasi (Quick Start)

Untuk menjalankan pemeriksaan **DRC (Design Rule Checking)** dan **LVS (Layout Versus Schematic)** secara instan, gunakan container Docker resmi `iic-osic-tools:chipathon26`:

### 1. Masuk ke Lingkungan Docker
```bash
docker run --rm -it \
  -v $(pwd):/foss/designs/chipathon26-SAR_ADC \
  -w /foss/designs/chipathon26-SAR_ADC \
  hpretl/iic-osic-tools:chipathon26 --skip bash
```

### 2. Jalankan Perintah Verifikasi (Make Targets)

```bash
# 1. Jalankan DRC pada Top-Level Layout (async_sar.gds)
make drc

# 2. Jalankan Netgen LVS pada Top-Level (async_sar.gds vs cdl/async_sar.spice)
make lvs

# 3. Jalankan Full Test Suite (DRC & LVS seluruh 10 blok layout)
make verify
```

---

### Alternatif: Jalankan Langsung dari Terminal Host (Satu Baris)

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

## Matriks Hasil Verifikasi Fisik (10/10 Cells Clean)

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

## Struktur Direktori Repositori

```text
chipathon26-SAR_ADC/
├── info.yaml                  # Manifest & Metadata Proyek Resmi Chipathon 2026
├── lvs_config.json            # Konfigurasi LVS Terpusat (KLayout & Netgen)
├── Makefile                   # Make targets (make drc, make lvs, make verify)
├── cdl/                       # Golden SPICE Netlists untuk LVS
│   ├── async_sar.spice        # Golden Top-Level Netlist (736 MOSFETs, 355 Nets)
│   ├── bit_reg.spice
│   ├── shift_reg_8bit.spice
│   └── ... (seluruh netlist subcell)
├── layout/                    # Layout Fisik GDSII Bersih (100% DRC Clean)
│   ├── async_sar.gds          # Top-Level Layout (880 um x 140 um)
│   ├── bit_reg.gds
│   ├── shift_reg_8bit.gds
│   └── ... (seluruh layout subcell)
├── scripts/                   # Generator Layout & Test Runner Otomatis
│   ├── build_async_sar.py     # Python builder top-level
│   ├── run_drc.py             # Official GF180MCU DRC Runner
│   ├── run_lvs.py             # Official Netgen LVS Runner (via lvs_config.json)
│   ├── verify_all.py          # Full verification suite script
│   └── ...
├── docs/                      # Dokumentasi Teknis & Panduan
│   ├── VERIFICATION.md        # Panduan teknis lengkap DRC & LVS tim
│   ├── PRD_8bit_Async_SAR_... # Spesifikasi Produk & Arsitektur
│   └── images/                # Waveform hasil simulasi & grafik performa
└── xschem/                    # Skematik Xschem Analog & Testbench
    └── sar_adc/               # Skematik SAR ADC, CDAC, Komparator, & SH
```

---

## Daftar Pin I/O Top-Level (`async_sar`)

| Pin Name | Tipe | Deskripsi |
| :--- | :---: | :--- |
| `vdd` | Power | Rel tegangan suplai utama 3.3V |
| `vss` | Ground | Rel ground utama 0.0V |
| `start` | Input | Pemicu konversi & kontrol sampling bottom-plate |
| `comp_done` | Input | Handshake sinyal siap dari completion detector komparator |
| `comp_out_p` | Input | Bit keputusan komparator positif |
| `sample_en` | Output | Pulsa enable driver switch sampling |
| `rst_latch` | Output | Sinyal reset & evaluasi komparator StrongARM |
| `done` | Output | Flag selesai konversi (*End of Conversion* / EOC) |
| `dout[7:0]` | Output Bus | 8-bit kata digital output teregistrasi (MSB: `dout[7]`) |
| `dac_in[7:0]` | Output Bus | 8-bit jalur kendali switching kapasitor CDAC |

---

## Lisensi & Kontribusi
Proyek ini dikembangkan oleh **A49 Berkah Saluyu Team** untuk **IEEE CASS Chipathon 2026** di bawah lisensi [Apache-2.0](LICENSE).
