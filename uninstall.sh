#!/bin/bash

set -e

__info() {
	cat <<-_EOF_
		Dear you ❤️
		Remove Manually directory dotfiles
		rm -rf ~/.dotfiles
	_EOF_
}

if [ "$1" = "-go" ]; then
	echo "Clear Directory Symlinks 🌊..."
	sudo rm -rf -v ~/.local/share/desktop-image-switcher
	rm -rf -v ~/.config
	rm -rf -v ~/.zprofile
	rm -rf -v ~/.utils
	rm -rf -v ~/.code
	rm -rf -v ~/.notes
	rm -rf -v ~/ebook
	rm -rf -v ~/pix
	sudo rm -rf -v ~/Library/Fonts
	rm -rf -v /usr/local/share/zsh
	rm -rf -v /usr/local/bin/osx
	rm -rf -v /usr/local/bin/preview
	rm -rf -v /usr/local/bin/search
	rm -rf -v /usr/local/bin/desktop-image-switcher
	rm -rf -v /usr/local/share/man
	rm -rf -v /usr/local/bin/nvim
	rm -rf -v /Applications/AltTab.app
	rm -rf -v /Applications/Firefox.app
	rm -rf -v /Applications/Brave\ Browser.app
	rm -rf -v /Applications/Docker.app
	rm -rf -v /Applications/kitty.app
	rm -rf -v /Applications/qView.app

	echo "Uninstalling Package 🌊..."
	brew list --cask | xargs brew uninstall --force --ignore-dependencies
	brew list | xargs brew uninstall --force --ignore-dependencies
	echo "Uninstall Package Sucessfully 🌟..."

	echo "Uninstalling Homebrew 🌊..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
	echo "Uninstall Homebrew Sucessfully 🌟..."

	echo "Remove Directory 🌊..."
	sudo rm -rf -v /opt/homebrew
	echo "Remove direcotry /opt/homebrew sucessfuly 🌟.."

	__info
	echo "Process Complete 🌟..."
elif [ -n "$1" ]; then
	echo "uninstall.sh failed 🙅"
	echo "uninstall.sh -go for started 🧘"
	exit
else
	echo "uninstall.sh failed 🙅"
	echo "uninstall.sh -go for started 🧘"
fi
