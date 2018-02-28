#!/bin/bash
## An application to check the amount of laptop use through i3blocks
## when the distance between the use of the device is more than 30 min,
## Time starts at 00:01.


# Variables: --------------------------------------------------------------------
GET_TIME="/tmp/get_time"
## To keep the storage space clean, Data is stored in the temporary directory. --


# Conditions: -------------------------------------------------------------------
if [[ ! -z "$*" ]];then
    echo -e "This app does not support the argument. Just run it."
    exit
fi
## This app runs without input.
## If the user enters the argument, the program will exit. ----------------------


# Function: ---------------------------------------------------------------------
TIME_CALC (){
    HOUR=$(( MINUTE / 60 ))
    REMAIN=$(( MINUTE - $((HOUR * 60 ))))
    ## Otherwise, it becomes minutes to an hour.
    if [[ $(echo $REMAIN | wc -c) == "2" ]];then
	REMAIN="0$REMAIN"
    fi
    if [[ $(echo $HOUR | wc -c) == "2" ]];then
	HOUR="0$HOUR"
    fi
    ## If it is a digit (2), 0 will be added to the first. For example, 02:10.
    TIME=" $HOUR:$REMAIN"
}
## A function to calculate time if the time is longer than 60 minutes. ----------


# Body: -------------------------------------------------------------------------
sleep .3
if [[ ! -f "$GET_TIME" ]];then
    echo "1" > $GET_TIME
fi
## If the "get_time" file is not available, it will be created from the first.

sleep .3
MINUTE=$(cat $GET_TIME)

if [[ "$MINUTE" -lt "60" ]];then
    if [[ $(echo "$MINUTE" | wc -c) == "2" ]];then
	MINUTE="0$MINUTE"
    fi
    ## If the time is less than 60 minutes,
    ## If it is a digit (5), 0 will be added to the first. For example, 00:05.
    TIME=" 00:$MINUTE"
    ICON=""
    COLOR="#ABABAB"
    ## COLOR is "Gray"
else
    if [[ "$MINUTE" -ge "180" ]];then
	TIME_CALC
	ICON=""
	COLOR="#FF2600"
	## If it is more than 180 minutes,
	## The user will be warned that it is enough! Turn it off.
	## COLOR is "Red"
    elif [[ "$MINUTE" -ge "90" ]];then
	TIME_CALC
	ICON=""
	COLOR="#ABABAB"
	## If it is 90 minutes past,
	## The icon will change and will display 50% of the time.
    elif [[ "$MINUTE" -ge "60" ]];then
	TIME_CALC
	ICON=""
	COLOR="#ABABAB"
    fi
fi

echo -e "$ICON <span foreground='$COLOR'> $TIME</span>"
## In the end, the program is executed and all variables are called,
## And displays them. -----------------------------------------------------------

# See More: Vim <URL:./time_script.sh>
#               <URL:../i3blocks.conf#tn=show_time.sh>
