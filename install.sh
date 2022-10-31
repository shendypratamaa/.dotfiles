#!/bin/bash

set -e

if [ "$1" = '-g' ]; then
	# install homebrew
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew reinstall git || brew install git
	brew reinstall stow || brew install stow

	# delete if exist and create symlinks
	if [ -d "$HOME/.dotfiles" ]; then
		cd ~/.dotfiles && stow */
		ln -sf ~/.dotfiles/install.sh /usr/local/bin/
	fi

	if [ -d "$HOME/.utils" ]; then
		rm -rf ~/.utils
		git clone https://github.com/shendypratamaa/.utils.git ~/.utils
		cd ~/.utils && stow */
	fi

	echo "Package Update 🍺..."
	brew update --verbose --force && brew upgrade

	echo "Package Update From Brewfile 🎞️..."
	brew bundle -v --file=~/.config/brewfile/Brewfile

	echo "Package Info 🗓️..."
	brew info

	echo "Package Cleanup 🌊..."
	brew cleanup && brew cleanup --prune=all
	brew autoremove
	echo "Process Complete 🌟..."
	# end brew

	# create symlinks
	ln -sf -v /usr/share/zsh/5.8.1/functions/** /opt/homebrew/share/zsh/site-functions/
	ln -sf -v /usr/share/man/man1/** /opt/homebrew/share/man/man1/
	ln -sf -v /usr/share/man/man4/** /opt/homebrew/share/man/man4/
	ln -sf -v /usr/share/man/man5/** /opt/homebrew/share/man/man5/
	ln -sf -v /usr/share/man/man6/** /opt/homebrew/share/man/man6/
	ln -sf -v /usr/share/man/man7/** /opt/homebrew/share/man/man7/
	ln -sf -v /usr/share/man/man8/** /opt/homebrew/share/man/man8/
	ln -sf -v /usr/share/man/man9/** /opt/homebrew/share/man/man9/
	ln -sf -v /usr/share/man/mann/** /opt/homebrew/share/man/mann/
	mkdir -p "$(brew --prefix zathura)/lib/zathura"
	ln -sf "$(brew --prefix zathura-pdf-poppler)/libpdf-poppler.dylib" "$(brew --prefix zathura)/lib/zathura/libpdf-poppler.dylib"

elif [ -n "$1" ]; then
	echo "install.sh not found 🙅"
	echo "install.sh -help for information 💁"
	exit
else
	echo "install.sh not found 🙅"
	echo "install.sh -help for information 💁"
fi
