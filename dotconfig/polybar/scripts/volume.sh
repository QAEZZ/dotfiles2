#!/bin/bash
#
# Simple pamixer helper.
# There should be no reason as to why I should make this.
# pamixer is very simple as is and provides all these cmds.
# Im just bored...
#
# Author: QAEZZ (qaezz.dev; thcotd.org)
#

# up/down/set/mute/unmute/togglemute/current/currenthuman
CONTROL="$1"

# amount
AMOUNT="$2"

# show help if no args
if [ $# -eq 0 ]; then
    >&2 echo -e "No arguments provided.\nUsage: ./volume.sh <CONTROL> [AMOUNT: int]\n\nCONTROLS:\nup\ndown\nset\ntogglemute*\nmute*\nunmute*\ncurrent*\ncurrenthuman*\n\n*no AMOUNT arg needed"
    exit 1
fi

case "$CONTROL" in
    up)
        pamixer -i "$AMOUNT" # increase amount %
        echo "Vol. increased $AMOUNT%"
        ;;
    down)
        pamixer -d "$AMOUNT" # decrease amount %
        echo "Vol. decreased $AMOUNT%"
        ;;
    set)
        if [ "$AMOUNT" -gt 100 ]; then
            pamixer --set-volume "$AMOUNT" --allow-boost
            echo "Allowed boost and set vol to $AMOUNT"
        elif [ "$AMOUNT" -lt 0 ]; then
            echo "AMOUNT cannot be less than 0!"
            exit 1
        else
            pamixer --set-volume "$AMOUNT"
        fi
        ;;
    mute)
        pamixer -m
        echo "Muted"
        ;;
    unmute)
        pamixer -u
        echo "Unmuted"
        ;;
    togglemute)
        pamixer -t
        echo "Mute Toggled"
        ;;
    current)
        pamixer --get-volume
        ;;
    currenthuman)
        CURRVOL=$(pamixer --get-volume-human)
        CURRVOLINT=$(pamixer --get-volume)
        if [ "$CURRVOL" == "muted" ]; then
            echo "yo shit muted!!"
        elif [ "$CURRVOLINT" -eq 0 ]; then
            echo "0%"
        else
            echo "$CURRVOL"
        fi
        ;;
    *)
        echo "Unknown CONTROL \"$CONTROL\""
        exit 1
        ;;
esac

exit 0
