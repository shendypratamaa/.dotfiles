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

	##########################      NEOVIM      ##################################

	# NEOVIM_SOURCE
	if [ -d "$HOME/.local/share/neovim" ]; then
		sudo rm -rf -v /usr/local/bin/nvim
		sudo rm -rf -v /usr/local/share/nvim
		sudo rm -rf -v ~/.local/share/neovim
		git clone https://github.com/neovim/neovim ~/.local/share/neovim
		cd ~/.local/share/neovim
		git checkout v0.7.2
		make CMAKE_BUILD_TYPE=Release
		sudo make install
	else
		git clone https://github.com/neovim/neovim ~/.local/share/neovim
		cd ~/.local/share/neovim
		git checkout v0.7.2
		make CMAKE_BUILD_TYPE=Release
		sudo make install
	fi

	# PACKER
	# git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

	##########################      NEOVIM      ##################################

	##########################      HOMEBREW    #################################

	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	eval "$(/opt/homebrew/bin/brew shellenv)"

	brew reinstall git || brew install git
	brew link git || brew link --overwrite git

	brew reinstall stow || brew install stow
	brew reinstall mpv || brew install mpv

	brew tap zegervdv/zathura
	brew reinstall zathura || brew install zathura
	brew reinstall zathura-pdf-poppler || brew install zathura-pdf-poppler
	mkdir -p "$(brew --prefix zathura)/lib/zathura"
	ln -sf "$(brew --prefix zathura-pdf-poppler)/libpdf-poppler.dylib" "$(brew --prefix zathura)/lib/zathura/libpdf-poppler.dylib"

	# INFO
	# with yabai --head everything work but if you re-run this script
	# and restart your system you must regenerate shasum -a 256 $(which yabai)
	# and replace into sha(hash) with sudo visudo -f /private/etc/sudoers.d/yabai
	# go to yabai documentation github, and read issue for macos ventura
	brew tap koekeishiya/formulae
	brew reinstall yabai --HEAD || brew install yabai --HEAD
	codesign -fs 'yabai-cert' "$(which yabai)"

	# STOW MY DOTFILES
	if [ -d "$HOME/.dotfiles" ]; then
		cd ~/.dotfiles && stow -v "${dotfilesdir[@]}"
		ln -sf ~/.dotfiles/scripts/** /usr/local/bin/
	fi

	ln -sf ~/.config/zsh/.zprofile ~/.zprofile

	echo "Package Update 🍺..."
	brew update --verbose --force && brew upgrade

	echo "Package Update From Brewfile 🎞️..."
	brew bundle -v --file=~/.config/brewfile/Brewfile

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

	# usr/local/share/man
	if [ -d "/usr/local/share/man" ]; then
		rm -rf /usr/local/share/man
		mkdir -p -v /usr/local/share/man
	else
		mkdir -p -v /usr/local/share/man
	fi

	# usr/local/share/zsh
	if [ -d "/usr/local/share/zsh/site-functions" ]; then
		rm -rf /usr/local/share/zsh/site-functions
		mkdir -p -v /usr/local/share/zsh/site-functions
	else
		mkdir -p -v /usr/local/share/zsh/site-functions
	fi

	sudo ln -sf -v /usr/share/zsh/5.8.1/functions/** /opt/homebrew/share/zsh/site-functions/
	sudo ln -sf -v /opt/homebrew/share/zsh/site-functions/** /usr/local/share/zsh/site-functions
	sudo ln -sf -v /usr/share/man/man1/** /opt/homebrew/share/man/man1/
	sudo ln -sf -v /usr/share/man/man4/** /opt/homebrew/share/man/man4/
	sudo ln -sf -v /usr/share/man/man5/** /opt/homebrew/share/man/man5/
	sudo ln -sf -v /usr/share/man/man6/** /opt/homebrew/share/man/man6/
	sudo ln -sf -v /usr/share/man/man7/** /opt/homebrew/share/man/man7/
	sudo ln -sf -v /usr/share/man/man8/** /opt/homebrew/share/man/man8/
	sudo ln -sf -v /usr/share/man/man9/** /opt/homebrew/share/man/man9/
	sudo ln -sf -v /usr/share/man/mann/** /opt/homebrew/share/man/mann/
	sudo ln -sf -v /opt/homebrew/share/man/** /usr/local/share/man/

	##########################      HOMEBREW    #################################

	##########################   PYTHON UTILS   #################################

	python3.10 -m pip install --upgrade pip
	pip3 install --ignore-installed pynvim
	pip3 install --ignore-installed flake8
	pip3 install --ignore-installed black
	pip3 install --ignore-installed isort

	##########################   PYTHON UTILS   #################################

	##########################     OSX UTILS    #################################

	# DESKTOP-UTILITY
	if [ -d "$HOME/.local/share/desktop-image-switcher" ]; then
		rm -rf ~/.local/share/desktop-image-switcher
		git clone https://github.com/GabrielDougherty/desktop-image-switcher ~/.local/share/desktop-image-switcher
		cd ~/.local/share/desktop-image-switcher && sudo make install
	else
		git clone https://github.com/GabrielDougherty/desktop-image-switcher ~/.local/share/desktop-image-switcher
		cd ~/.local/share/desktop-image-switcher && sudo make install
	fi

	# YT-MUSIC-API-UTILITY
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

	##########################     OSX UTILS    #################################

	##########################     TMUX PLUG     #################################

	export TMUX_PLUGIN_MANAGER_PATH="${HOME}/.config/tmux/plugins"
	if [ -d "$HOME/.config/tmux/plugins" ]; then
		rm -rf -v ~/.config/tmux/plugins
		git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
		"$HOME/.config/tmux/plugins/tpm/bin/install_plugins"
	else
		git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
		"$HOME/.config/tmux/plugins/tpm/bin/install_plugins"
	fi

	##########################     TMUX PLUG     #################################

	echo "Package Cleanup 🌊..."
	brew cleanup && brew cleanup --prune=all
	brew autoremove
	/usr/local/bin/clean -g

	echo "Package Info 🗓️..."
	brew info

	echo "Package Bundle 📦..."
	brew bundle dump --desc --force --file=~/.config/brewfile/Brewfile

	echo "Package Check ✅..."
	brew doctor

	echo "Process Complete 🌟..."
elif [ -n "$1" ]; then
	echo "install.sh failed 🙅"
	echo "install.sh -go for started 🧘"
	exit
else
	echo "install.sh failed 🙅"
	echo "install.sh -go for started 🧘"
fi
