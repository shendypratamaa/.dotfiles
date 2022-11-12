#!/usr/bin/env sh

VOLUME=$(osascript -e "output volume of (get volume settings)")
MUTED=$(osascript -e "output muted of (get volume settings)")

if [[ $MUTED != "false" ]]; then
	sketchybar -m --set $NAME label="🙉 $VOLUME% |"
else
	sketchybar -m --set $NAME label="🎧 $VOLUME% |"
fi
