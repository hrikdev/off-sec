#!/bin/bash

TOR_DIR="$(dirname "$0")"
TOR_LOG="$TOR_DIR/tor.log"
TORRC="$TOR_DIR/torrc"
PIDFILE="$TOR_DIR/tor.pid"

echo "🚀 Starting Tor..."
tor -f "$TORRC" --PidFile "$PIDFILE" >> "$TOR_LOG" 2>&1 &

sleep 5

if [ -f "$PIDFILE" ]; then
    echo "✅ Tor started successfully (PID: $(cat "$PIDFILE"))"
else
    echo "❌ Failed to start Tor. Check $TOR_LOG for details."
    exit 1
fi
