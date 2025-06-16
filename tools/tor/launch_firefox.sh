#!/bin/bash

# ── Colors ─────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
RESET='\033[0m'

# ── Paths ──────────────────────────────────────────────
PROXYCHAINS="./tools/proxychains"
PROXYCHAINS_CONF="./tools/proxychains.conf"

# ── Banner ─────────────────────────────────────────────
echo -e "${CYAN}[★] Launching Firefox via Proxychains...${RESET}"

# ── Kill existing Firefox instances ────────────────────
echo -e "${RED}[!] Killing any existing Firefox instances...${RESET}"
pkill firefox 2>/dev/null
sleep 1

# ── Launch Firefox with Proxychains ────────────────────
TARGET_URL="https://check.torproject.org"
echo -e "${GREEN}[+] Launching Firefox at ${TARGET_URL}${RESET}"
$PROXYCHAINS -f "$PROXYCHAINS_CONF" firefox --private-window "$TARGET_URL"
