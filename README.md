# Personal Development Environment

![example](./ohmysetup.png)

## Ingredients 🥘

```"info"
Terminal  => [Kitty, Tmux]

Shell     => [Zsh]

Pckg      => [Homebrew]

Vcs       => [Git, Lazygit, Delta]

Editor    => [Neovim 0.7.2]

WM        => [Yabai, Skhd]

Stat      => [Ubersicht, Simple-bar]

Font      => [JetBrains Mono]

Key       => [Karabiner]
```

## Installation : 1

using this option, I assume you dont have config at all e.g : `~/.config/*`\
or setup shell like `~/.zshrc` and `~/.zprofile` or already installed homebrew, \
you can move your `old_config` to another directory for backup, \
this scripts bellow will install `homebrew` and sync with my `dotfiles` \
it means, install all package list from `brewfile` where I was set up before \
and `stow` my dotfiles config.

**install.sh**

```git"
git clone https://github.com/shendypratamaa/.dotfiles.git && ~/.dotfiles/install.sh -go
```

- **node** \
     `nvm install --lts && nvm use node`

- **zsh-plugins** \
     re-open terminal will install zsh utils, or you can type `src`

- **tmux-plugins** \
     go to tmux session `ctrl-a + shift-i` will install tpm etc

- **check installation**\
     last check with `brew doctor` if the output is _your system is ready to brew_ \
     `myconfig` config ready to go, great your awesome 💕

_this installation take much time, based on your internet connection, keep chil_

**uninstall.sh**

this script will uninstall configuration from my dotfiles, \
include all package from homebrew, \
clean uninstall homebrew from your machine \
remove symlink files or directory from homebrew and dotfiles config

```git"
uninstall.sh -go
```

<hr>

## Installation : 2

using this option, you will get only my configure dotfiles \
I assume you already installed homebrew \
you will need `git` and GNU `stow`

**Homebrew** :

```"git"
brew install git
```

```"git"
brew install stow
```

clone into your `$HOME` directory `~`

```"git"
https://github.com/shendypratamaa/.dotfiles.git ~
```

run `stow` to symlink everything, or select specified config

```"git"
stow */ # Everything (the '/' ignores files inside .dotfiles eg README and etc)
```

```"git"
stow zsh # Specified DIR
```

## Notes 📖

this work for **UNIX-LIKE**\
im refere using **XDG_CONFIG_SPESIFICATION**\
please read, and do with your own risk

- [XDG_SPESIFICATION](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)

> _Running on macOS 12.6 Apple Silicon_
