# dont dupilicated my path
typeset -U PATH

# XDG Directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export SHELL_SESSIONS_DISABLE=1

eval "$(/opt/homebrew/bin/brew shellenv)"
