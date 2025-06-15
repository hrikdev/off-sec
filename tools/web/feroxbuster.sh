#!/bin/bash

# Colors
CYAN='\033[0;36m'
RED='\033[0;31m'
GREEN='\033[0;32m'
RESET='\033[0m'

# Path setup
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
PROXYCHAINS_BIN="$PROJECT_ROOT/proxychains"
PROXYCHAINS_CONF="$PROJECT_ROOT/proxychains.conf"

# Target prompt
echo -e "${CYAN}[?] Enter the target URL (e.g. http://example.com):${RESET}"
read url

if [[ -z "$url" ]]; then
    echo -e "${RED}[!] No URL entered.${RESET}"
    exit 1
fi

# Wordlist prompt
echo -e "${CYAN}[?] Enter path to custom wordlist (or press Enter to use default):${RESET}"
read wordlist

# Wordlist option setup
if [[ -z "$wordlist" ]]; then
    WORDLIST_OPTION=""
else
    WORDLIST_OPTION="-w $wordlist"
fi

# Run feroxbuster quietly via proxychains
echo -e "${GREEN}[+] Running feroxbuster via proxychains...${RESET}"
"$PROXYCHAINS_BIN" -f "$PROXYCHAINS_CONF" feroxbuster -u "$url" -t 25 -x 404 $WORDLIST_OPTION 2>&1 | grep -vE 'ProxyChains|DNS|connect'

