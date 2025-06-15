#!/bin/bash

# Base and sub-directory paths
BASE_DIR="$(dirname "$(realpath "$0")")"
TOOLS_DIR="$BASE_DIR/tools"
TOR_DIR="$TOOLS_DIR/tor"
PROXYCHAINS="$TOOLS_DIR/proxychains"
JQ="$TOOLS_DIR/jq"
PROXYCHAINS_CONF="$TOOLS_DIR/proxychains.conf"
WATCH_SCRIPT="$TOOLS_DIR/watch_identity.sh"
IP_LOG="$TOOLS_DIR/ip_history.log"
TOR_LOG="$TOR_DIR/tor.log"
TOR_RUN="$TOR_DIR/run_tor.sh"

# Launcher Menu
while true; do
    clear
    echo -e "\n[🔐 OFF-SEC LAUNCHER]"
    echo "[1] Start Tor"
    echo "[2] Watch/Rotate Identity"
    echo "[3] Test Proxy (ip-api)"
    echo "[4] Show IP History"
    echo "[5] View Tor Log"
    echo "[6] Kill Tor"
    echo "[0] Exit"
    echo -n -e "\n[?] Choose: "
    read -r CHOICE

    case "$CHOICE" in
        1)
            echo -e "\n[*] Starting Tor..."
            bash "$TOR_RUN"
            read -p $'\nPress Enter to continue...'
            ;;
        2)
            echo -e "\n[*] Watching identity..."
            bash "$WATCH_SCRIPT"
            read -p $'\nPress Enter to continue...'
            ;;
        3)
            echo -e "\n[*] Testing proxy via ip-api..."
            "$PROXYCHAINS" -f "$PROXYCHAINS_CONF" curl -s http://ip-api.com/json | "$JQ" .
            read -p $'\nPress Enter to continue...'
            ;;
        4)
            echo -e "\n[*] IP History:"
            cat "$IP_LOG"
            read -p $'\nPress Enter to continue...'
            ;;
        5)
            echo -e "\n[*] Tor Log:"
            tail -n 50 "$TOR_LOG"
            read -p $'\nPress Enter to continue...'
            ;;
        6)
            echo -e "\n[*] Killing Tor..."
            pkill -f "tor -f"
            read -p $'\nPress Enter to continue...'
            ;;
        0)
            echo "[*] Exiting."
            break
            ;;
        *)
            echo "[!] Invalid option."
            read -p $'\nPress Enter to continue...'
            ;;
    esac
done
