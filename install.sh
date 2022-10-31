#!/bin/bash

set -e

dotfilesdir=(
	eslint
	flake8
	git
	homebrew
	karabiner
	kitty
	lazygit
	mpv
	neofetch
	nvim
	prettier
	python
	ranger
	skhd
	stylua
	tmux
	vscode
	yabai
	zathura
	zsh
)

if [ "$1" = '-g' ]; then
	echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>/Users/shendypratama/.zprofile

	# install homebrew
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	brew reinstall git || brew install git
	brew reinstall stow || brew install stow

	if [ -d "$HOME/.dotfiles" ]; then
		cd ~/.dotfiles && stow -v "${dotfilesdir[@]}"
		ln -sf ~/.dotfiles/scripts/** /usr/local/bin/
	fi

	if [ -d "$HOME/.utils" ]; then
		rm -rf ~/.utils
		git clone https://github.com/shendypratamaa/.utils.git ~/.utils
		cd ~/.utils && stow */
	fi

	ln -sf ~/.config/zsh/.zprofile ~/.zprofile

	echo "Package Update 🍺..."
	brew update --verbose --force && brew upgrade

	echo "Package Update From Brewfile 🎞️..."
	brew bundle -v --file=~/.config/brewfile/Brewfile

	brew tap zegervdv/zathura

	brew install zathura
	brew install zathura-pdf-poppler
	mkdir -p "$(brew --prefix zathura)/lib/zathura"
	ln -s "$(brew --prefix zathura-pdf-poppler)/libpdf-poppler.dylib" "$(brew --prefix zathura)/lib/zathura/libpdf-poppler.dylib"

	brew install --cask mpv

	brew link --overwrite git
	brew link --overwrite libmagic

	# (usr/share -> opt/homebrew)  => usr/local
	ln -sf -v /usr/share/zsh/5.8.1/functions/** /opt/homebrew/share/zsh/site-functions/

	mkdir /opt/homebrew/share/man/man4
	mkdir /opt/homebrew/share/man/man6
	mkdir /opt/homebrew/share/man/man9
	mkdir /opt/homebrew/share/man/mann

	ln -sf -v /usr/share/man/man1/** /opt/homebrew/share/man/man1/
	ln -sf -v /usr/share/man/man4/** /opt/homebrew/share/man/man4/
	ln -sf -v /usr/share/man/man5/** /opt/homebrew/share/man/man5/
	ln -sf -v /usr/share/man/man6/** /opt/homebrew/share/man/man6/
	ln -sf -v /usr/share/man/man7/** /opt/homebrew/share/man/man7/
	ln -sf -v /usr/share/man/man8/** /opt/homebrew/share/man/man8/
	ln -sf -v /usr/share/man/man9/** /opt/homebrew/share/man/man9/
	ln -sf -v /usr/share/man/mann/** /opt/homebrew/share/man/mann/

	echo "Package Cleanup 🌊..."
	brew cleanup && brew cleanup --prune=all
	brew autoremove

	echo "Package Info 🗓️..."
	brew info

	echo "Process Complete 🌟..."
elif [ -n "$1" ]; then
	echo "install.sh not found 🙅"
	echo "install.sh -help for information 💁"
	exit
else
	echo "install.sh not found 🙅"
	echo "install.sh -help for information 💁"
fi
