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

**install.sh**\

```git"
git clone https://github.com/shendypratamaa/.dotfiles.git && ~/.dotfiles/install.sh -go
```

if your choice using this option, I assume you have no config at all \
e.g : `~/.config/*` or setup shell like `~/.zshrc` or `~/.zprofile` \
you can move your `old_config` to another directory for backup \
this option will install `homebrew` and sync with my dotfiles \
install all packages where I set up before and \
maybe take some time based on your internet connection \
and that it, your ready to go

**uninstall.sh**
if you want to uninstall all configuration

```git"
uninstall.sh -go
```

this script will uninstall all package, and uninstall homebrew

## Installation : 2

if your choice using this option, you will get only my configure dotfiles \
I assume you have already installed homebrew \
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
