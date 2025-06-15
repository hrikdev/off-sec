# 🛡️ OFFSEC TOOLKIT — Stay Stealthy
A custom-built offensive security toolkit designed for local CTFs, red teaming practice, and stealthy recon — built by a beginner, built to win.
---
## 📦 Toolkit Overview
This project includes a modular Bash-driven interface with Tor integration, Proxychains, web scanners, recon tools, and automation. Works best on Linux (tested on Kali and Debian-based distros).
---
## 🔧 Features
- 🔁 Tor Identity Rotation (with manual interval)
- 🌐 Proxychains Integration (custom binary and config)
- 🕵️‍♂️ Recon & Web Scanning
- 🔍 Feroxbuster with/without proxy support
- 🔓 Nikto Scanner
- 🚀 Firefox Launch via Proxychains
- 🛑 Emergency Kill Switch (Tor + tools)
- 🧠 Auto Recon Script Integration
---
## 🧰 Tools Included
| Tool            | Purpose                                 | Proxychains Support |
|-----------------|-----------------------------------------|----------------------|
| Tor             | Anonymity layer                         | ✅                   |
| Proxychains     | Route tools through proxies             | ✅ (custom binary)   |
| Nmap            | Network scanning                        | ✅                   |
| Nikto           | Web vulnerability scanning              | ✅                   |
| Feroxbuster     | Directory brute-forcing                 | ✅ / ❌ (your choice) |
| Firefox         | Web browser for manual recon            | ✅                   |
| Auto Recon      | Automated recon script                  | ✅ (custom tools)    |
---
## 🚀 Usage
### ✅ Step 1: Clone & Setup
```bash
git clone https://github.com/hrikdev/off-sec.git
cd off-sec
chmod +x offsec.sh
````
Make all tools executable:
```bash
chmod +x tools/**/*.sh
```
Install dependencies:
```bash
sudo apt update
sudo apt install tor proxychains firefox nmap nikto feroxbuster
```
---
### 🧨 Run the Toolkit
```bash
./offsec.sh
```
You'll see this menu:
```
[*] Launching offensive framework...
[*] Initializing modules: TOR, RECON, SCAN...
[*] Environment stable. Engaging now.
[1] Start Tor Service
[2] Rotate Tor Identity every N seconds
[3] Run Recon Module
[4] Run Auto Recon
[5] Run Nikto Web Vulnerability Scan
[6] Run Feroxbuster (via Proxychains)
[7] Run Feroxbuster (without Proxychains)
[8] Launch Firefox Browser (via Proxychains)
[9] Kill Tor & Proxychains (Emergency Kill Switch)
[?] Select an option:
```
---
## 🧱 Directory Structure
```
off-sec/
├── offsec.sh                  # Main launcher
├── auto_recon.sh              # Your own recon script
├── tools/
│   ├── tor/
│   │   ├── proxychains        # Custom proxychains binary
│   │   ├── proxychains.conf   # Custom proxychains config
│   │   ├── watch_identity.sh  # Rotates Tor identity
│   │   ├── kill_tor.sh        # Emergency kill switch
│   │   └── launch_firefox.sh  # Launches Firefox through proxychains
│   └── web/
│       ├── feroxbuster.sh     # Runs feroxbuster
│       └── nikto.sh           # Runs nikto
```
---
## 🌐 Proxychains Setup
You're using a **custom proxychains** binary and config inside:
```
tools/tor/proxychains
tools/tor/proxychains.conf
```
To change proxy settings, edit the `.conf` file:
```ini
# Example
socks5 127.0.0.1 9050
```
---
## 🔁 Tor Identity Rotation
From the menu, choose option 2, and set interval in seconds (e.g., 90):
```bash
[+] Starting watch_identity.sh with interval 90s...
```
It will automatically rotate your identity using Tor's control port.
---
## 🔒 Kill Switch
If things go bad or you want a clean reset:
```bash
[9] Kill Tor & Proxychains (Emergency Kill Switch)
```
This kills:
* Tor (systemctl or process)
* Proxychains-launched tools
* Brave/Firefox/Nikto/Feroxbuster processes
---
## ⚙️ Customizing Wordlists
To use a custom wordlist in Feroxbuster, edit this:
```bash
tools/web/feroxbuster.sh
```
Modify this line:
```bash
--wordlist "$BASE_DIR/wordlists/custom.txt"
```
Place your wordlists in a new `wordlists/` folder if you want to organize.
---
## 🧠 Planned Additions
* Add Subdomain scanners (e.g. `Sublist3r`, `Assetfinder`)
* Integration of `nuclei` for CVE-based scanning
* Optional GUI wrapper (Zenity or YAD)
* Save scan logs
* Save screenshots using `gowitness`
---
## 🧑‍💻 Credits
Made with sweat, coffee and curiosity by **[Hrik](https://github.com/hrikdev)**.
Contributions and ideas welcome. PRs open.
---
## ☠️ Warning
This tool is made for ethical testing and CTF challenges only.
**Never** use it on targets without permission.
