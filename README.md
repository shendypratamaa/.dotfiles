# Personal Development Environment

![example](./ohmysetup.png)

## Ingredients 🥘

```"info"
TERM      => [Kitty, Tmux]

SHELL     => [Zsh]

PCKG      => [Homebrew]

VCS       => [Git, Lazygit, Delta]

EDITOR    => [Neovim 0.7.2]
                                                  💕
WM        => [Yabai]

BAR       => [Sketchybar]

KEY       => [Karabiner, skhd]

FM        => [LF]

FONT      => [JetBrainsMono Nerd Font Mono]
```

## Installation : 1

using this option, I assume you dont have config at all e.g : `~/.config/*` \
setup shell like `~/.config/zsh/.zshrc` | `~/.zshrc` | `~/.zprofile` \
or maybe already installed homebrew or neovim. move your `old_config` for backup, \
this scripts bellow will install `homebrew` and `neovim` sync with my `dotfiles` \
it means, install all package list from `brewfile` where I was set up before \
and `stow` my dotfiles config. and will install neovim build from source to with \
neovim version 0.7.2 .

**install.sh**

```git"
git clone https://github.com/shendypratamaa/.dotfiles.git && ~/.dotfiles/install.sh -go
```

**after installation sucessfully**

- **node** \
     `nvm install --lts && nvm use node`

- **zsh-plugins** \
     re-open terminal for install zsh-plugins,

_this installation take much time, based on your internet connection, keep chil_
<hr>

**uninstall.sh**

this script will uninstall configuration \
include all package from homebrew, \
clean uninstall homebrew from your machine \
remove symlink files or directory from homebrew and dotfiles config

```git"
~/.dotfiles/uninstall.sh -go
```

<hr>

## Installation : 2

using this option, you will get only my configure dotfiles \
I assume you already installed homebrew \
you will need `git` and GNU `stow`

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

Currently running on macOS Ventura 13.0 \
Environment variable refer to [XDG_Spesification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)

> please read, take what you need, do with your own risk
