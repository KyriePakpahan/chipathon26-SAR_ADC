#!/usr/bin/env python3
"""
Official DRC Runner for Chipathon 2026 SAR ADC
Runs official GF180MCU PDK DRC (variant D) on specified layout or top-level.
"""

import os
import sys
import json
import argparse
import subprocess

def find_gds_path(proj_root, cell_name):
    candidate_paths = [
        os.path.join(proj_root, "layout", "sar_adc", "blocks", "async_sar", f"{cell_name}.gds"),
        os.path.join(proj_root, "layout", "sar_adc", "blocks", "comparator", f"{cell_name}.gds"),
        os.path.join(proj_root, "layout", "sar_adc", "blocks", "sample_hold", f"{cell_name}.gds"),
        os.path.join(proj_root, "layout", "sar_adc", "blocks", "cdac", f"{cell_name}.gds"),
        os.path.join(proj_root, "layout", "sar_adc", f"{cell_name}.gds"),
        os.path.join(proj_root, "layout", f"{cell_name}.gds"),
    ]
    for p in candidate_paths:
        if os.path.exists(p):
            return p
    return None

def main():
    parser = argparse.ArgumentParser(description="Run GF180MCU DRC using PDK deck")
    parser.add_argument("--cell", default="async_sar", help="Cell name to run DRC on (default: async_sar)")
    parser.add_argument("--gds", default=None, help="Explicit GDS path (optional)")
    parser.add_argument("--config", default="lvs_config.json", help="Path to lvs_config.json")
    parser.add_argument("--run_dir", default=None, help="Directory to store DRC run outputs")
    args = parser.parse_args()

    script_dir = os.path.dirname(os.path.abspath(__file__))
    proj_root = os.path.dirname(script_dir) if os.path.basename(script_dir) == "scripts" else script_dir

    gds_path = args.gds or find_gds_path(proj_root, args.cell)

    if not gds_path or not os.path.exists(gds_path):
        print(f"[ERROR] Layout GDS for cell '{args.cell}' not found!")
        sys.exit(1)

    run_dir = args.run_dir or os.path.join(proj_root, "reports", f"drc_{args.cell}")
    os.makedirs(run_dir, exist_ok=True)

    drc_deck = "/foss/pdks/gf180mcuD/libs.tech/klayout/tech/drc/run_drc.py"
    variant = "D"

    print("=" * 80)
    print(f"CHIPATHON 2026 DRC RUNNER: {args.cell}")
    print("=" * 80)
    print(f"Layout Path  : {gds_path}")
    print(f"Run Output   : {run_dir}")
    print(f"PDK Variant  : {variant}")
    print("-" * 80)

    drc_cmd = [
        "python3", drc_deck,
        f"--path={gds_path}",
        f"--variant={variant}",
        f"--run_dir={run_dir}"
    ]
    res_drc = subprocess.run(" ".join(drc_cmd), shell=True, capture_output=True, text=True)

    drc_clean = False
    log_path = None
    if os.path.exists(run_dir):
        for fname in os.listdir(run_dir):
            if fname.startswith("drc_run_") and fname.endswith(".log"):
                log_path = os.path.join(run_dir, fname)
                with open(log_path) as f:
                    txt = f.read()
                    if "Klayout DRC run is clean. GDS has no DRC violations." in txt:
                        drc_clean = True
                        break

    print("=" * 80)
    if drc_clean:
        print(f"RESULT: [PASS] - Cell '{args.cell}' HAS 0 DRC VIOLATIONS (CLEAN)!")
        print("=" * 80)
        sys.exit(0)
    else:
        print(f"RESULT: [FAIL] - DRC Violations detected for '{args.cell}'!")
        if log_path:
            print(f"See log file: {log_path}")
        print("=" * 80)
        sys.exit(1)

if __name__ == "__main__":
    main()
