#!/bin/bash
## This program shows the percentage of battery,
## and how much it charges on i3blocks.


# Variable: ---------------------------------------------------------------------
BAT=$(cat /sys/class/power_supply/BAT1/capacity)
STATS=$(cat /sys/class/power_supply/BAT1/status)
## "BAT": Display Battery Percentage.
## "STATS": Display battery charge status. --------------------------------------


# Conditions: -------------------------------------------------------------------
if [[ ! -z "$*" ]];then
    echo -e "This app does not support the argument. Just run it."
    exit
fi
## This app runs without input.
## If the user enters the argument, the program will exit. ----------------------


# Body: -------------------------------------------------------------------------
if [[ $BAT -le 20 ]];then
    echo -e "<span foreground='#FF2600'> $CHARGE ${BAT}%</span>"
elif [[ $BAT -le 30 ]];then
    echo " ${BAT}%"
elif [[ $BAT -le 50 ]];then
    echo " ${BAT}%"
elif [[ $BAT -le 80 ]];then
    echo " ${BAT}%"
elif [[ $BAT -le 100 ]];then
    if [[ $STATS == "Full" ]];then
	echo -e "<span foreground='#404040'> ${BAT}%</span>"
    fi
    echo " ${BAT}%"
fi
## The process of doing this is that, based on the battery level,
## a special icon is displayed --------------------------------------------------

# See More: Vim <URL:../i3blocks.conf#tn=battery_script>
