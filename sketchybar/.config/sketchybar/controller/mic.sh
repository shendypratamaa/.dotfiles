#!/usr/bin/env sh

MIC_VOLUME=$(osascript -e 'input volume of (get volume settings)')

if [[ $MIC_VOLUME -eq 0 ]]; then
	sketchybar -m --set mic label="🙊 off |"
elif [[ $MIC_VOLUME -gt 0 ]]; then
	sketchybar -m --set mic label="🔥 on |"
fi
