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
	~/.docker
	~/.colima
	~/.lima
	~/ebook
	~/pix
	~/Library/Fonts
	/Applications/Folx.app
	/Applications/Figma.app
	/Applications/kitty.app
	/Applications/qView.app
	/Applications/AltTab.app
	/Applications/zoom.us.app
	/Applications/Firefox.app
	/Applications/Discord.app
	/Applications/Whatsapp.app
	/Applications/AppCleaner.app
	/Applications/Brave\ Browser.app
	/Applications/SF\ Symbols.app
	/Applications/Karabiner-Elements.app
	/Applications/Karabiner-EventViewer.app
	/usr/local/bin/nvim
	/usr/local/bin/perlsh
	/usr/local/bin/bash
	/usr/local/bin/sed
	/usr/local/bin/grep
	/usr/local/bin/clean
	/usr/local/bin/dswall
	/usr/local/bin/getwall
	/usr/local/bin/osx
	/usr/local/bin/preview
	/usr/local/bin/search
	/usr/local/bin/brightness
	/usr/local/bin/pipe-viewer
	/usr/local/bin/desktop-image-switcher
	/usr/local/bin/tmux-ch.sh
	/usr/local/bin/tmux-sessionizer
	/usr/local/bin/bloatednvmstupidshit
	/usr/local/share/zsh
	/usr/local/share/man
	/opt/homebrew
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

	read -r -p "Remove direcotry /opt/homebrew sucessfuly 🌟..." -t 2 | tr '%' '\n'

	sleep 2 && kill -9 "$(ps -ax -o pid,comm | sort | grep caffeinate | awk 'NR==1{print $1}')" 2>/dev/null

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
