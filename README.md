## 🔎 DNS Brute Force & Subdomain Enumeration Tool

DNSLOOK is a DNS brute‑forcing and subdomain enumeration tool for Kali Linux,
bug bounty hunting, and penetration testing.
It uses dnsx and HTTP probing to find ONLY alive subdomains.


## 🔍 What is DNSLOOK?

DNSLOOK is a **simple, fast, and clean DNS reconnaissance tool** designed for:
- Pentesters
- Bug bounty hunters
- Red teamers
- Security learners

It brute‑forces subdomains, checks which ones are **really alive (HTTP 200 only)**, and saves **clean results** to a TXT file.

---

## ✨ Features

- ⚡ Fast DNS brute‑forcing (dnsx)
- 🌐 HTTP & HTTPS checking
- ✅ Keeps ONLY HTTP 200 domains
- 🧹 Removes dead / fake / wildcard domains
- 🧠 Multiple subdomain formats
- 🎨 Hacker‑style interface
- 📄 Clean TXT output
- 🆘 Built‑in `--help`

---

## 📦 Requirements

Install required tools:

```bash
sudo apt install curl parallel
go install github.com/projectdiscovery/dnsx/cmd/dnsx@latest
Wordlist example:

Copy code
n0kovo_subdomains_large.txt
🚀 Usage
bash
Copy code
chmod +x dnslook.sh
./dnslook.sh
Help menu:

bash
Copy code
./dnslook.sh --help
🔢 Subdomain Modes
Option	Format	Example
1	word.DOMAIN	api.example.com
2	DOMAIN.word.TLD	example.api.com
3	word.word.DOMAIN	test.api.example.com

📁 Output Structure
sql
Copy code
dnslook-example.com/
├── subdomains.txt
└── alive.txt   ← ONLY WORKING DOMAINS
⚠️ Disclaimer
This tool is for educational and authorized security testing only.
The author is NOT responsible for misuse.

🧑‍💻 Author
WyrmShip
Offensive Security • Red Team • Recon Automation
