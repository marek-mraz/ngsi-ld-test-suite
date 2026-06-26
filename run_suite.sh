#!/bin/bash
# run_suite.sh <name> <relpath> [timeout-seconds]
# ponytail: tiny wrapper; parses output.xml total counts
cd /workspace/ngsi-ld-test-suite
name="$1"; rel="$2"; tmo="${3:-1200}"
out="results-$name"
rm -rf "$out"
./clean_db.sh >/dev/null 2>&1
timeout "$tmo" .venv/bin/robot --outputdir "$out" "TP/NGSI-LD/$rel" >/dev/null 2>&1
python3 - "$out/output.xml" "$name" <<'PY'
import sys,xml.etree.ElementTree as ET
f,name=sys.argv[1],sys.argv[2]
try:
    r=ET.parse(f).getroot()
    # last <stat> under <total> is the grand total
    tot=r.find('./statistics/total')
    s=tot.findall('stat')[-1]
    p,fl=int(s.get('pass')),int(s.get('fail'))
    sk=int(s.get('skip') or 0)
    print(f"{name}: PASS={p} FAIL={fl} SKIP={sk}")
except Exception as e:
    print(f"{name}: NO_RESULT ({e})")
PY
