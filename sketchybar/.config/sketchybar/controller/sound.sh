#!/usr/bin/env sh

VOLUME=$(osascript -e "output volume of (get volume settings)")
MUTED=$(osascript -e "output muted of (get volume settings)")

if [[ $MUTED != "false" ]]; then
	ICON="🙉"
else
	ICON="🎧"
fi

sketchybar -m --set $NAME icon="| $ICON" \
                    $NAME label="$VOLUME%"
