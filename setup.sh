#!/bin/bash

echo "🚀 Installing core tools..."
sudo apt update
sudo apt install -y tor proxychains4 nmap hydra gobuster seclists sqlmap

echo "🔧 Configuring Tor stealth..."
sudo systemctl enable tor
sudo systemctl start tor
sudo sed -i 's/socks4/socks5/' /etc/proxychains4.conf

echo "📝 Creating wordlists..."
mkdir -p wordlists
echo -e "admin\nroot\npassword\n123456\ntest\nadministrator" > wordlists/top_passwords.txt

echo "✅ Setup complete!"
echo "Run Tor wrapper: ./stealth-config/tor-wrapper.sh"
echo "Perform recon: ./competition-tools/auto_recon.sh target.com"
