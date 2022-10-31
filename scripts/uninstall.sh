#!/bin/bash

set -e 

if [ "$1" = "-g" ]; then
	# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
	sudo rm -rf /opt/homebrew
elif [ -n "$1" ]; then
	echo "uninstall failed 🙅"
	echo "uninstall -help for information 💁"
	exit
else
	echo "uninstall failed 🙅"
	echo "uninstall -help for information 💁"
fi

