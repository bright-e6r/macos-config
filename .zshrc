export XDG_CONFIG_HOME="$HOME/.config"

if [ ! -d "$XDG_CONFIG_HOME" ]; then
    mkdir -p "$XDG_CONFIG_HOME"
fi

export GIT_CONFIG_GLOBAL="$XDG_CONFIG_HOME/git/config"