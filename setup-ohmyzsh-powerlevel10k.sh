#!/bin/bash

set -e

echo "=== Oh My Zsh & PowerLevel10k Setup Script ==="
echo ""

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_ZSHRC="$SCRIPT_DIR/dotfiles/.zshrc"

# Install Oh My Zsh
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo ""

# Copy .zshrc template (Oh My Zsh installation overwrites it)
if [ -f "$TEMPLATE_ZSHRC" ]; then
    echo "Copying .zshrc template..."
    cp "$TEMPLATE_ZSHRC" "$HOME/.zshrc"
fi

echo ""

# Install PowerLevel10k
echo "Installing PowerLevel10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k

echo ""

# Install zsh-autosuggestions
echo "Installing zsh-autosuggestions..."
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions

echo ""

# Install zsh-syntax-highlighting
echo "Installing zsh-syntax-highlighting..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting

echo ""

# Update .zshrc to use PowerLevel10k theme
echo "Updating .zshrc to use PowerLevel10k theme..."
sed -i '' 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

# Update .zshrc to add plugins
echo "Updating .zshrc to add plugins..."
sed -i '' 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc

echo ""
echo "=== Setup Complete ==="
