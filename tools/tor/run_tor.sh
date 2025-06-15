#!/bin/bash

TOR_DIR="$(dirname "$0")"
TOR_LOG="$TOR_DIR/tor.log"
TORRC="$TOR_DIR/torrc"

echo "[*] Starting Tor..."
tor -f "$TORRC" >> "$TOR_LOG" 2>&1 &
echo "[+] Tor started with custom config"
