#!/bin/bash

set -e

# Replace these placeholders with your actual values
POOL="etc-asia1.nanopool.org"  # Mining pool address
PORT=10143  # Port number
MYADDRESS="0xA32d95353fd2B339BCb6e7a7C12B4f4A66ee3380"  # Your Ethereum Classic wallet address
COINNAME="eth"  # Use 'eth' for Ethereum Classic

# Check if required tools are available
if ! command -v chmod &> /dev/null; then
    echo "Error: chmod command not found."
    exit 1
fi

# Verify required environment variables are set
if [[ "$POOL" == "changeme" || "$MYADDRESS" == "changeme" || "$COINNAME" == "changeme" ]]; then
    echo "Error: One or more environment variables are not set. Please replace placeholders with actual values."
    exit 1
fi

cd xmrig/build || { echo "Error: Failed to change directory to xmrig/build"; exit 1; }

# Set executable permissions
echo "Setting executable permissions"
if ! chmod +x xmrig; then
    echo "Error: Failed to set executable permissions on xmrig"
    exit 1
fi

# Start the mining process
echo "Starting now"
if ! ./xmrig -o "$POOL:$PORT" -u "$MYADDRESS" --tls --coin "$COINNAME"; then
    echo "Error: Failed to start xmrig with the provided parameters"
    exit 1
fi
