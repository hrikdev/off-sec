#!/bin/bash
set -e

read -p "[?] Enter the target URL (e.g. http://example.com): " url
read -p "[?] Enter custom wordlist path (leave blank for default): " wordlist

if [[ -z "$url" ]]; then
    echo "[!] Target URL required."
    exit 1
fi

WORDLIST_OPTION=""
if [[ -n "$wordlist" ]]; then
    WORDLIST_OPTION="-w $wordlist"
fi

echo "[+] Running feroxbuster without proxychains..."
feroxbuster -u "$url" -t 25 -x 404 $WORDLIST_OPTION
