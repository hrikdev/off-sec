#!/bin/bash

PASSWORD="@Dj"

# Send commands with proper uppercase and line endings
response=$(echo -e "AUTHENTICATE \"$PASSWORD\"\r\nSIGNAL NEWNYM\r\nQUIT\r\n" | nc 127.0.0.1 9051)

if echo "$response" | grep -q "250 OK"; then
    echo "[+] Identity rotated"
else
    echo "❌ Failed to rotate identity"
    echo "Response: $response"
fi
