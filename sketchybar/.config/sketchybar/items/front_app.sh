#!/usr/bin/env sh
sketchybar --add item front_app  left                                   \
           --set front_app       script="$PLUGIN_DIR/front_app.sh"      \
                                 icon.drawing=off                       \
           --subscribe front_app front_app_switched
