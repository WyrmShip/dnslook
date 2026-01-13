# 🐉 DNSLOOK — Elite DNS Reconnaissance Tool

![Kali Linux](https://img.shields.io/badge/Kali-Linux-blue?logo=kalilinux)
![Bash](https://img.shields.io/badge/Made%20with-Bash-black?logo=gnu-bash)
![License](https://img.shields.io/github/license/YOUR_USERNAME/dnslook)
![Stars](https://img.shields.io/github/stars/YOUR_USERNAME/dnslook?style=social)

> **Fast DNS brute‑force & subdomain reconnaissance tool that keeps ONLY real, alive domains (HTTP 200).**  
> Built for **Kali Linux**, **bug bounty hunters**, **pentesters**, and **red teamers**.

---

## ⚡ Why DNSLOOK?

Most tools flood you with **fake, wildcard, and dead subdomains**.  
**DNSLOOK filters the noise** and gives you **only what actually works**.

✔ Bruteforce subdomains  
✔ Check real web availability  
✔ Remove dead & wildcard domains  
✔ Save clean results  
✔ Simple. Fast. Deadly.

---

## 🚀 Features

- ⚡ Ultra‑fast DNS brute‑forcing (dnsx)
- 🌐 HTTP & HTTPS probing
- ✅ Keeps **ONLY HTTP 200** domains
- 🧹 Auto‑removes dead / fake / wildcard subdomains
- 🧠 Multiple subdomain generation modes
- 🎨 Hacker‑style terminal interface
- 📄 Clean TXT output (ready for exploitation)
- 🆘 Built‑in `--help`
- 🐉 Designed for real‑world recon

---

## 📦 Requirements

"bash
sudo apt update
sudo apt install -y curl parallel
go install github.com/projectdiscovery/dnsx/cmd/dnsx@latest
Wordlist example:

Copy code
n0kovo_subdomains_large.txt
⚙️ Installation
bash
Copy code
git clone https://github.com/YOUR_USERNAME/dnslook.git
cd dnslook
chmod +x dnslook.sh
🧪 Usage
bash
Copy code
./dnslook.sh
Help menu:

bash
Copy code
./dnslook.sh --help
🔢 Subdomain Generation Modes
Option	Format	Example
1	word.DOMAIN	api.example.com
2	DOMAIN.word.TLD	example.api.com
3	word.word.DOMAIN	test.api.example.com

📁 Output Structure
text
Copy code
dnslook-example.com/
├── subdomains.txt
└── alive.txt   ← ONLY WORKING DOMAINS (HTTP 200)
💀 Use Cases
Bug bounty reconnaissance

Subdomain takeover hunting

API discovery

Attack surface mapping

Red team recon

Security research

⚠️ Disclaimer
This tool is provided for educational and authorized security testing only.
The author is not responsible for any misuse or illegal activity.

🧑‍💻 Author
WyrmShip
Offensive Security • Red Team • Recon Automation
