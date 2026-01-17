#!/bin/bash

set -e

echo "=== Brewfile Setup Script ==="
echo ""

if [ ! -f "$(dirname "$0")/dotfiles/packages/Brewfile" ]; then
    echo "Brewfile not found"
    exit 1
fi

echo "Installing packages via brew bundle..."
cd "$(dirname "$0")/dotfiles/packages"
brew bundle

echo ""
echo "=== Setup Complete ==="
