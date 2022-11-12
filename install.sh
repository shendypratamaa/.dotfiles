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
	skhd
	stylua
	tmux
	vscode
	yabai
	zathura
	zsh
	btop
	pipe-viewer
	lf
)

if [ "$1" = '-go' ]; then
	# install homebrew
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	eval "$(/opt/homebrew/bin/brew shellenv)"

	brew tap zegervdv/zathura

	brew reinstall bash || brew install bash
	brew reinstall git || brew install git
	brew reinstall stow || brew install stow
	brew reinstall zathura || brew install zathura
	brew reinstall zathura-pdf-poppler || brew install zathura-pdf-poppler

	mkdir -p "$(brew --prefix zathura)/lib/zathura"
	ln -s "$(brew --prefix zathura-pdf-poppler)/libpdf-poppler.dylib" "$(brew --prefix zathura)/lib/zathura/libpdf-poppler.dylib"

	brew reinstall mpv || brew install mpv

	# BECAUSE MACOS SUCKS !!
	# after update ventura 13, yabai not fully support in version 5.0.1
	# with yabai --head everything work but if you re-run this script
	# and restart your system you must regenerate shasum -a 256 $(which yabai)
	# and replace into sha(hash) with sudo visudo -f /private/etc/sudoers.d/yabai
	# go to yabai documentation github, and read issue for macos ventura
	brew reinstall koekeishiya/formulae/yabai --HEAD || brew install koekeishiya/formulae/yabai --HEAD
	codesign -fs 'yabai-cert' $(which yabai)

	brew link bash || brew link --overwrite bash
	brew link git || brew link --overwrite git
	brew link libmagic || brew link --overwrite libmagic

	if [ -d "$HOME/.dotfiles" ]; then
		cd ~/.dotfiles && stow -v "${dotfilesdir[@]}"
		ln -sf ~/.dotfiles/scripts/** /usr/local/bin/
	fi

	ln -sf ~/.config/zsh/.zprofile ~/.zprofile

	echo "Package Update 🍺..."
	brew update --verbose --force && brew upgrade

	echo "Package Update From Brewfile 🎞️..."
	brew bundle -v --file=~/.config/brewfile/Brewfile

	python3.10 -m pip install --upgrade pip
	pip3 install --ignore-installed pynvim
	pip3 install --ignore-installed flake8
	pip3 install --ignore-installed black
	pip3 install --ignore-installed isort

	if [ -d "$HOME/.local/share/desktop-image-switcher" ]; then
		rm -rf ~/.local/share/desktop-image-switcher
		git clone https://github.com/GabrielDougherty/desktop-image-switcher ~/.local/share/desktop-image-switcher
		cd ~/.local/share/desktop-image-switcher && sudo make install
	else
		git clone https://github.com/GabrielDougherty/desktop-image-switcher ~/.local/share/desktop-image-switcher
		cd ~/.local/share/desktop-image-switcher && sudo make install
	fi

	if [ -d "$HOME/.local/share/pipe-viewer-main" ]; then
		sudo rm -rf ~/.local/share/pipe-viewer-main
		wget https://github.com/trizen/pipe-viewer/archive/main.zip --no-check-certificate -O ~/.local/share/pipe-viewer-main.zip
		unzip -n ~/.local/share/pipe-viewer-main.zip
		rm -rf ~/.local/share/pipe-viewer-main.zip
		cd ~/.local/share/pipe-viewer-main && perl Build.PL && sudo ./Build installdeps && sudo ./Build install
	else
		wget https://github.com/trizen/pipe-viewer/archive/main.zip --no-check-certificate -O ~/.local/share/pipe-viewer-main.zip
		unzip -n ~/.local/share/pipe-viewer-main.zip
		rm -rf ~/.local/share/pipe-viewer-main.zip
		cd ~/.local/share/pipe-viewer-main && perl Build.PL && sudo ./Build installdeps && sudo ./Build install
	fi

	# homebrew/share/man
	if [ -d "/opt/homebrew/share/man/man4" ]; then
		rm -rf -v /opt/homebrew/share/man/man4
		mkdir -v /opt/homebrew/share/man/man4
	else
		mkdir -v /opt/homebrew/share/man/man4
	fi

	if [ -d "/opt/homebrew/share/man/man6" ]; then
		rm -rf -v /opt/homebrew/share/man/man6
		mkdir -v /opt/homebrew/share/man/man6
	else
		mkdir -v /opt/homebrew/share/man/man6
	fi

	if [ -d "/opt/homebrew/share/man/man9" ]; then
		rm -rf -v /opt/homebrew/share/man/man9
		mkdir -v /opt/homebrew/share/man/man9
	else
		mkdir -v /opt/homebrew/share/man/man9
	fi

	if [ -d "/opt/homebrew/share/man/mann" ]; then
		rm -rf -v /opt/homebrew/share/man/mann
		mkdir -v /opt/homebrew/share/man/mann
	else
		mkdir -v /opt/homebrew/share/man/mann
	fi

	# usr/share/man
	if [ -d "/usr/local/share/man" ]; then
		rm -rf /usr/local/share/man
		mkdir -p -v /usr/local/share/man
	else
		mkdir -p -v /usr/local/share/man
	fi

	if [ -d "/usr/local/share/zsh/site-functions" ]; then
		rm -rf /usr/local/share/zsh/site-functions
		mkdir -p -v /usr/local/share/zsh/site-functions
	else
		mkdir -p -v /usr/local/share/zsh/site-functions
	fi

	ln -sf -v /usr/share/zsh/5.8.1/functions/** /opt/homebrew/share/zsh/site-functions/
	ln -sf -v /usr/share/man/man1/** /opt/homebrew/share/man/man1/
	ln -sf -v /usr/share/man/man4/** /opt/homebrew/share/man/man4/
	ln -sf -v /usr/share/man/man5/** /opt/homebrew/share/man/man5/
	ln -sf -v /usr/share/man/man6/** /opt/homebrew/share/man/man6/
	ln -sf -v /usr/share/man/man7/** /opt/homebrew/share/man/man7/
	ln -sf -v /usr/share/man/man8/** /opt/homebrew/share/man/man8/
	ln -sf -v /usr/share/man/man9/** /opt/homebrew/share/man/man9/
	ln -sf -v /usr/share/man/mann/** /opt/homebrew/share/man/mann/
	ln -sf -v /opt/homebrew/share/man/** /usr/local/share/man/
	ln -sf -v /opt/homebrew/share/zsh/site-functions/** /usr/local/share/zsh/site-functions

	echo "Package Cleanup 🌊..."
	brew cleanup && brew cleanup --prune=all
	brew autoremove

	echo "Package Info 🗓️..."
	brew info

	echo "Package Bundle 📦..."
	brew bundle dump --desc --force --file=~/.config/brewfile/Brewfile

	echo "Process Complete 🌟..."
elif [ -n "$1" ]; then
	echo "install.sh failed 🙅"
	echo "install.sh -go for started 🧘"
	exit
else
	echo "install.sh failed 🙅"
	echo "install.sh -go for started 🧘"
fi
