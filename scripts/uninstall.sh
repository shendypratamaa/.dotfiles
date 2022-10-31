#!/bin/bash

set -e

if [ "$1" = "-g" ]; then
	rm -rf -v ~/.config
	rm -rf -v ~/.zprofile
	rm -rf -v ~/.utils
	rm -rf -v ~/.code
	rm -rf -v ~/.notes
	rm -rf -v ~/Pictures/wallpaper
	rm -rf -v ~/Pictures/roadmap

	echo "Uninstalling Package 🌊..."
	brew list --cask | xargs brew uninstall --force --ignore-dependencies
	brew list | xargs brew uninstall --force --ignore-dependencies
	echo "Uninstall Package Sucessfully 🌟..."

	echo "Uninstalling Homebrew 🌊..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
	echo "Uninstall Homebrew Sucessfully 🌟..."

	echo "Remove Directory 🌊..."
	sudo rm -rf -v /opt/homebrew
	echo "Process Complete 🌟..."

elif [ -n "$1" ]; then
	echo "uninstall failed 🙅"
	echo "uninstall -help for information 💁"
	exit
else
	echo "uninstall failed 🙅"
	echo "uninstall -help for information 💁"
fi
