#!/usr/bin/env bash
set -euo pipefail

TARGET_HOST="${1:-lb.local}"
ENDPOINT="${2:-http://127.0.0.1}"
TOTAL_REQUESTS="${3:-10}"

echo "[*] Sending $TOTAL_REQUESTS requests to $ENDPOINT with Host:$TARGET_HOST"
echo "------------------------------------------------------------"

for i in $(seq 1 "$TOTAL_REQUESTS"); do
    RESPONSE=$(curl -s -H "Host: $TARGET_HOST" "$ENDPOINT")
    echo "Req #$i:$RESPONSE"
done

echo "------------------------------------------------------------"
echo "[+] Verification complete."
