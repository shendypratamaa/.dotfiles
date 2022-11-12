#!/usr/bin/env sh

:ocean:

sketchybar --add item airpodscase right                                   \
w          --set      airpodscase updatefreq=5                            \
                      icon.padding_right=-1                               \
                      script="$PLUGIN_DIR/airpodscasebattery.sh"          \
