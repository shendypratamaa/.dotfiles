#!/usr/bin/env sh

VOLUME=$(osascript -e "output volume of (get volume settings)")
MUTED=$(osascript -e "output muted of (get volume settings)")

if [[ $MUTED != "false" ]]; then
	sketchybar --set $NAME icon=🔇 label="$VOLUME% |"
else
	sketchybar --set $NAME icon=🔊 label="$VOLUME% |"
fi
