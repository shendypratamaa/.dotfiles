#!/usr/bin/env sh

sketchybar --add item airpods right                           \
           --set airpods update_freq=1                        \
                 script="$PLUGIN_DIR/airpodsbattery.sh"       \
                 background.padding_right=-8                  \

