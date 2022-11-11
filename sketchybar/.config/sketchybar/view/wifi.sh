#!/usr/bin/env sh

sketchybar --add item wifi right                      \
           --set wifi script="$PLUGIN_DIR/wifi.sh"    \
                      background.padding_right=0      \
                      update_freq=4
