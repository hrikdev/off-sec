#!/bin/bash
read -p "Enter domain for recon: " domain
echo "[+] WHOIS Lookup"
whois $domain
echo "[+] DNS Lookup"
dig $domain any +noall +answer
