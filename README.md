# 🛠️ OffSec Toolkit — Stay Stealthy, Stay Sharp

Welcome to **OffSec Toolkit**, a terminal-based offensive security framework designed for streamlined recon, web testing, anonymity via Tor, and much more — all wrapped in a stealthy, modular interface.

---

## 🔥 Features

- 🧠 Modular Offensive Framework
- 🕵️ Anonymous Reconnaissance via Proxychains and Tor
- 🌐 Launch common recon and web tools directly
- 🦊 Launch **Firefox** with proxychains
- 📜 Wordlist customization support
- ⚡ Fast execution with interactive menu

---

## 📦 Included Tools

| Module | Tool | Proxy Support | Notes |
|--------|------|---------------|-------|
| Recon  | `nmap` | ✅ | Port scanning |
| Recon  | `sublist3r` | ✅ | Subdomain enumeration |
| Recon  | `theHarvester` | ✅ | OSINT from public sources |
| Recon  | `auto_recon.sh` | ✅ | Custom recon script |
| Web    | `nikto` | ✅ | Web server vulnerability scanner |
| Web    | `feroxbuster` | ✅ | Fuzzing for hidden web content |
| Web    | `sqlmap` | ✅ | Automated SQL injection testing |
| Browser | `Firefox` | ✅ | Launched via proxychains |
| Browser | `Brave` | ✅ | Also via proxychains |

---

## 📂 Folder Structure

```

off-sec/
├── offsec.sh                   # Main launcher script
├── README.md                   # This file
├── tools/
│   ├── proxychains             # Custom proxychains binary
│   ├── proxychains.conf        # Custom proxychains config
│   ├── tor/
│   │   ├── start\_tor.sh        # Start TOR service
│   │   ├── kill\_tor.sh         # Kill TOR
│   │   ├── watch\_identity.sh   # Rotate TOR identity
│   ├── web/
│   │   ├── sqlmap.sh           # Run SQLMap via proxychains
│   │   ├── sublist3r.sh        # Sublist3r wrapper
│   │   ├── nikto.sh            # Nikto wrapper
│   │   ├── feroxbuster.sh      # Feroxbuster wrapper
│   ├── auto\_recon.sh           # Your custom recon script
│   ├── launch\_firefox.sh       # Firefox launcher with kill-switch
│   

````

---

## 🧭 Usage

Make the main script executable:

```bash
chmod +x offsec.sh
./offsec.sh
````

From the interactive menu, choose options like:

```
[1] Start Tor Service
[2] Rotate Tor Identity every N seconds
[3] Run Recon Module
[4] Run Auto Recon
[5] Run Nikto Web Vulnerability Scan
[6] Run Feroxbuster (via Proxychains)
[8] Launch Firefox Browser (via Proxychains)
[9] Kill Tor & Proxychains (Emergency Kill Switch)
[10] Run Sublist3r (via Proxychains)
[11] Run theHarvester (via Proxychains)
[12] Run SQLMap (via Proxychains)
[13] Exit

```

---

## 🧅 ProxyChains & TOR

You're using a **custom proxychains binary** located at:

```
/off-sec/tools/proxychains
```

With config at:

```
/off-sec/tools/proxychains.conf
```

Ensure Tor is running before launching any proxy-aware tools:

```bash
./tools/tor/start_tor.sh
```

You can also rotate your Tor identity:

```bash
./tools/tor/watch_identity.sh
```

---

## 🗝️ theHarvester API Keys (Optional)

Some `theHarvester` sources require API keys. You can add them at:

```bash
sudo nano /etc/theHarvester/api-keys.yaml
```

To suppress API warnings, limit `theHarvester` to public engines:

```bash
./tools/proxychains -f ./tools/proxychains.conf theHarvester -d kali.org -b bing
```

---

## 📥 Wordlist Support

Some tools (like `feroxbuster` and `ffuf`) allow you to customize your wordlists.
To use a specific wordlist with `feroxbuster`, edit `tools/web/feroxbuster.sh`:

```bash
wordlist="/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt"
```

---

## 🚀 Upcoming Features

* [ ] Add support for nuclei and whatweb
* [ ] Save scan outputs to a structured folder
* [ ] Auto update tool dependencies
* [ ] Basic reporting system

---

## 🤝 Contribution

Feel free to fork the repo and submit pull requests. You can also open issues if anything breaks. The toolkit is meant to evolve with your use case.

---

## 🧠 Author

Made by `hrik` for personal Offensive Security preparation.

"Stay stealthy. Stay sharp."