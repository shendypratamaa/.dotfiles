#!/usr/bin/env sh

cal=$(date '+%A %d/%m/%y')
time=$(date '+%H:%M')

sketchybar --set $NAME icon= label="📅 $cal | ⏰ $time |"
