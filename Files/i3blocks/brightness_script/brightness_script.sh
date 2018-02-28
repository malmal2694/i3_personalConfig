#!/bin/bash
## An application to display the brightness of the Laptop.
## This app is used by i3blocks and similar apps.


# Variables: --------------------------------------------------------------------
XBRGHT=$(sleep .1 ;xrandr --verbose | grep Brightness | cut -f2 -d: |\
    cut -f2 -d" ")
GET_NUM=$(echo "$XBRGHT" | cut -f2 -d.)
## xrandr [Command] is the primitive command line interface to RandR extension. -


# Conditions: -------------------------------------------------------------------
if [[ ! -z "$*" ]];then
    echo -e "This app does not support the argument. Just run it."
    exit
fi
## This app runs without input.
## If the user enters the argument, the program will exit. ----------------------


# Body: -------------------------------------------------------------------------
if [[ $XBRGHT == "1.0" ]];then
    echo " 100%"
    ## If brightness is 1.0, the program will show 100%.
else
    if [[ $GET_NUM == "10" ]];then
	echo " 10%"
	## If brightness is 0.1, the program will show 10%.
    fi
fi
## This section is a general condition. To solve possible problems.

if [[ $GET_NUM -le "20" ]];then
    echo " ${GET_NUM}%"
elif [[ $GET_NUM -le "30" ]];then
    echo " ${GET_NUM}%"
elif [[ $GET_NUM -le "40" ]];then
    echo " ${GET_NUM}%"
elif [[ $GET_NUM -le "50" ]];then
    echo " ${GET_NUM}%"
elif [[ $GET_NUM -le "60" ]];then
    echo " ${GET_NUM}%"
elif [[ $GET_NUM -le "70" ]];then
    echo " ${GET_NUM}%"
elif [[ $GET_NUM -le "80" ]];then
    echo " ${GET_NUM}%"
elif [[ $GET_NUM -le "90" ]];then
    echo " ${GET_NUM}%"
fi
## The process of doing this is that, based on the brightness level,
## a special icon is displayed --------------------------------------------------

