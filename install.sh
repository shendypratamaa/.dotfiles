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
)

if [ "$1" = '-go' ]; then
	# install homebrew
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	eval "$(/opt/homebrew/bin/brew shellenv)"

	brew reinstall git || brew install git 2>/dev/null
	brew reinstall stow || brew install stow

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

	curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh

	git clone https://github.com/GabrielDougherty/desktop-image-switcher ~/.local/share/ && sudo make install

	brew tap zegervdv/zathura

	brew reinstall zathura || brew install zathura
	brew reinstall zathura-pdf-poppler || brew install zathura-pdf-poppler
	mkdir -p "$(brew --prefix zathura)/lib/zathura"
	ln -s "$(brew --prefix zathura-pdf-poppler)/libpdf-poppler.dylib" "$(brew --prefix zathura)/lib/zathura/libpdf-poppler.dylib"

	brew reinstall --cask mpv || brew install --cask mpv

	brew link git || brew link --overwrite git
	brew link libmagic || brew link --overwrite git

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
