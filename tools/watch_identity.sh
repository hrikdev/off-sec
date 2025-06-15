#!/bin/bash

#INTERVAL=${1:-60}
#LOG_FILE="ip_history.log"
#PROXYCHAINS="./proxychains"
#JQ="./jq"
#PROXYCHAINS_CONF="./proxychains.conf"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

INTERVAL=${1:-60}
LOG_FILE="$SCRIPT_DIR/ip_history.log"
PROXYCHAINS="$SCRIPT_DIR/proxychains"
JQ="$SCRIPT_DIR/jq"
PROXYCHAINS_CONF="$SCRIPT_DIR/proxychains.conf"

# Colors
CYAN='\033[96m'
GREEN='\033[92m'
YELLOW='\033[93m'
RED='\033[91m'
BOLD='\033[1m'
NC='\033[0m'

# ASCII Banner
clear
echo -e "${CYAN}"
echo "      /\\"
echo "     /  \\"
echo "    / /\\ \\"
echo "   / ____ \\         Tor Identity Rotator — Hrik"
echo "  /_/    \\_\\"
echo "🧅─────────────────────────────────────────────────────────🧅"
echo -e "${NC}"
echo -e "🔁 Switching identity every ${BOLD}${INTERVAL}s${NC}"
echo -e "📄 Logging to: ${BOLD}${LOG_FILE}${NC}\n"

# Countdown function
countdown() {
    secs=$1
    while [ $secs -gt 0 ]; do
        echo -ne "⏳ Next rotation in: ${YELLOW}${secs}s${NC}   \r"
        sleep 1
        : $((secs--))
    done
}


while true; do
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

    # Get IP info via ip-api.com (suppress proxychains output)
    GEO_DATA=$($PROXYCHAINS -q -f "$PROXYCHAINS_CONF" curl -s "http://ip-api.com/json/")
    IP=$(echo "$GEO_DATA" | $JQ -r '.query // "N/A"')
    CITY=$(echo "$GEO_DATA" | $JQ -r '.city // "N/A"')
    COUNTRY=$(echo "$GEO_DATA" | $JQ -r '.country // "N/A"')
    ISP=$(echo "$GEO_DATA" | $JQ -r '.isp // "N/A"')

    # DNS Leak Test
    DNS_LEAK=$($PROXYCHAINS -q -f "$PROXYCHAINS_CONF" curl -s https://dnsleaktest.com | grep -q "IP Address" && echo "⚠️ Possible DNS Leak" || echo "✅ No DNS Leak")

    # Display
    echo -e "=================================================="
    echo -e "${CYAN}🌍 [${TIMESTAMP}]${NC}"
    echo -e "${GREEN}🎯 IP:${NC} $IP"
    echo -e "${GREEN}🏙 City:${NC} $CITY, $COUNTRY"
    echo -e "${GREEN}🗺️ ISP:${NC} $ISP"
    echo -e "${GREEN}🔐 DNS Leak:${NC} $DNS_LEAK"
    echo -e "=================================================="

    # Log to file
    echo "[${TIMESTAMP}] IP: $IP | $CITY, $COUNTRY | ISP: $ISP | DNS Leak: $DNS_LEAK" >> "$LOG_FILE"

    # Rotate identity
    echo -ne "${YELLOW}🔄 Rotating identity via Tor...${NC} "
    "$(dirname "$0")/tor/rotate_tor.sh"
    sleep 5
    echo -e "[${GREEN}✓ Rotated${NC}]"


    # Wait
    countdown "$INTERVAL"
    echo
done
