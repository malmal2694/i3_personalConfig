#!/bin/bash
## A program for time consumed and storing data for use by scripts:
## "show_time.sh" and "../../acpi_event/suspend_time.sh"


# Variables: --------------------------------------------------------------------
PATH_ADDRESS="/tmp"
## To keep the storage space clean, Data is stored in the temporary directory. --


# Conditions: -------------------------------------------------------------------
if [[ ! -z "$*" ]];then
    echo -e "This app does not support the argument. Just run it."
    exit
fi
## This app runs without input.
## If the user enters the argument, the program will exit. ----------------------


# Body: -------------------------------------------------------------------------
while true;do
    if [[ ! -f "$PATH_ADDRESS/get_time" ]];then
	NUM="0"
    else
	NUM=$(cat "$PATH_ADDRESS/get_time")
    fi
    ## If the file is not available, the variable is 0,
    ## And if available, the contents of the file are called.
    sleep 1
    NUM=$(( NUM + 1 ))
    echo $NUM > $PATH_ADDRESS/get_time
    sleep 1
    pkill -SIGRTMIN+11 i3blocks
    ## The new time will be saved in the file.
    ## And a number will be added to the "NUM" variable,
    ## (to display the last time consumed).

    if [[ ! -f "$PATH_ADDRESS/get_uptime" ]];then
	UPTIME_NUM="3"
    else
	UPTIME_NUM=$(cat "$PATH_ADDRESS/get_uptime")
    fi
    ## If the file is not available, the variable is 0,
    ## And if available, the contents of the file are called.
    sleep 1
    UPTIME_NUM=$(( UPTIME_NUM + 1 ))
    echo $UPTIME_NUM > $PATH_ADDRESS/get_uptime
    ## The new uptime will be saved in the file.
    ## And a number will be added to the "UPTIME_NUM" variable,
    ## (to display the last uptime consumed).

    sleep 1m
done # ------------------------------------------------------------------------------

# See More: Vim <URL:./show_time.sh>
#               <URL:../i3blocks.conf#tn=show_time.sh>
#               <URL:../../acpi_event/suspend_time.sh>
