#!/usr/bin/env sh

sketchybar --add item airpods right                                \
           --set      airpods update_freq=5                        \
                      icon.padding_right=-1                        \
                      script="$PLUGIN_DIR/airpodsbattery.sh"       \

