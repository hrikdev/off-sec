#!/bin/bash

# Replace with your actual Tor password (hashed in torrc)
PASSWORD="@Dj"

RESPONSE=$(echo -e "AUTHENTICATE \"$PASSWORD\"\r\nSIGNAL NEWNYM\r\nQUIT\r\n" | nc 127.0.0.1 9051)

if echo "$RESPONSE" | grep -q "250 OK"; then
    echo "🔁 Tor identity rotated successfully."
else
    echo "❌ Failed to rotate Tor identity."
    echo "Tor Response: $RESPONSE"
fi
