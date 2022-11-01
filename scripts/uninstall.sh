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
	rm -rf -v ~/.config
	rm -rf -v ~/.zprofile
	rm -rf -v ~/.utils
	rm -rf -v ~/.code
	rm -rf -v ~/.notes
	rm -rf -v ~/Pictures/wallpaper
	rm -rf -v ~/Pictures/roadmap
	rm -rf -v /usr/local/bin/install.sh
	rm -rf -v /usr/local/bin/uninstall.sh
	rm -rf -v /usr/local/bin/osx
	rm -rf -v /usr/local/bin/package
	rm -rf -v /usr/local/bin/preview
	rm -rf -v /usr/local/bin/search
	rm -rf -v /usr/local/share/zsh
	rm -rf -v /usr/local/share/man

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
