#!/usr/bin/env bash
set -euo pipefail

echo "[*] Creating temporary mock backend endpoints..."
mkdir -p /tmp/node1 /tmp/node2
echo "Served by Backend Node 1 (Port 8081)" > /tmp/node1/index.html
echo "Served by Backend Node 2 (Port 8082)" > /tmp/node2/index.html

python3 -m http.server 8081 --directory /tmp/node1 --bind 127.0.0.1 > /dev/null 2>&1 &
PID1=$!
python3 -m http.server 8082 --directory /tmp/node2 --bind 127.0.0.1 > /dev/null 2>&1 &
PID2=$!

echo "[+] Backend mock cluster running successfully."
echo "    -> Node 1: 127.0.0.1:8081 (PID: $PID1)"
echo "    -> Node 2: 127.0.0.1:8082 (PID: $PID2)"
echo "Press Ctrl+C or run 'kill $PID1$PID2' to terminate."
