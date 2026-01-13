#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
CYAN="\e[36m"
YELLOW="\e[33m"
RESET="\e[0m"

show_help() {
clear
echo -e "${RED}"
cat << "EOF"
██████╗ ███╗   ██╗███████╗██╗      ██████╗  ██████╗ ██╗  ██╗
██╔══██╗████╗  ██║██╔════╝██║     ██╔═══██╗██╔═══██╗██║ ██╔╝
██║  ██║██╔██╗ ██║███████╗██║     ██║   ██║██║   ██║█████╔╝ 
██║  ██║██║╚██╗██║╚════██║██║     ██║   ██║██║   ██║██╔═██╗ 
██████╔╝██║ ╚████║███████║███████╗╚██████╔╝╚██████╔╝██║  ██╗
╚═════╝ ╚═╝  ╚═══╝╚══════╝╚══════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝
EOF
echo -e "${RESET}"

echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${GREEN} DNSLOOK — Fast • Clean • Hacker Recon Tool${RESET}"
echo -e "${YELLOW} All rights reserved © WyrmShip${RESET}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo
echo -e "${GREEN}USAGE:${RESET}"
echo "  dnslook [--help]"
echo
echo -e "${GREEN}DESCRIPTION:${RESET}"
echo "  DNSLOOK performs DNS brute-force using dnsx,"
echo "  then checks which domains are ALIVE (HTTP 200 only)."
echo
echo -e "${GREEN}MODES:${RESET}"
echo "  1) word.DOMAIN"
echo "     → api.example.com"
echo
echo "  2) DOMAIN.word.TLD"
echo "     → example.api.com"
echo
echo "  3) word.word.DOMAIN"
echo "     → test.api.example.com"
echo
echo -e "${GREEN}EXAMPLES:${RESET}"
echo "  ./dnslook"
echo "  ./dnslook --help"
echo
echo -e "${GREEN}OUTPUT:${RESET}"
echo "  ~/dnslook-example.com/alive.txt"
echo
exit 0
}

# ---- HELP FLAG ----
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    show_help
fi

clear

echo -e "${RED}"
cat << "EOF"
██████╗ ███╗   ██╗███████╗██╗      ██████╗  ██████╗ ██╗  ██╗
██╔══██╗████╗  ██║██╔════╝██║     ██╔═══██╗██╔═══██╗██║ ██╔╝
██║  ██║██╔██╗ ██║███████╗██║     ██║   ██║██║   ██║█████╔╝ 
██║  ██║██║╚██╗██║╚════██║██║     ██║   ██║██║   ██║██╔═██╗ 
██████╔╝██║ ╚████║███████║███████╗╚██████╔╝╚██████╔╝██║  ██╗
╚═════╝ ╚═╝  ╚═══╝╚══════╝╚══════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝
EOF
echo -e "${RESET}"

echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${GREEN} DNSLOOK — Fast • Clean • Hacker Recon Tool${RESET}"
echo -e "${YELLOW} All rights reserved © WyrmShip${RESET}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo

read -p "➤ Enter domain (example: example.com): " DOMAIN
BASE="${DOMAIN%.*}"
TLD="${DOMAIN##*.}"

echo
echo -e "${CYAN}Choose subdomain format:${RESET}"
echo -e "${GREEN}  1) word.DOMAIN           → api.$DOMAIN${RESET}"
echo -e "${GREEN}  2) DOMAIN.word.TLD       → $BASE.api.$TLD${RESET}"
echo -e "${GREEN}  3) word.word.DOMAIN      → test.api.$DOMAIN${RESET}"
echo
read -p "➤ Select option (1 / 2 / 3): " MODE

if [ "$MODE" = "3" ]; then
    read -p "➤ Enter fixed middle word (example: api): " FIXED
fi

WORDLIST="$HOME/Desktop/wordlists/n0kovo_subdomains_large.txt"
OUTDIR="$HOME/dnslook-$DOMAIN"
DNSFILE="$OUTDIR/subdomains.txt"
ALIVE="$OUTDIR/alive.txt"

rm -rf "$OUTDIR"
mkdir -p "$OUTDIR"

for tool in dnsx curl parallel; do
    command -v $tool >/dev/null || { echo -e "${RED}[!] Missing $tool${RESET}"; exit 1; }
done

echo
echo -e "${CYAN}[+] Generating subdomains...${RESET}"

PUREWORDS=$(mktemp)
grep -v '\.' "$WORDLIST" > "$PUREWORDS"

if [ "$MODE" = "1" ]; then
    awk "{print \$0 \".\" \"$DOMAIN\"}" "$PUREWORDS" | dnsx -silent > "$DNSFILE"

elif [ "$MODE" = "2" ]; then
    awk "{print \"$BASE.\" \$0 \".\" \"$TLD\"}" "$PUREWORDS" | dnsx -silent > "$DNSFILE"

elif [ "$MODE" = "3" ]; then
    awk "{print \$0 \".\" \"$FIXED\" \".\" \"$DOMAIN\"}" "$PUREWORDS" | dnsx -silent > "$DNSFILE"

else
    echo -e "${RED}[!] Invalid option${RESET}"
    exit 1
fi

COUNT=$(wc -l < "$DNSFILE")
echo -e "${GREEN}[✓] Subdomains found: $COUNT${RESET}"

[ "$COUNT" -eq 0 ] && exit 0

echo
echo -e "${CYAN}[+] Checking ALIVE domains (HTTP 200 only)...${RESET}"
echo

cat "$DNSFILE" | parallel -j 30 '
for proto in https http; do
  code=$(curl -s --connect-timeout 3 --max-time 5 -o /dev/null -w "%{http_code}" "$proto://{}")
  if [ "$code" = "200" ]; then
    echo "$proto://{}"
    break
  fi
done
' | tee "$ALIVE"

echo
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${GREEN}[✓] DONE${RESET}"
echo -e "${GREEN}[✓] Working domains: $(wc -l < "$ALIVE")${RESET}"
echo -e "${GREEN}[✓] Saved to: $ALIVE${RESET}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${YELLOW} All rights reserved © WyrmShip${RESET}"
echo

