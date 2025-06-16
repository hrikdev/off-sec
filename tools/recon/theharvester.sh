#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROXYCHAINS_BIN="$SCRIPT_DIR/../../tools/proxychains"

target="$1"
if [ -z "$target" ]; then
    echo "[?] Usage: $0 <domain>"
    exit 1
fi

if [ ! -x "$PROXYCHAINS_BIN" ]; then
    echo "[!] proxychains binary not found at: $PROXYCHAINS_BIN"
    exit 1
fi

echo "[+] Running theHarvester via proxychains on: $target"
"$PROXYCHAINS_BIN" theHarvester -d "$target" -b all
