import os
import glob
import subprocess

sch_files = glob.glob('xschem/**/*.sch', recursive=True)
sch_files.sort()

print(f"Checking {len(sch_files)} schematic files with Xschem...")
all_clean = True

for sch in sch_files:
    cmd = f"""
    xschem -x -q --rcfile /foss/designs/chipathon26-SAR_ADC/xschem/xschemrc --command '
      set netlist_dir /tmp
      xschem netlist
      exit
    ' {sch}
    """
    res = subprocess.run(['docker', 'run', '--rm', 
                          '-v', '/home/kyrie/eda/designs/chipathon26-SAR_ADC:/foss/designs/chipathon26-SAR_ADC', 
                          '-w', '/foss/designs/chipathon26-SAR_ADC', 
                          'hpretl/iic-osic-tools:chipathon26', '--skip', 'bash', '-c', cmd],
                         capture_output=True, text=True)
    
    output_lines = [l for l in res.stdout.splitlines() if 'Warning:' in l or 'Error:' in l]
    if output_lines:
        print(f"-----------/foss/designs/chipathon26-SAR_ADC/{sch}")
        for l in output_lines:
            print(f"  {l}")
        all_clean = False
    else:
        print(f"OK: {sch}")

if all_clean:
    print("\n✅ ALL SCHEMATICS 100% CLEAN (0 Warnings, 0 Errors)!")
else:
    print("\n❌ ISSUES DETECTED - PLEASE FIX!")
