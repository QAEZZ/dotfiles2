#!/bin/bash

if pgrep -x "jgmenu" >/dev/null; then
    jgmenu_run
else
    jgmenu --at-pointer
fi

