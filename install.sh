#!/bin/bash

set -e

echo "=== macOS Initial Setup Script ==="
echo ""

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting hostname..."
read -p "Enter hostname: " HOSTNAME

if [ -n "$HOSTNAME" ]; then
    sudo scutil --set HostName "$HOSTNAME"
    sudo scutil --set ComputerName "$HOSTNAME"
    sudo scutil --set LocalHostName "$HOSTNAME"
    echo "Hostname set to: $HOSTNAME"
else
    echo "No hostname provided, skipping..."
fi

echo ""

if [ -f "$SCRIPT_DIR/setup-zshrc.sh" ]; then
    echo "Running zshrc setup..."
    "$SCRIPT_DIR/setup-zshrc.sh"
else
    echo "setup-zshrc.sh not found"
fi

echo ""

if [ -f "$SCRIPT_DIR/setup-git-config.sh" ]; then
    echo "Running git config setup..."
    export XDG_CONFIG_HOME="$HOME/.config"
    "$SCRIPT_DIR/setup-git-config.sh"
else
    echo "setup-git-config.sh not found"
fi

echo ""

if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    if [ $? -eq 0 ]; then
        echo "Homebrew installed successfully"
        if [[ "$(/bin/uname -m)" == "arm64" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    else
        echo "Homebrew installation failed"
        exit 1
    fi
else
    echo "Homebrew found"
fi

if [ -f "$SCRIPT_DIR/Brewfile" ]; then
    echo "Installing packages via brew bundle..."
    cd "$SCRIPT_DIR"
    brew bundle

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
            if [[ $line =~ ^mas\ install\ [0-9]+ ]]; then
                echo "Executing: $line"
                eval "$line"
            fi
        done < Masfile
    else
        echo "Masfile not found"
    fi
else
    echo "Brewfile not found"
fi

echo ""
echo "=== Setup Complete ==="