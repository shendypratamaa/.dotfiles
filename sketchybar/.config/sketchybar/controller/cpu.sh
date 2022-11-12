#!/usr/bin/env sh

cpu=$(printf "%.2f\n" $(top -l 2 | grep -E "^CPU" | tail -1 | awk '{ print $3 + $5 }'))

sketchybar -m --set $NAME icon=🧠 label="cpu $cpu % |"
