#!/bin/bash

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
RESET='\033[0m'

# Input
DOMAIN="$1"
if [[ -z "$DOMAIN" ]]; then
    read -p "[?] Enter domain: " DOMAIN
fi

# Paths
PROXYCHAINS="./tools/proxychains"
PROXYCHAINS_CONF="./tools/proxychains.conf"
SUBLIST3R_BIN="/usr/bin/sublist3r"

# Check if Sublist3r is installed
if ! command -v $SUBLIST3R_BIN &> /dev/null; then
    echo -e "${RED}[!] Sublist3r not found. Install it via: pip install sublist3r${RESET}"
    exit 1
fi

# Run Sublist3r
$PROXYCHAINS -f "$PROXYCHAINS_CONF" $SUBLIST3R_BIN -d "$DOMAIN"
