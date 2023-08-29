#!/bin/bash
#
# Simple brightness helper.
# Author: QAEZZ (qaezz.dev; thcotd.org)
#

# config
XRANDR_DISPLAY="HDMI-0"

# args
CONTROL="$1"
AMOUNT="$2"

# get current brightness
BRIGHTNESS=$(xrandr --verbose | awk '/Brightness/ {printf "%.0f", $2 * 100; exit}')

# show help if no args
if [ $# -eq 0 ]; then
    >&2 echo -e "No arguments provided.\nUsage: $0 <CONTROL> [AMOUNT: int]\n\nCONTROLS:\nup\ndown\nset\ncurrent\ncurrenthuman\n"
    exit 1
fi

case "$CONTROL" in
    up)
        NEWBRIGHTNESS=$((BRIGHTNESS + AMOUNT))
        ;;
    down)
        NEWBRIGHTNESS=$((BRIGHTNESS - AMOUNT))
        ;;
    current)
        echo "$BRIGHTNESS"
        exit 0
        ;;
    currenthuman)
        echo "$BRIGHTNESS%"
        exit 0
        ;;
    *)
        NEWBRIGHTNESS="$AMOUNT"
        ;;
esac

# make sure the brightness stays within the valid range
if [ "$NEWBRIGHTNESS" -lt 10 ]; then
    AMOUNT=0.1
    NEWBRIGHTNESS=10
elif [ "$NEWBRIGHTNESS" -gt 100 ]; then
    AMOUNT=1.0
    NEWBRIGHTNESS=100
else
    AMOUNT=$(echo "scale=2; $NEWBRIGHTNESS / 100" | bc -l)
fi

xrandr --output "$XRANDR_DISPLAY" --brightness "$AMOUNT"
echo "$NEWBRIGHTNESS"
