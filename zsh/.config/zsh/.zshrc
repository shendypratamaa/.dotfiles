export HISTFILE="$XDG_CACHE_HOME/zsh/zsh_history"
export LESSHISTFILE="$XDG_DATA_HOME/lesshst"

export HISTSIZE=10000
export SAVEHIST=10000

# auto_cd
setopt auto_cd
set -o ignoreeof

# colors
autoload -U colors && colors

# completions
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
compinit -d $XDG_CACHE_HOME/zsh/zcompdump
_comp_options+=(globdots)

# functions
source "$ZDOTDIR/zsh-functions"

# FZF Key bindings
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

# sources file
zsh_add_file "zsh-exports"
zsh_add_file "zsh-aliases"
zsh_add_file "zsh-prompt"
zsh_add_file "zsh-completions"
zsh_add_file "zsh-vim-mode"
zsh_add_file "zsh-fzf"
zsh_add_file "zsh-docker"

# plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "hlissner/zsh-autopair"
