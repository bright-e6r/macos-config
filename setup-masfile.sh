#!/bin/bash

set -e

echo "=== Masfile Setup Script ==="
echo ""

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v mas &> /dev/null; then
    echo "mas not found. Installing..."
    brew install mas
else
    echo "mas found"
fi

if [ -f "$SCRIPT_DIR/Masfile" ]; then
    echo "Installing Mac App Store apps..."
    cd "$SCRIPT_DIR"
    while IFS= read -r line || [ -n "$line" ]; do
        if [[ $line =~ id:\ ([0-9]+) ]]; then
            app_id="${BASH_REMATCH[1]}"
            echo "Installing app ID: $app_id"
            mas install "$app_id"
        fi
    done < Masfile
else
    echo "Masfile not found"
fi

echo ""
echo "=== Setup Complete ==="
