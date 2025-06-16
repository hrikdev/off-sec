#!/bin/bash

# ── Colors ────────────────────────────────────────────────
CYAN='\033[1;36m'
MAGENTA='\033[1;35m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
GREEN='\033[1;32m'
RESET='\033[0m'

# ── Base Directory ─────────────────────────────────────────
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TOR_DIR="$BASE_DIR/tools/tor"
WATCH_IDENTITY="$BASE_DIR/tools/watch_identity.sh"
RUN_TOR="$TOR_DIR/run_tor.sh"
RECON_SCRIPT="$BASE_DIR/tools/recon/recon.sh"
AUTO_RECON_SCRIPT="$BASE_DIR/tools/recon/auto_recon.sh"

# ── Banner ────────────────────────────────────────────────
clear

# Colors
GREEN="\033[0;32m"
CYAN="\033[0;36m"
MAGENTA="\033[0;35m"
RESET="\033[0m"

# Function: Matrix-style slow glitch
matrix_glitch() {
  for i in {1..12}; do
    line=$(cat /dev/urandom | tr -dc 'A-Z0-9!@#$%^&*()_+=-' | fold -w 70 | head -n 1)
    echo -e "${GREEN}${line}${RESET}"
    sleep 0.03
  done
}

# Function: Typing effect
slow_echo() {
  local text="$1"
  for (( i=0; i<${#text}; i++ )); do
    printf "${CYAN}${text:$i:1}${RESET}"
    sleep 0.003
  done
  echo
}

# Start matrix glitch
matrix_glitch

# Print Big A Banner
echo -e "${MAGENTA}"
echo "      █████╗  "
echo "     ██╔══██╗ "
echo "     ███████║ "
echo "     ██╔══██║ "
echo "     ██║  ██║ "
echo "     ╚═╝  ╚═╝ "
echo -e "${CYAN}         :: OFFENSIVE SECURITY — HRIK ::${RESET}"
echo

# Boot-up typing effect
slow_echo "[*] Launching offensive framework..."
slow_echo "[*] Initializing modules: TOR, RECON, SCAN..."
slow_echo "[*] Environment stable. Engaging now."


# ── Menu ──────────────────────────────────────────────────
echo -e "${YELLOW}[1]${RESET} Start Tor Service"
echo -e "${YELLOW}[2]${RESET} Rotate Tor Identity every N seconds"
echo -e "${YELLOW}[3]${RESET} Run Recon Module"
echo -e "${YELLOW}[4]${RESET} Run Auto Recon"
echo -e "${YELLOW}[5]${RESET} Run Nikto Web Vulnerability Scan"
echo -e "${YELLOW}[6]${RESET} Run Feroxbuster (via Proxychains)"
echo -e "${YELLOW}[7]${RESET} Run Feroxbuster (No Proxychains)"
echo -e "${YELLOW}[8]${RESET} Launch Firefox Browser (via Proxychains)"
echo -e "${YELLOW}[9]${RESET} Kill Tor & Proxychains (Emergency Kill Switch)"
echo -e "${YELLOW}[10]${RESET} Run Sublist3r (via Proxychains)"
echo -e "${YELLOW}[11]${RESET} Run theHarvester (via Proxychains)"
echo -e "${YELLOW}[12]${RESET} Run SQLMap (via Proxychains)"
echo -e "${YELLOW}[13]${RESET} Exit"
echo

read -p "$(echo -e "${GREEN}[?] Select an option: ${RESET}")" choice

case $choice in
  1)
    if [[ -x "$RUN_TOR" ]]; then
        echo -e "${CYAN}[+] Launching Tor...${RESET}"
        bash "$RUN_TOR"
    else
        echo -e "${RED}[!] run_tor.sh not found or not executable:${RESET} $RUN_TOR"
    fi
    ;;
  2)
    read -p "$(echo -e "${GREEN}[?] Enter rotation interval in seconds (e.g. 300): ${RESET}")" interval
    if [[ -x "$WATCH_IDENTITY" ]]; then
        echo -e "${CYAN}[+] Starting watch_identity.sh with interval ${interval}s...${RESET}"
        bash "$WATCH_IDENTITY" "$interval"
    else
        echo -e "${RED}[!] watch_identity.sh not found or not executable:${RESET} $WATCH_IDENTITY"
    fi
    ;;
  3)
    if [[ -x "$RECON_SCRIPT" ]]; then
        echo -e "${CYAN}[+] Launching Recon Module...${RESET}"
        bash "$RECON_SCRIPT"
    else
        echo -e "${RED}[!] Recon script not found or not executable: $RECON_SCRIPT${RESET}"
    fi
    ;;
  4)
    echo -e "${CYAN}[?] Enter target (IP or domain): ${RESET}"
    read target
    echo -e "${CYAN}[?] Enter path to wordlist (or leave blank for default): ${RESET}"
    read wordlist
    if [[ -z "$target" ]]; then
      echo -e "${RED}[!] No target provided. Skipping...${RESET}"
    else
    echo -e "${GREEN}[+] Running Auto Recon on: $target${RESET}"
    if [[ -z "$wordlist" ]]; then
      bash tools/recon/auto_recon.sh "$target"
    else
      bash tools/recon/auto_recon.sh "$target" "$wordlist"
    fi
    fi
    ;;
  5)
    echo -e "${CYAN}[?] Enter target URL (e.g. http://example.com): ${RESET}"
    read url
    if [[ -n "$url" ]]; then
      nikto -h "$url"
    else
    echo -e "${RED}[!] No URL provided.${RESET}"
    fi
    ;;
  6)
    bash tools/web/feroxbuster.sh
    ;;
  7)
    echo "[+] Running feroxbuster without proxychains..."
    bash "$BASE_DIR/tools/web/feroxbuster_noproxy.sh"
    ;;
  8)
    echo "[+] Launching Firefox with proxychains..."
    bash "$TOR_DIR/launch_firefox.sh"
    ;;
  9)
    bash "$BASE_DIR/tools/tor/kill_tor.sh"
    ;;
  10)
    read -p "[?] Enter domain: " domain
    echo -e "${GREEN}[+] Running Sublist3r via proxychains on: $domain${RESET}"
    bash tools/recon/sublist3r.sh "$domain"
    ;;
  11)
    read -p "[?] Enter domain: " domain
    tools/recon/theharvester.sh "$domain"
    ;;
  12)
    read -p "[?] Enter URL: " url
    tools/web/sqlmap.sh "$url"
    ;;
  13)
    echo -e "${RED}[✖] Exiting.${RESET}"
    exit 0
    ;;
  *)
    echo -e "${RED}[!] Invalid option. Try again.${RESET}"
    ;;
  
esac
