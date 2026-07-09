# StrongARM Comparator Testbench

## File utama
- `tb_strongarm_final.sch`

## Kondisi simulasi
- PDK: GF180MCU
- Corner: typical
- VDD: 3.3 V
- rst_latch: `pulse(0 3.3 1n 100p 100p 4n 10n)`

## Kondisi uji
1. VCM = 0.8 V, ΔVin = +5 mV
2. VCM = 0.8 V, ΔVin = -5 mV
3. VCM = 2.5 V, ΔVin = +5 mV
4. VCM = 2.5 V, ΔVin = -5 mV

## Polaritas hasil
- vin_p > vin_n → out_p rendah, out_n tinggi
- vin_p < vin_n → out_p tinggi, out_n rendah
