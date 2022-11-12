#!/usr/bin/env sh

MIC_VOLUME=$(osascript -e 'input volume of (get volume settings)')

if [[ $MIC_VOLUME -eq 0 ]]; then
	osascript -e 'set volume input volume 25'
	sketchybar -m --set mic label="🔥 on |"
elif [[ $MIC_VOLUME -gt 0 ]]; then
	osascript -e 'set volume input volume 0'
	sketchybar -m --set mic label="🙊 off |"
fi
