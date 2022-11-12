#!/usr/bin/env sh

cal=$(date '+%d %b %Y')
time=$(date '+%H:%M')

sketchybar --set $NAME label="📅 $cal | ⏰ $time |"
