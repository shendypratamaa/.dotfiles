#!/usr/bin/env sh

disk=$(df -H | awk '/\/dev\/disk3s1/ {printf("%s\n", $4)}')

sketchybar -m --set $NAME label="💾 $disk |"
