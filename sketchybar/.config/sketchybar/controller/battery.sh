#!/usr/bin/env sh

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ $PERCENTAGE = "" ]; then
	exit 0
fi

case ${PERCENTAGE} in
[7-9][0-9]|100)
	ICON="🌕"
	;;
[3-6][0-9])
	ICON="🌓"
	;;
[0-2][0-9])
	ICON="🌒"
	;;
esac

if [[ $CHARGING != "" ]]; then
	case ${PERCENTAGE} in
	[7-9][0-9]|100)
		ICON="🌕"
		;;
	[3-6][0-9])
		ICON="🌓"
		;;
	[0-2][0-9])
		ICON="🌒"
		;;
	esac
fi

sketchybar --set $NAME icon="| $ICON" label="${PERCENTAGE}%"
