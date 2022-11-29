#!/bin/bash

set -e

dotfilesdir=(
	lf
	git
	mpv
	zsh
	nvim
	skhd
	tmux
	btop
	yabai
	kitty
	python
	stylua
	vscode
	eslint
	flake8
	lazygit
	zathura
	homebrew
	neofetch
	prettier
	karabiner
	sketchybar
	pipe-viewer
)

if [ "$1" = '-go' ]; then

	/usr/bin/caffeinate -d &

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
	# and restart your system you must regenerate shasum -a 256 $(which yabai) | awk '{print $1}'
	# and replace into sha(hash) with sudo visudo -f /private/etc/sudoers.d/yabai
	# go to yabai documentation github, and read issue for macos ventura
	brew tap koekeishiya/formulae
	brew reinstall yabai --HEAD || brew install yabai --HEAD
	codesign -fs 'yabai-cert' "$(which yabai)"

	# STOW MY DOTFILES
	if [ -d "$HOME/.dotfiles" ]; then
		cd ~/.dotfiles && stow -v "${dotfilesdir[@]}"
		ln -sf -v ~/.dotfiles/scripts/** /usr/local/bin/
	fi

	ln -sf -v ~/.config/zsh/.zprofile ~/.zprofile

	echo "Package Update 🍺..."
	brew update --verbose --force && brew upgrade

	echo "Package Update From Brewfile 🎞️..."
	brew bundle -v --file=~/.config/brewfile/Brewfile

	# usr/local/share/zsh
	if [ -d "/usr/local/share/zsh/site-functions" ]; then
		rm -rf -v /usr/local/share/zsh/site-functions
		mkdir -p -v /usr/local/share/zsh/site-functions
	else
		mkdir -p -v /usr/local/share/zsh/site-functions
	fi

	sudo ln -sf -v /opt/homebrew/share/zsh/site-functions/** /usr/local/share/zsh/site-functions

		###################### DOCKER #########################

		if [ -d "/opt/homebrew/opt/docker-compose" ]; then
			if [ -d "$HOME/.docker/cli-plugins" ]; then
				ln -sfn -v "$(brew --prefix)/opt/docker-compose/bin/docker-compose" ~/.docker/cli-plugins/docker-compose
			else
				mkdir -p -v ~/.docker/cli-plugins
				ln -sfn -v "$(brew --prefix)/opt/docker-compose/bin/docker-compose" ~/.docker/cli-plugins/docker-compose
			fi
		fi

		###################### DOCKER #########################

		###################### COREUTILS #########################

		sudo ln -sf -v /opt/homebrew/bin/bash /usr/local/bin/bash
		sudo ln -sf -v /opt/homebrew/bin/gsed /usr/local/bin/sed
		sudo ln -sf -v /opt/homebrew/bin/ggrep /usr/local/bin/grep

		###################### COREUTILS #########################

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
		rm -rf -v ~/.local/share/desktop-image-switcher
		git clone https://github.com/GabrielDougherty/desktop-image-switcher ~/.local/share/desktop-image-switcher
		cd ~/.local/share/desktop-image-switcher && sudo make install
	else
		rm -rf -v /usr/local/bin/desktop-image-switcher
		git clone https://github.com/GabrielDougherty/desktop-image-switcher ~/.local/share/desktop-image-switcher
		cd ~/.local/share/desktop-image-switcher && sudo make install
	fi

	# YT-MUSIC-API-UTILITY
	if [ -d "$HOME/.local/share/pipe-viewer-main" ]; then
		sudo rm -rf -v ~/.local/share/pipe-viewer-main
		wget https://github.com/trizen/pipe-viewer/archive/main.zip --no-check-certificate -O ~/.local/share/pipe-viewer-main.zip
		unzip -d ~/.local/share ~/.local/share/pipe-viewer-main.zip
		cd ~/.local/share/pipe-viewer-main && perl Build.PL && sudo ./Build installdeps && sudo ./Build install
		rm -rf -v ~/.local/share/pipe-viewer-main.zip
	else
		wget https://github.com/trizen/pipe-viewer/archive/main.zip --no-check-certificate -O ~/.local/share/pipe-viewer-main.zip
		unzip -d ~/.local/share ~/.local/share/pipe-viewer-main.zip
		cd ~/.local/share/pipe-viewer-main && perl Build.PL && sudo ./Build installdeps && sudo ./Build install
		rm -rf -v ~/.local/share/pipe-viewer-main.zip
	fi

	# BRIGHTNESS
	if [ -d "$HOME/.local/share/brightness" ]; then
		sudo rm -rf -v ~/.local/share/brightness
		git clone https://github.com/nriley/brightness.git ~/.local/share/brightness
		cd ~/.local/share/brightness
		make
		sudo make install
	else
		git clone https://github.com/nriley/brightness.git ~/.local/share/brightness
		cd ~/.local/share/brightness
		make
		sudo make install
	fi

	##########################     OSX UTILS    #################################

	##########################      NODEJS      #################################

	if [ -d "/opt/homebrew/opt/nvm/" ]; then
		/usr/local/bin/bloatednvmstupidshit
	fi

	##########################       NODEJS     #################################

	##########################      NEOVIM      #################################

	# NEOVIM SOURCE
	if [ -d "$HOME/.local/share/neovim" ]; then
		sudo rm -rf -v ~/.local/share/neovim
		sudo rm -rf -v /usr/local/bin/nvim
		sudo rm -rf -v /usr/local/share/nvim
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

	# NEOVIM PACKER INSTALL
	if [ -d "$HOME/.local/share/nvim" ]; then
		sudo rm -rf -v "$HOME/.local/share/nvim"
		git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
		nvim -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
		nvim -c 'TSUpdate' -c 'Mason'
	else
		git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
		nvim -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
		nvim -c 'TSUpdate' -c 'Mason'
	fi

	##########################      NEOVIM      #################################

	##########################     TMUX PLUG    #################################

	export TMUX_PLUGIN_MANAGER_PATH="${HOME}/.config/tmux/plugins"
	if [ -d "$HOME/.config/tmux/plugins" ]; then
		rm -rf -v ~/.config/tmux/plugins
		git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
		"$HOME/.config/tmux/plugins/tpm/bin/install_plugins"
	else
		git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
		"$HOME/.config/tmux/plugins/tpm/bin/install_plugins"
	fi

	##########################     TMUX PLUG    #################################

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

	read -r -p "Process Complete 🌟..." -t 5 | tr '%' '\n'
	sleep 2 && kill -9 "$(ps -ax -o pid,comm | sort | grep caffeinate | awk 'NR==1{print $1}')" 2>/dev/null
	sleep 2 && kill -9 "$(ps -ax -o pid,comm | sort | grep -E "(terminal|kitty|iterm2|alacritty)" | awk 'NR==1{print $1}')" 2>/dev/null
elif [ -n "$1" ]; then
	echo "install.sh failed 🙅"
	echo "install.sh -go for started 🧘"
	exit
else
	echo "install.sh failed 🙅"
	echo "install.sh -go for started 🧘"
fi
