#!/bin/bash

set -e

if [ "$1" = '-g' ]; then
	# clone dotfiles
	/usr/bin/git clone clone https://github.com/shendypratamaa/.dotfiles.git >~
	/usr/bin/git clone clone https://github.com/shendypratamaa/.utils.git >~

	# symlink dotfiles
	cd ~/.dotfiles && stow */
	cd ~/.utils && stow */

	# install homebrew
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	package -a

	# nvm
	nvm install v16.18.0
	npm install --global nodemon yarn

	# symlink
	ln -sf -v /usr/share/zsh/5.8.1/functions/** /opt/homebrew/share/zsh/site-functions/
	ln -sf -v /usr/share/man/man1/** /opt/homebrew/share/man/man1/
	ln -sf -v /usr/share/man/man4/** /opt/homebrew/share/man/man4/
	ln -sf -v /usr/share/man/man5/** /opt/homebrew/share/man/man5/
	ln -sf -v /usr/share/man/man6/** /opt/homebrew/share/man/man6/
	ln -sf -v /usr/share/man/man7/** /opt/homebrew/share/man/man7/
	ln -sf -v /usr/share/man/man8/** /opt/homebrew/share/man/man8/
	ln -sf -v /usr/share/man/man9/** /opt/homebrew/share/man/man9/
	ln -sf -v /usr/share/man/mann/** /opt/homebrew/share/man/mann/
elif [ -n "$1" ]; then
	echo "install.sh not found 🙅"
	echo "install.sh -help for information 💁"
	exit
else
	echo "install.sh not found 🙅"
	echo "install.sh -help for information 💁"
fi
