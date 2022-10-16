HISTSIZE=10000
SAVEHIST=10000

# auto_cd
setopt auto_cd

# colors
autoload -U colors && colors

# completions
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION
compinit -d ~/.cache/zsh/zcompdump
_comp_options+=(globdots)

# functions
source "$ZDOTDIR/zsh-functions"

# FZF Key bindings
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

# sources file
zsh_add_file "zsh-exports"
zsh_add_file "zsh-aliases"
zsh_add_file "zsh-prompt"
zsh_add_file "zsh-vim-mode"
zsh_add_file "zsh-fzf-utils"
zsh_add_file "zsh-completions"

# plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "hlissner/zsh-autopair"

# For more plugins: https://github.com/unixorn/awesome-zsh-plugins
# More completions https://github.com/zsh-users/zsh-completions
