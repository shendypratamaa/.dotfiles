# Personal Development Environment

## Ingredients 🥘

```"info"
TERM      => [Kitty, Tmux]

SHELL     => [Zsh]

PCKG      => [Homebrew]

VCS       => [Git, Lazygit, Delta]

EDITOR    => [Neovim 0.7.2]

WM        => [Yabai]

BAR       => [Sketchybar]

KEY       => [Karabiner, skhd]

FM        => [LF]

FONT      => [JetBrainsMono Nerd Font Mono]
```

## Installation : 1

This option, I assume you dont have config at all like setup shell `~/.config/zsh/.zshrc` \
`~/.zshrc` `~/.zprofile`, or maybe already installed `homebrew` or `neovim` \
this scripts bellow will install `homebrew` `homebrew package` and `neovim` \
sync with my `dotfiles`, it means install all package list from `brewfile` \
where I was set up before and `stow` my dotfiles config. \
`neovim` plugins will include with this script using `packer`

> 💁 FYI \
> "when neovim installation throwing error, just press continue | return on keyboard \
> and installation will continue the process
> "

**install.sh**

```git"
git clone https://github.com/shendypratamaa/.dotfiles.git && ~/.dotfiles/install.sh -go
```

> _this installation take much time, based on your internet connection, keep chil_

<hr>

**uninstall.sh**

this script will uninstall configuration include all package from homebrew, \
clean uninstall homebrew from your machine \
remove symlink files or directory from homebrew and dotfiles config

```git"
~/.dotfiles/uninstall.sh -go
```

<hr>

## Installation : 2

This option, you will get only my configure dotfiles \
I assume you already installed homebrew you will need `git` and GNU `stow`

**Repository**

```"git"
git clone https://github.com/shendypratamaa/.dotfiles.git
```

**Homebrew**

```"git"
brew install git
```

```"git"
brew install stow
```

**gnu-stow**

```"git"
stow */ # Everything (the '/' ignores files inside .dotfiles eg README and etc)
```

```"git"
stow zsh # Specified DIR
```

## Notes 📖

Currently running on macOS Ventura 13.0

> please read, take what you need, do with your own risk
