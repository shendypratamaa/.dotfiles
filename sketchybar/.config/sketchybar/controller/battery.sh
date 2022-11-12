#!/usr/bin/env sh

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ $PERCENTAGE = "" ]; then
	exit 0
fi

case ${PERCENTAGE} in
[8-9][0-9]|100)
	sketchybar --set $NAME label="🌕 ${PERCENTAGE}% |"
	;;
[7-8][0-9])
	sketchybar --set $NAME label="🌔 ${PERCENTAGE}% |"
	;;
[3-6][0-9])
	sketchybar --set $NAME label="🌓 ${PERCENTAGE}% |"
	;;
[1-3][0-9])
	sketchybar --set $NAME label="🌒 ${PERCENTAGE}% |"
	;;
[0-1][0-9])
	sketchybar --set $NAME label="🌑 ${PERCENTAGE}% |"
	;;
esac

if [[ $CHARGING != "" ]]; then
	case ${PERCENTAGE} in
	[8-9][0-9]|100)
		sketchybar --set $NAME label="🌕 ${PERCENTAGE}% |"
		;;
	[7-8][0-9])
		sketchybar --set $NAME label="🌔 ${PERCENTAGE}% |"
		;;
	[3-6][0-9])
		sketchybar --set $NAME label="🌓 ${PERCENTAGE}% |"
		;;
	[1-3][0-9])
		sketchybar --set $NAME label="🌒 ${PERCENTAGE}% |"
		;;
	[0-1][0-9])
		sketchybar --set $NAME label="🌑 ${PERCENTAGE}% |"
		;;
	esac
fi
