#!/bin/bash

set -e

__info() {
	cat <<-_EOF_
		Dear you ❤️
		Remove Manually directory dotfiles
		rm -rf ~/.dotfiles
	_EOF_
}

removepath=(
	~/.local/share/desktop-image-switcher
	~/.local/share/pipe-viewer-main
	~/.local/share/brightness
	~/.local/share/nvim
	~/.config
	~/.zprofile
	~/.utils
	~/.code
	~/.notes
	~/ebook
	~/pix
	~/Library/Fonts
	/Applications/AltTab.app
	/Applications/Firefox.app
	/Applications/Brave\ Browser.app
	/Applications/Docker.app
	/Applications/kitty.app
	/Applications/qView.app
	/usr/local/share/zsh
	/usr/local/share/man
	/usr/local/bin/desktop-image-switcher
	/usr/local/bin/brightness
	/usr/local/bin/pipe-viewer
	/usr/local/bin/perlsh
	/usr/local/bin/bash
	/usr/local/bin/sed
	/usr/local/bin/clean
	/usr/local/bin/dswall
	/usr/local/bin/getwall
	/usr/local/bin/osx
	/usr/local/bin/preview
	/usr/local/bin/search
	/usr/local/bin/tmux-ch.sh
	/usr/local/bin/tmux-sessionizer
	/usr/local/bin/nvim
)

if [ "$1" = "-go" ]; then
	/usr/bin/caffeinate -d &

	echo "Clear Directory Symlinks 🌊..."
	sudo rm -rf -v "${removepath[@]}"

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

	kill -9 "$(ps -a | pgrep caffeinate | awk '{print $1; exit}')"

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
