#!/bin/sh

YAD_WIDTH=222  # 222 is minimum possible value
YAD_HEIGHT=193 # 193 is minimum possible value
DATE="$(date +"%a, %B %d • %H:%M:%S")"

SCREEN_WIDTH=$(xrandr | grep primary | awk '{print $4}' | cut -d 'x' -f 1)

POS_X=$(( (SCREEN_WIDTH/2) - (YAD_WIDTH/2) - 25 ))

case "$1" in
--popup)
    yad --calendar --undecorated --fixed --close-on-unfocus --no-buttons \
        --width="222" --height="193" --posx="$POS_X" --posy="15" \
        --title="yad-calendar" --borders=0 >/dev/null &
    ;;
*)
    echo "$DATE"
    ;;
esac
