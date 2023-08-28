#!/bin/bash
#
# Simple pamixer helper.
# There should be no reason as to why I should make this.
# pamixer is very simple as is and provides all these cmds.
# Im just bored...
#
# Author: QAEZZ
#

# up/down/set/mute/unmute/togglemute/current/currenthuman
CONTROL="$1"

# amount
AMOUNT="$2"

# if no args
if [ $# -eq 0 ]; then
    >&2 echo -e "No arguments provided.\nUsage: ./volume.sh <CONTROL> [AMOUNT: int]\n\nCONTROLS:\nup\ndown\nset\ntogglemute*\nmute*\nunmute*\ncurrent*\ncurrenthuman*\n\n*no AMOUNT arg needed"
    exit 1
fi

if [ "$CONTROL" == "up" ]; then
    pamixer -i $AMOUNT # increase amount %
    echo "Vol. increased $AMOUNT%"
    exit 0
elif [ "$CONTROL" == "down" ]; then
    pamixer -d $AMOUNT # decrease amount %
    echo "Vol. decreased $AMOUNT%"
    exit 0
elif [ "$CONTROL" == "set" ]; then
    if [ $AMOUNT -gt 100 ]; then
        pamixer --set-volume $AMOUNT --allow-boost
        echo "Allowed boost and set vol to $AMOUNT"
        exit 0
    elif [ $AMOUNT -lt 0 ]; then
        echo "AMOUNT cannot be less than 0!"
        exit 1
    else
        pamixer --set-volume $AMOUNT
        exit 0
    fi
elif [ "$CONTROL" == "mute" ]; then
    pamixer -m
    echo "Muted"
    exit 0
elif [ "$CONTROL" == "unmute" ]; then
    pamixer -u
    echo "Unmuted"
    exit 0
elif [ "$CONTROL" == "togglemute" ]; then
    pamixer -t
    echo "Mute Toggled"
    exit 0
elif [ "$CONTROL" == "current" ]; then
    pamixer --get-volume
    exit 0
elif [ "$CONTROL" == "currenthuman" ]; then
    CURRVOL=$(pamixer --get-volume-human)
    CURRVOLINT=$(pamixer --get-volume)
    if [ "$CURRVOL" == "muted" ]; then
        echo "yo shit muted!!"
    elif [ "$CURRVOLINT" == 0 ]; then
        echo "0%"
    elif [ "$CURRVOLINT" -gt 0 ] && [ "$CURRVOLINT" -lt 40 ]; then
        echo "$CURRVOL"
    else
        echo "$CURRVOL"
    fi
    exit 0
else
    echo "Unknown CONTROL \"$CONTROL\""
    exit 1
fi
