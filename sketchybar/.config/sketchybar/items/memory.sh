#!/usr/bin/env sh

sketchybar --add item   memory right                   \
           --set memory associated_space=1             \
                        icon="memory"                  \
                        icon.padding_left=15           \
                        update_freq=15                 \
                        script="$PLUGIN_DIR/memory.sh"
