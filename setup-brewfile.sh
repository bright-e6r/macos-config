#!/bin/bash

set -e

echo "=== Brewfile Setup Script ==="
echo ""

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ ! -f "$SCRIPT_DIR/Brewfile" ]; then
    echo "Brewfile not found"
    exit 1
fi

echo "Installing packages via brew bundle..."
cd "$SCRIPT_DIR"
brew bundle

echo ""
echo "=== Setup Complete ==="
