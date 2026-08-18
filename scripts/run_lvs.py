#!/usr/bin/env python3
"""
Official LVS Runner for Chipathon 2026 SAR ADC
Reads configuration from lvs_config.json, extracts layout using KLayout LVS,
and verifies schematic vs layout equivalence using Netgen.
"""

import os
import sys
import json
import argparse
import subprocess
import shutil

def main():
    parser = argparse.ArgumentParser(description="Run Netgen LVS using lvs_config.json")
    parser.add_argument("--cell", default="async_sar", help="Cell name to run LVS on (default: async_sar)")
    parser.add_argument("--config", default="lvs_config.json", help="Path to lvs_config.json")
    parser.add_argument("--run_dir", default=None, help="Directory to store LVS run outputs")
    args = parser.parse_args()

    # Find project root
    script_dir = os.path.dirname(os.path.abspath(__file__))
    proj_root = os.path.dirname(script_dir) if os.path.basename(script_dir) == "scripts" else script_dir
    
    config_path = os.path.join(proj_root, args.config)
    if not os.path.exists(config_path):
        print(f"[ERROR] Configuration file '{config_path}' not found!")
        sys.exit(1)

    with open(config_path) as f:
        config = json.load(f)

    target_cell = None
    if config["top_level"]["cell_name"] == args.cell:
        target_cell = config["top_level"]
    else:
        for sub in config.get("subcells", []):
            if sub["cell_name"] == args.cell:
                target_cell = sub
                break

    if not target_cell:
        print(f"[ERROR] Cell '{args.cell}' not found in {args.config}!")
        sys.exit(1)

    layout_rel = target_cell["layout_path"]
    netlist_rel = target_cell["netlist_path"]
    layout_path = os.path.join(proj_root, layout_rel)
    netlist_path = os.path.join(proj_root, netlist_rel)

    if not os.path.exists(layout_path):
        print(f"[ERROR] Layout GDS '{layout_path}' does not exist!")
        sys.exit(1)
    if not os.path.exists(netlist_path):
        print(f"[ERROR] Netlist SPICE '{netlist_path}' does not exist!")
        sys.exit(1)

    run_dir = args.run_dir or os.path.join(proj_root, "reports", f"lvs_{args.cell}")
    os.makedirs(run_dir, exist_ok=True)

    lvs_deck = config.get("klayout_lvs_deck", "/foss/pdks/gf180mcuD/libs.tech/klayout/tech/lvs/run_lvs.py")
    lvs_setup = config.get("lvs_setup_file", "/foss/pdks/gf180mcuD/libs.tech/netgen/gf180mcuD_setup.tcl")
    variant = config.get("variant", "D")

    print("=" * 80)
    print(f"CHIPATHON 2026 LVS RUNNER: {args.cell}")
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
        f"--topcell={args.cell}",
        "--top_lvl_pins"
    ]
    res_ext = subprocess.run(" ".join(extract_cmd), shell=True, capture_output=True, text=True)
    
    extracted_cir = os.path.join(run_dir, f"{args.cell}.cir")
    if not os.path.exists(extracted_cir):
        print(f"[ERROR] Extraction failed! Could not find {extracted_cir}")
        print(res_ext.stderr)
        sys.exit(1)
    print(f"      Extracted netlist created: {extracted_cir}")

    # Step 2: Netgen Comparison
    print("[2/2] Running Netgen Equivalence Comparison...")
    comp_out = os.path.join(run_dir, "comp.out")
    netgen_cmd = f'netgen -batch lvs "{extracted_cir} {args.cell}" "{netlist_path} {args.cell}" {lvs_setup} {comp_out}'
    res_netgen = subprocess.run(netgen_cmd, shell=True, capture_output=True, text=True)

    lvs_pass = False
    if os.path.exists(comp_out):
        with open(comp_out) as f:
            log_txt = f.read()
            if "Circuits match uniquely." in log_txt or "Netlists match uniquely." in log_txt:
                lvs_pass = True

    print("=" * 80)
    if lvs_pass:
        print(f"RESULT: [PASS] - Cell '{args.cell}' MATCHES UNIQUELY!")
        print("=" * 80)
        sys.exit(0)
    else:
        print(f"RESULT: [FAIL] - Cell '{args.cell}' MISMATCH!")
        print(f"See detailed report: {comp_out}")
        print("=" * 80)
        sys.exit(1)

if __name__ == "__main__":
    main()
