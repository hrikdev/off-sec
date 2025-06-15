#!/bin/bash

echo "🔒 Starting Tor service..."
sudo systemctl restart tor

echo "🌐 Launching proxychains shell..."
proxychains4 -q bash
