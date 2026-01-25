#!/usr/bin/env bash

set -euo pipefail

echo "=== Masfile Setup Script ==="
echo ""

if ! command -v mas &> /dev/null; then
    echo "mas not found. Installing..."
    brew install mas
else
    echo "mas found"
fi

if [ -f "$(dirname "$0")/dotfiles/packages/Masfile" ]; then
    echo "Installing Mac App Store apps..."
    cd "$(dirname "$0")/dotfiles/packages"
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
