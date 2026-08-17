#!/usr/bin/env python3
"""
Official LVS Runner for Chipathon 2026 SAR ADC
Extracts layout using KLayout LVS and verifies schematic vs layout equivalence using Netgen.
Reads standard lvs_config.json or target cell.
"""

import os
import sys
import json
import argparse
import subprocess
import shutil

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

def find_netlist_path(proj_root, cell_name):
    candidate_paths = [
        os.path.join(proj_root, "cdl", f"{cell_name}.spice"),
        os.path.join(proj_root, "xschem", "sar_adc", f"{cell_name}.spice"),
        os.path.join(proj_root, "xschem", "sar_adc", "blocks", "async_sar", f"{cell_name}.spice"),
        os.path.join(proj_root, "xschem", "sar_adc", "blocks", "comparator", f"{cell_name}.spice"),
        os.path.join(proj_root, "xschem", "sar_adc", "blocks", "sample_hold", f"{cell_name}.spice"),
    ]
    for p in candidate_paths:
        if os.path.exists(p):
            return p
    return None

def main():
    parser = argparse.ArgumentParser(description="Run Netgen LVS using standard configuration")
    parser.add_argument("--cell", default="async_sar", help="Cell name to run LVS on (default: async_sar)")
    parser.add_argument("--config", default="lvs_config.json", help="Path to lvs_config.json")
    parser.add_argument("--layout", default=None, help="Explicit layout GDS path")
    parser.add_argument("--netlist", default=None, help="Explicit netlist SPICE path")
    parser.add_argument("--run_dir", default=None, help="Directory to store LVS run outputs")
    args = parser.parse_args()

    script_dir = os.path.dirname(os.path.abspath(__file__))
    proj_root = os.path.dirname(script_dir) if os.path.basename(script_dir) == "scripts" else script_dir
    
    cell_name = args.cell
    layout_path = args.layout or find_gds_path(proj_root, cell_name)
    netlist_path = args.netlist or find_netlist_path(proj_root, cell_name)

    if not layout_path or not os.path.exists(layout_path):
        print(f"[ERROR] Layout GDS for '{cell_name}' not found!")
        sys.exit(1)
    if not netlist_path or not os.path.exists(netlist_path):
        print(f"[ERROR] Netlist SPICE for '{cell_name}' not found!")
        sys.exit(1)

    run_dir = args.run_dir or os.path.join(proj_root, "reports", f"lvs_{cell_name}")
    os.makedirs(run_dir, exist_ok=True)

    lvs_deck = "/foss/pdks/gf180mcuD/libs.tech/klayout/tech/lvs/run_lvs.py"
    lvs_setup = "/foss/pdks/gf180mcuD/libs.tech/netgen/gf180mcuD_setup.tcl"
    variant = "D"

    print("=" * 80)
    print(f"CHIPATHON 2026 LVS RUNNER: {cell_name}")
    print("=" * 80)
    print(f"Layout Path  : {layout_path}")
    print(f"Netlist Path : {netlist_path}")
    print(f"Run Output   : {run_dir}")
    print(f"PDK Variant  : {variant}")
    print("-" * 80)

    # Step 1: KLayout Extraction
    print("[1/2] Running KLayout Netlist Extraction...")
    extract_cmd = [
        "python3", lvs_deck,
        f"--layout={layout_path}",
        f"--netlist={netlist_path}",
        f"--variant={variant}",
        f"--run_dir={run_dir}",
        f"--topcell={cell_name}",
        "--top_lvl_pins"
    ]
    res_ext = subprocess.run(" ".join(extract_cmd), shell=True, capture_output=True, text=True)
    
    extracted_cir = os.path.join(run_dir, f"{cell_name}.cir")
    if not os.path.exists(extracted_cir):
        print(f"[ERROR] Extraction failed! Could not find {extracted_cir}")
        print(res_ext.stderr)
        sys.exit(1)
    print(f"      Extracted netlist created: {extracted_cir}")

    # Step 2: Netgen Comparison
    print("[2/2] Running Netgen Equivalence Comparison...")
    comp_out = os.path.join(run_dir, "comp.out")
    netgen_cmd = f'netgen -batch lvs "{extracted_cir} {cell_name}" "{netlist_path} {cell_name}" {lvs_setup} {comp_out}'
    res_netgen = subprocess.run(netgen_cmd, shell=True, capture_output=True, text=True)

    # Step 3: Analyze Result
    lvs_match = False
    if os.path.exists(comp_out):
        with open(comp_out) as f:
            txt = f.read()
            if "Circuits match uniquely." in txt or "Netlists match uniquely." in txt:
                lvs_match = True

    print("=" * 80)
    if lvs_match:
        print(f"RESULT: [PASS] - Cell '{cell_name}' CIRCUITS MATCH UNIQUELY (100% LVS CLEAN)!")
        print("=" * 80)
        sys.exit(0)
    else:
        print(f"RESULT: [FAIL] - LVS Mismatch detected for '{cell_name}'!")
        if os.path.exists(comp_out):
            print(f"See Netgen output: {comp_out}")
        print("=" * 80)
        sys.exit(1)

if __name__ == "__main__":
    main()
