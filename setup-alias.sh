#!/bin/bash

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

ALIAS_DIR="$XDG_CONFIG_HOME/alias"

mkdir -p "$ALIAS_DIR"

cp -r "$(dirname "$0")/dotfiles/alias/"* "$ALIAS_DIR/"

echo "Aliases copied to $ALIAS_DIR"

# shellcheck disable=SC2016
ALIAS_LOAD_CODE='
# Load aliases from alias directory
for file in "$XDG_CONFIG_HOME/alias/"*.zsh; do
    [ -f "$file" ] && source "$file"
done'

ZSHRC_FILE="$HOME/.zshrc"

if ! grep -q "Load aliases from alias directory" "$ZSHRC_FILE"; then
    echo "$ALIAS_LOAD_CODE" >> "$ZSHRC_FILE"
    echo "Alias loader added to $ZSHRC_FILE"
else
    echo "Alias loader already exists in $ZSHRC_FILE"
fi
