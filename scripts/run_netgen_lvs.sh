#!/usr/bin/env bash
# ==============================================================================
# Netgen LVS Automated Verification Runner for GF180MCU
# Usage:
#   ./scripts/run_netgen_lvs.sh [GDS_PATH] [CELL_NAME] [SCHEMATIC_SPICE]
# Example:
#   ./scripts/run_netgen_lvs.sh layout/sar_adc/sar_adc_top.gds sar_adc_top xschem/sar_adc/sar_adc_top.spice
# ==============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PRJ_DIR="$(dirname "$SCRIPT_DIR")"

GDS_PATH="$(realpath "${1:-$PRJ_DIR/layout/sar_adc/sar_adc_top.gds}")"
CELL_NAME="${2:-sar_adc_top}"
SCH_SPICE="$(realpath "${3:-$PRJ_DIR/netlist/sar_adc_top_golden.spice}")"

OUT_DIR="$PRJ_DIR/lvs/reports"
mkdir -p "$OUT_DIR"

MAGIC_RC="/foss/pdks/gf180mcuD/libs.tech/magic/gf180mcuD.magicrc"
NETGEN_SETUP="$PRJ_DIR/lvs/gf180mcuD_setup.tcl"
if [ ! -f "$NETGEN_SETUP" ]; then
    NETGEN_SETUP="/foss/pdks/gf180mcuD/libs.tech/netgen/gf180mcuD_setup.tcl"
fi

EXT_SPICE="$OUT_DIR/${CELL_NAME}_extracted.spice"
LVS_LOG="$OUT_DIR/${CELL_NAME}_lvs.log"
COMP_OUT="$OUT_DIR/${CELL_NAME}_comp.out"

echo "================================================================="
echo " [NETGEN LVS] Starting Verification for: $CELL_NAME"
echo "  - GDS Layout    : $GDS_PATH"
echo "  - Schematic     : $SCH_SPICE"
echo "  - Setup File    : $NETGEN_SETUP"
echo "  - Output Log    : $COMP_OUT"
echo "================================================================="

# Step 1: Magic Layout Extraction for LVS
echo ">> [1/2] Extracting clean LVS SPICE netlist using Magic..."
EXT_DIR="$OUT_DIR/magic_ext_${CELL_NAME}"
mkdir -p "$EXT_DIR"
(
cd "$EXT_DIR"
magic -dnull -noconsole -rcfile "$MAGIC_RC" << MAG_EOF > "$OUT_DIR/${CELL_NAME}_magic_ext.log" 2>&1
gds read $GDS_PATH
load $CELL_NAME
select top cell
extract all
ext2spice lvs
ext2spice format ngspice
ext2spice -o $EXT_SPICE
quit -noprompt
MAG_EOF
)

if [ ! -f "$EXT_SPICE" ]; then
    echo "[ERROR] Magic LVS extraction failed. Check $OUT_DIR/${CELL_NAME}_magic_ext.log"
    exit 1
fi
echo "   [OK] Extracted: $EXT_SPICE ($(wc -l < "$EXT_SPICE") lines)"

# Step 2: Running Netgen LVS Comparison
echo ">> [2/2] Running Netgen LVS comparison..."
netgen -batch lvs "$EXT_SPICE $CELL_NAME" "$SCH_SPICE $CELL_NAME" "$NETGEN_SETUP" "$COMP_OUT" > "$LVS_LOG" 2>&1

echo "================================================================="
echo " [NETGEN LVS RESULTS SUMMARY]"
echo "================================================================="

# Strict Anti-False-Positive Verification Check
IS_MATCH=0
if grep -q "Circuits match uniquely\." "$COMP_OUT"; then
    IS_MATCH=1
fi

if grep -qi "failed pin matching" "$COMP_OUT" || \
   grep -qi "Netlists do not match" "$COMP_OUT" || \
   grep -qi "NET mismatches" "$COMP_OUT" || \
   grep -qi "DEVICE mismatches" "$COMP_OUT" || \
   grep -qi "Property errors were found" "$COMP_OUT"; then
    IS_MATCH=0
fi

if [ $IS_MATCH -eq 1 ]; then
    echo " [PASS] Circuits match uniquely! 100% LVS Clean (Zero False Positives)."
    echo " Report: $COMP_OUT"
    echo "================================================================="
    exit 0
else
    echo " [FAIL] LVS Verification FAILED! Mismatch or Pin Failure Detected."
    echo " Details from $COMP_OUT:"
    echo "-----------------------------------------------------------------"
    tail -n 35 "$COMP_OUT"
    echo "================================================================="
    exit 1
fi
