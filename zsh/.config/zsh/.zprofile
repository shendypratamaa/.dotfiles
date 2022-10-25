# dont dupilicated my path
typeset -U PATH

# XDG Directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIRS="/usr/local"

# ZSHRC
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export SHELL_SESSIONS_DISABLE=1

# completions
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
compinit -d $XDG_CACHE_HOME/zsh/zcompdump
_comp_options+=(globdots)

# NVM
export NVM_DIR="$XDG_DATA_DIRS/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# PYTHON
export PYENV_ROOT="$XDG_DATA_DIRS/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PIPENV_PYTHON="$PYENV_ROOT/shims"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'

# BREW/BIN/SBIN
eval "$(/opt/homebrew/bin/brew shellenv)"

# FZF
export PATH="/opt/homebrew/opt/fzf/bin:$PATH"

# MYSCRIPT
export PATH="$HOME/.local/bin:$PATH"
