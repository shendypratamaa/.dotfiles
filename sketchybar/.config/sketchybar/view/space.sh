#!/usr/bin/env bash

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9")

sid=0
for i in "${!SPACE_ICONS[@]}"; do
  sid=$(($i+1))
  sketchybar --add space space.$sid left                                \
             --set space.$sid associated_space=$sid                     \
                              ignore_association=on                     \
                              icon=${SPACE_ICONS[i]}                    \
                              icon.padding_left=12                      \
                              icon.padding_right=12                     \
                              background.padding_left=4                 \
                              jackground.padding_right=4                \
                              background.corner_radius=0                \
                              background.height=24                      \
                              background.color=0xff${NORD3:1}           \
                              background.drawing=off                    \
                              label.drawing=off                         \
                              script="$PLUGIN_DIR/space.sh"             \
                              click_script="yabai -m space --focus $sid"
done
#
sketchybar --add item space_separator left                              \
           --set space_separator icon=􀄭                                 \
                                 background.padding_left=0              \
