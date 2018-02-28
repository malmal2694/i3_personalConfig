#!/bin/bash
## An application to refresh i3blocks and show battery status,
## When the power cable is plugged in or disconnected from the Laptop.

# Body: -------------------------------------------------------------------------
if [[ ! -z "$*" ]];then
    echo -e "This app does not support the argument. Just run it."
    exit
fi
## This app runs without input.
## If the user enters the argument, the program will exit.

pkill -SIGRTMIN+17 i3blocks
## This command sends signal 17 to i3blocks,
## And i3blocks re-runs the same section.
## which corresponds to the battery_script.sh & heart_battery_script.sh program. -

# See More: Vim <URL:../i3blocks/battery_script/battery_script.sh>
#               <URL:../i3blocks/battery_script/heart_battery_script.sh>
#               <URL:../i3blocks/i3blocks.conf#tn=battery_script.sh>
