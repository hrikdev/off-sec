#!/bin/bash

BASE_DIR="$(dirname "$(realpath "$0")")/../.."
PROXYCHAINS_BIN="$BASE_DIR/tools/proxychains"
PROXYCHAINS_CONF="$BASE_DIR/tools/proxychains.conf"

echo "[+] Launching Firefox through proxychains..."
"$PROXYCHAINS_BIN" -f "$PROXYCHAINS_CONF" firefox --private-window &
