#!/bin/bash

set -e

update() {
  echo "=================="
  echo "Package Update ⚙️"
  echo "=================="
  brew update
  brew bundle -v --file=~/.config/brewfile/Brewfile
  brew upgrade
  brew info
}

clean(){
  echo "================="
  echo "Package Clean 🤖"
  echo "================="
  brew cleanup
  brew autoremove
}

leave(){
  echo "====================="
  echo "Process Complete! ⭐"
  echo "====================="
  exit
}

if [ "$1" == "-u" ]; then
  update
  clean
  leave
fi

if [ "$1" == "-c" ]; then
  clean
  leave
fi
