#!/bin/bash

ZSHRC="$HOME/.zshrc"
BACKUP_DIR="$HOME/.zshrc.backup"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_ZSHRC="$SCRIPT_DIR/.zshrc"

if [ -f "$ZSHRC" ]; then
    echo ".zshrc already exists. Creating backup..."
    mkdir -p "$BACKUP_DIR"
    cp "$ZSHRC" "$BACKUP_DIR/.zshrc.$(date +%Y%m%d_%H%M%S)"
fi

if [ -f "$TEMPLATE_ZSHRC" ]; then
    echo "Copying .zshrc template..."
    cp "$TEMPLATE_ZSHRC" "$ZSHRC"
else
    echo "Template .zshrc not found. Creating basic .zshrc..."
    cat > "$ZSHRC" << 'EOF'
export XDG_CONFIG_HOME="$HOME/.config"

if [ ! -d "$XDG_CONFIG_HOME" ]; then
    mkdir -p "$XDG_CONFIG_HOME"
fi

export GIT_CONFIG_GLOBAL="$XDG_CONFIG_HOME/git/config"
EOF
fi

echo "Creating $XDG_CONFIG_HOME..."
mkdir -p "$XDG_CONFIG_HOME"

echo "Done! Restart your shell or run: source ~/.zshrc"