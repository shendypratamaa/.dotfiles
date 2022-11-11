#!/usr/bin/env sh

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10")

for i in "${!SPACE_ICONS[@]}"; do
  sid=$(($i+1))
  sketchybar --add space space.$sid left                                \
             --set space.$sid associated_space=$sid                     \
                              icon=${SPACE_ICONS[i]}                    \
                              icon.padding_left=6                       \
                              icon.padding_right=6                      \
                              background.padding_left=4                 \
                              background.padding_right=4                \
                              background.corner_radius=2                \
                              background.height=18                      \
                              background.color=0xff${NORD15:1}          \
                              background.drawing=off                    \
                              label.drawing=off                         \
                              script="$PLUGIN_DIR/space.sh"             \
                              click_script="yabai -m space --focus $sid"
done

sketchybar --add item space_separator left                              \
           --set space_separator icon=                                 \
                                 background.padding_left=0              \
                                 background.padding_right=4             \
                                 label.drawing=off                      \
