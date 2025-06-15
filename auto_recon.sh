#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <target> [optional: /path/to/wordlist]"
    exit 1
fi

TARGET=$1
WORDLIST=${2:-/usr/share/seclists/Discovery/Web-Content/common.txt}
TIMESTAMP=$(date "+%Y-%m-%d_%H-%M-%S")
OUT_DIR="reports/${TIMESTAMP}_${TARGET}"

mkdir -p reports
mkdir -p "$OUT_DIR"

# Tool checks
if [ ! -x ./tools/proxychains ]; then
    echo "❌ Error: ./tools/proxychains not found or not executable"
    exit 1
fi

for tool in nmap gobuster; do
    if ! command -v "$tool" &>/dev/null; then
        echo "❌ Error: $tool is not installed"
        exit 1
    fi
done

echo "🚀 Starting recon on $TARGET"
echo "📂 Reports will be saved in: $OUT_DIR"
echo "📂 Using wordlist: $WORDLIST"

# Quick Nmap scan
./tools/proxychains -f tools/proxychains.conf nmap -sS -T4 -F "$TARGET" -oN "$OUT_DIR/nmap_quick.txt"

# Full Nmap scan in background
./tools/proxychains -f tools/proxychains.conf nmap -sV -sC -p- -T4 "$TARGET" -oA "$OUT_DIR/full_scan" > /dev/null 2>&1 &

# Gobuster scan
./tools/proxychains -f tools/proxychains.conf gobuster dir -u "http://$TARGET" \
    -w "$WORDLIST" -t 50 -o "$OUT_DIR/gobuster_scan.txt"

# Sample vuln checks
cat <<EOF > "$OUT_DIR/vuln_checks.txt"
http://$TARGET/index.php?page=../../../../etc/passwd
http://$TARGET/login.php?user=' OR 1=1-- -
EOF

echo "✅ Recon complete!"
echo "📁 All results saved in: $OUT_DIR"
