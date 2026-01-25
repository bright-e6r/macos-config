#!/usr/bin/env bash

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

GIT_CONFIG_DIR="$XDG_CONFIG_HOME/git"
GIT_CONFIG_FILE="$GIT_CONFIG_DIR/config"

mkdir -p "$GIT_CONFIG_DIR"

git config --file "$GIT_CONFIG_FILE" user.name "bright.e6r"
git config --file "$GIT_CONFIG_FILE" user.email "bright.e6r@gmail.com"
git config --file "$GIT_CONFIG_FILE" init.defaultBranch main
git config --file "$GIT_CONFIG_FILE" core.autocrlf input
git config --file "$GIT_CONFIG_FILE" core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --file "$GIT_CONFIG_FILE" interactive.diffFilter "diff-so-fancy --patch"

echo "Git config written to $GIT_CONFIG_FILE"