# XDG Directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export SHELL_SESSIONS_DISABLE=1

eval $(/opt/homebrew/bin/brew shellenv)

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PIPENV_PYTHON="$PYENV_ROOT/shims"

eval "$(pyenv init --path)"
