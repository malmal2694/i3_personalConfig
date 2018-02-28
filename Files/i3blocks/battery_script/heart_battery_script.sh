#!/bin/bash
## This program shows the remaining time or battery status,


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
## If the user enters the argument, the program will exit.

case $STATS in
    Charging)
	HEART="Charge";;
    Full)
	HEART="  Full";;
    Discharging)
	MIN=$(( BAT * 3 ))
	HOUR=$(( MIN / 60 ))
	REMAIN=$(( MIN - $((HOUR * 60 ))))
	HEART="  $HOUR:$REMAIN"
esac
## Display remaining time and other status. -------------------------------------


# Body: -------------------------------------------------------------------------
echo -e "  $HEART" ## ----------------------------------------------------------

# See More: Vim <URL:../i3blocks.conf#tn=heart_battery_script>
