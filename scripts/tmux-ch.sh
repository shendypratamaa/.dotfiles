#!/bin/bash

languages=$(echo "javascript typescript bash python3 lua" | tr " " "\n")
coreutils=$(echo "find xargs sed awk zip rar curl wget" | tr " " "\n")
selected=$(echo -e "$languages\n$coreutils" | fzf --prompt="select > ")
preview="bat --style=plain --paging=always"

read -r -p "💁 looking for > " query

if echo "$languages" | grep -qs "$selected"; then
	tmux split-window -p 50 -h bash -c "curl cht.sh/$selected/$(echo "$query" | tr " " +) | $preview"
else
	tmux split-window -p 50 -h bash -c "curl cht.sh/$selected~$query | $preview"
fi
