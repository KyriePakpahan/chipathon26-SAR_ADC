#!/usr/bin/env python3
"""
Comprehensive Verification Suite: All Cells DRC & LVS Runner
Runs official GF180MCU DRC and Netgen LVS across all 10 layout blocks.
"""

import os
import sys
import json
import subprocess

def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    proj_root = os.path.dirname(script_dir) if os.path.basename(script_dir) == "scripts" else script_dir

    config_path = os.path.join(proj_root, "lvs_config.json")
    with open(config_path) as f:
        config = json.load(f)

    all_cells = [config["top_level"]["cell_name"]] + [s["cell_name"] for s in config.get("subcells", [])]

    print("=" * 80)
    print("CHIPATHON 2026: COMPREHENSIVE DRC & LVS VERIFICATION SUITE")
    print("=" * 80)

    results = []
    overall_pass = True

    for cell in all_cells:
        print(f">> Verifying [{cell}]...")
        # 1. DRC
        drc_proc = subprocess.run(
            [sys.executable, os.path.join(script_dir, "run_drc.py"), "--cell", cell],
            capture_output=True, text=True
        )
        drc_ok = (drc_proc.returncode == 0)

        # 2. LVS
        lvs_proc = subprocess.run(
            [sys.executable, os.path.join(script_dir, "run_lvs.py"), "--cell", cell],
            capture_output=True, text=True
        )
        lvs_ok = (lvs_proc.returncode == 0)

        if not (drc_ok and lvs_ok):
            overall_pass = False

        drc_str = "PASS (0 errors)" if drc_ok else "FAIL"
        lvs_str = "PASS (Match)" if lvs_ok else "FAIL"
        results.append((cell, drc_str, lvs_str))

    print("\n" + "=" * 80)
    print("FINAL SUMMARY MATRIX")
    print("=" * 80)
    print(f"| {'Cell / Block Name':22s} | {'DRC Status':20s} | {'LVS Status':18s} |")
    print("| " + "-"*22 + " | " + "-"*20 + " | " + "-"*18 + " |")
    for cell, drc_s, lvs_s in results:
        print(f"| {cell:22s} | {drc_s:20s} | {lvs_s:18s} |")
    print("=" * 80)

    if overall_pass:
        print(">> ALL CELLS AND TOP-LEVEL 100% PASSED (0 DRC VIOLATIONS & 100% LVS MATCH) <<")
        sys.exit(0)
    else:
        print(">> ONE OR MORE CELLS FAILED! <<")
        sys.exit(1)

if __name__ == "__main__":
    main()
