
# 🧅 Tor Recon Toolkit — Off-Sec Edition

A self-contained, proxychains-based recon environment using Tor, perfect for Offensive Security workflows. Includes IP rotation, leak detection, logging, and a cyberpunk-styled identity monitor.

---

## ⚙️ Features

- Tor-based IP rotation
- Identity switcher every N seconds
- No DNS leaks (verified)
- Logs with timestamp and geolocation
- Runs via `proxychains` and Tor, entirely locally
- Beautiful terminal output with cyberpunk-styled display
- ✅ Works without modifying system-level configurations

---

## 📦 Folder Structure

```
off-sec/
├── tools/
│   ├── proxychains
│   ├── proxychains.conf
│   ├── jq
│   └── tor/
│       ├── torrc
│       ├── rotate_tor.sh
│       └── run_tor.sh
├── watch_identity.sh
└── ip_history.log
```

---

## 🛠️ Installation & Setup

1. **Clone this repo:**

```bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
cd YOUR_REPO_NAME
```

2. **Make all scripts executable:**

```bash
chmod +x watch_identity.sh tools/proxychains tools/jq tools/tor/*.sh
```

3. **Start Tor (from the local setup):**

```bash
./tools/tor/run_tor.sh
```

You should see:  
`[+] Tor started with custom config`

---

## 🚀 Running the Watch Tool

Use this script to monitor IP changes and auto-rotate Tor identities:

```bash
./watch_identity.sh 60
```

> `60` is the interval in seconds between rotations. You can set any custom interval.

**Output Example:**

```
🧅─────────────────────────────────────────────────────────🧅
     Tor Identity Rotator — Hrik
🧅─────────────────────────────────────────────────────────🧅

🔁 Switching identity every 60s
📄 Logging to: ip_history.log

==================================================
🌍 [2025-06-15 13:20:12]
🎯 IP: 185.220.101.23
🏙 City: Frankfurt, Germany
🗺️ ISP: Tor Exit Node
🔐 DNS Leak: ✅ No DNS Leak
==================================================
🔄 Rotating identity via Tor... [✓ Rotated]
⏳ Next rotation in: 60s
```

---

## 🔁 Manual Identity Rotation

You can manually rotate the Tor identity if needed:

```bash
./tools/tor/rotate_tor.sh
```

---

## 📑 Logs

All IPs and metadata are logged in `ip_history.log` like:

```
[2025-06-15 13:20:12] IP: 185.220.101.23 | Frankfurt, Germany | ISP: Tor Exit Node | DNS Leak: ✅ No DNS Leak
```

---

## 🔐 Notes

- Ensure `Tor` runs before using the watcher.
- `jq`, `proxychains`, and `curl` are bundled and self-contained.
- If you’re using custom DNS, make sure it’s routed through Tor.

---

## 🧠 Troubleshooting

- ❌ *Can't rotate identity?*  
  Ensure Tor's `ControlPort` is enabled and correctly referenced in `torrc`.

- ❌ *Getting "jq: command not found"?*  
  Ensure `./jq` is executable:  
  `chmod +x tools/jq`

- ❌ *Proxychains cluttering output?*  
  The watch script uses `-q` for quiet mode by default.

---

## 🧪 Recommended Recon Use

Use this setup with tools like:

```bash
./tools/proxychains -f tools/proxychains.conf nmap -sT -Pn -n -p 80 scanme.nmap.org
./tools/proxychains -f tools/proxychains.conf gobuster dir -u http://target -w wordlist.txt
```

---

## 🙌 Credits

Developed by **Hrik** for custom off-sec recon tasks.
