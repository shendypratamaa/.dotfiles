#!/usr/bin/env sh

AIRPODSCASEBATTERY=$(system_profiler SPBluetoothDataType | grep 'Case Battery' | awk '{print $4}')
AIRPODCASE=🎒

if [[ "$AIRPODSCASEBATTERY" = "" ]]; then
	sketchybar --set $NAME icon=$AIRPODCASE label="not detected"
else
	sketchybar --set $NAME icon=$AIRPODCASE label="$AIRPODSCASEBATTERY "
fi
