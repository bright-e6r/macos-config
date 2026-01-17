#!/bin/bash

set -e

echo "=== macOS Initial Setup Script ==="
echo ""

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting hostname..."
read -r -p "Enter hostname: " HOSTNAME

if [ -n "$HOSTNAME" ]; then
    sudo scutil --set HostName "$HOSTNAME"
    sudo scutil --set ComputerName "$HOSTNAME"
    sudo scutil --set LocalHostName "$HOSTNAME"
    echo "Hostname set to: $HOSTNAME"
else
    echo "No hostname provided, skipping..."
fi

echo ""

if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing..."
    if /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
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

if [ -f "$SCRIPT_DIR/setup-brewfile.sh" ]; then
    echo "Running brew bundle setup..."
    "$SCRIPT_DIR/setup-brewfile.sh"
else
    echo "setup-brewfile.sh not found"
fi

echo ""

if [ -f "$SCRIPT_DIR/setup-masfile.sh" ]; then
    echo "Running mas apps setup..."
    "$SCRIPT_DIR/setup-masfile.sh"
else
    echo "setup-masfile.sh not found"
fi

echo ""

if [ -f "$SCRIPT_DIR/setup-ohmyzsh-powerlevel10k.sh" ]; then
    echo "Running Oh My Zsh & PowerLevel10k setup..."
    "$SCRIPT_DIR/setup-ohmyzsh-powerlevel10k.sh"
else
    echo "setup-ohmyzsh-powerlevel10k.sh not found"
fi

echo ""

if [ -f "$SCRIPT_DIR/setup-tmux.sh" ]; then
    echo "Running Oh My Tmux setup..."
    "$SCRIPT_DIR/setup-tmux.sh"
else
    echo "setup-tmux.sh not found"
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
echo "=================================================="
echo "모든 설치가 완료되었습니다!"
echo "=================================================="
echo ""
echo "PowerLevel10k 테마를 설정하려면 터미널에서 다음 명령을 실행하세요:"
echo "  p10k configure"
echo ""
echo "Oh My Tmux는 이미 설정되었습니다. tmux를 실행하면 됩니다:"
echo "  tmux"
echo ""
echo "설정을 마친 후에는 터미널을 다시 시작하세요."
echo ""
echo "=== Setup Complete ==="