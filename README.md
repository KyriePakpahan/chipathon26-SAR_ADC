# 8-bit Asynchronous SAR ADC

**IEEE SSCS Chipathon 2026 — Track A**

**Team A49 — Berkah Saluyu**

This repository contains the design files, schematics, layout, and
verification files for an 8-bit asynchronous Successive Approximation
Register (SAR) ADC developed for the IEEE SSCS Chipathon 2026.

## Project Overview

The project implements an 8-bit asynchronous SAR ADC.

The design is developed hierarchically using several circuit blocks.
Each block is progressively designed, simulated, laid out, and
physically verified before being integrated into the complete ADC.

The main blocks developed in the repository include:

- Asynchronous SAR logic
- Dynamic StrongARM comparator
- Sample-and-hold circuitry
- Capacitive DAC (CDAC)
- SAR ADC top-level integration

## Project Information

| Parameter | Value |
|---|---|
| Project | 8-bit Asynchronous SAR ADC |
| Team | A49 Berkah Saluyu |
| Track | IEEE SSCS Chipathon 2026 — Track A |
| PDK | GF180MCU |

The project uses the GF180MCU PDK and open-source EDA tools for
schematic design, circuit simulation, layout, and physical
verification.

## Repository Structure

```text
.
├── xschem/
│   └── sar_adc/
│       ├── blocks/
│       │   ├── comparator/
│       │   │   ├── *.sch
│       │   │   └── *.spice
│       │   │
│       │   ├── sample_hold/
│       │   │   ├── *.sch
│       │   │   └── *.spice
│       │   │
│       │   ├── async_sar/
│       │   └── ...
│       │
│       └── ...
│
├── layout/
│   └── sar_adc/
│       └── blocks/
│           ├── comparator/
│           │   ├── *.gds
│           │   ├── *.cir
│           │   ├── *.lvsdb
│           │   └── ...
│           │
│           ├── sample_hold/
│           │   ├── *.gds
│           │   ├── *.cir
│           │   ├── *.lvsdb
│           │   └── ...
│           │
│           ├── async_sar/
│           │   └── ...
│           │
│           └── ...
│
├── src/
│   └── ...
│
├── cocotb/
│   └── ...
│
├── librelane/
│   └── ...
│
├── scripts/
│   └── ...
│
├── docs/
│   └── ...
│
├── examples/
│   └── ...
│
├── info.yaml
├── lvs_config.json
├── Makefile
└── README.md
```

## License

Apache-2.0, inherited from upstream. See `LICENSE` for the full text,
`NOTICE` for attribution of third-party material, and `AUTHORS.md`
for the list of copyright holders.
