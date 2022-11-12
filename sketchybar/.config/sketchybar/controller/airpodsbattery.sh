#!/usr/bin/env sh

airpodsbattery=$(system_profiler SPBluetoothDataType | grep 'Battery' | awk '{printf  $4}' | awk '{printf $1+$2}')

if [[ $airpodsbattery = "" ]]; then
	sketchybar --set $NAME icon=🎧 label="not connected |"
else
	sketchybar --set $NAME icon=🎧 label="$airpodsbattery% |"
fi
