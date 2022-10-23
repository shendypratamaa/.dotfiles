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

## Installing

you will need `git` and GNU `stow`

install `git` and `stow` with your fav package manager

Homebrew installation :

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
please read, and get what you want

- [XDG_SPESIFICATION](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)

> _Running on macOS 12.6 Apple Silicon_