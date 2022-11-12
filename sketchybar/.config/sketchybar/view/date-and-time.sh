#!/usr/bin/env sh

sketchybar --add item   clock right                                    \
           --set clock  update_freq=5                                  \
                        script="$PLUGIN_DIR/date-and-time.sh"          \
