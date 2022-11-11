#!/usr/bin/env sh

cal=$(date '+%d/%m')
time=$(date '+%H:%M')

sketchybar --set $NAME label="| 📅 $cal | ⏰ $time |"
