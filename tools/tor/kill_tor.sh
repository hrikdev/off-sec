#!/bin/bash

echo "[!] Killing Tor and proxychains-related processes..."

# Try to stop Tor service if running system-wide
if systemctl is-active --quiet tor; then
    sudo systemctl stop tor
    echo "[+] Tor service stopped via systemctl."
else
    echo "[*] Tor not running via systemctl. Trying to kill manually..."
    pkill -f tor || echo "[!] No tor process found."
fi

# Kill any proxychains-related processes (brave, recon tools, etc.)
pkill -f proxychains || echo "[*] No proxychains processes found."
pkill -f brave-browser || true
pkill -f feroxbuster || true
pkill -f nikto || true

echo "[✓] Emergency kill switch triggered. Environment is clean."
#Optionally, you can also clear any proxychains cache or logs if needed
echo "[*] Clearing proxychains cache..."
rm -f ~/.proxychains/proxychains.cache || true
echo "[*] Clearing proxychains logs..."
rm -f ~/.proxychains/proxychains.log || true
echo "[✓] All processes terminated."
#Optionally, you can also remove any temporary files created during the session
echo "[*] Removing temporary files..."
rm -rf /tmp/tor_session || true
echo "[✓] Temporary files removed."
# End of script     