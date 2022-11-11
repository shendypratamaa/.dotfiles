#!/usr/bin/env sh

CURRENT_WIFI="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)"
CURR_IP="$(ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}')"
CURR_TX="$(echo "$CURRENT_WIFI" | grep -o "lastTxRate: .*" | sed 's/^lastTxRate: //')"

if [ "$CURR_TX" = "" ]; then
	sketchybar --set $NAME icon=🥚 label="Disconnected"
else
	sketchybar --set $NAME icon=🐣 label="$CURR_IP"
fi
