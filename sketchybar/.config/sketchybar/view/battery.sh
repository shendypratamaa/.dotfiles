#!/usr/bin/env sh

sketchybar --add item    battery right                                  \
           --subscribe   battery system_woke                            \
           --set battery script="$PLUGIN_DIR/battery.sh"                \
                         background.padding_right=-10                   \
                         update_freq=5
