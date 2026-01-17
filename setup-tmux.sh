#!/bin/bash

set -e

echo "=== Oh My Tmux Setup Script ==="
echo ""

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
TMUX_CONFIG_DIR="$XDG_CONFIG_HOME/tmux"

if ! command -v tmux &> /dev/null; then
    echo "tmux not found. Please run install.sh first to install tmux."
    exit 1
fi

echo "Installing Oh My Tmux..."
curl -fsSL "https://github.com/gpakosz/.tmux/raw/refs/heads/master/install.sh#$(date +%s)" | bash

echo ""

echo "Copying custom tmux configurations..."
mkdir -p "$TMUX_CONFIG_DIR"

if [ -f "$SCRIPT_DIR/dotfiles/tmux/tmux.conf.local" ]; then
    cp "$SCRIPT_DIR/dotfiles/tmux/tmux.conf.local" "$TMUX_CONFIG_DIR/"
    echo "  ✓ Copied tmux.conf.local to $TMUX_CONFIG_DIR"
else
    echo "  ⚠️  tmux.conf.local not found in dotfiles/tmux/"
fi

echo ""

echo "Updating .tmux.conf to use XDG configuration..."
TMUX_CONF="$HOME/.tmux.conf"
LOCAL_CONF="$TMUX_CONFIG_DIR/tmux.conf.local"

if [ -f "$TMUX_CONF" ]; then
    if ! grep -q "source.*$LOCAL_CONF" "$TMUX_CONF"; then
        echo "source-file $LOCAL_CONF" >> "$TMUX_CONF"
        echo "  ✓ Added local configuration to .tmux.conf"
    else
        echo "  ✓ Local configuration already configured in .tmux.conf"
    fi
else
    echo "  ⚠️  .tmux.conf not found. Oh My Tmux may not have installed correctly."
fi

echo ""
echo "✓ Oh My Tmux setup complete!"
echo ""
echo "To start using tmux, simply run:"
echo "  tmux"
