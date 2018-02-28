#!/bin/bash
## An application to determine the time of using a laptop,
## When the laptop door (LID) opens.
## The output of this program is used by the show_time.sh script.
## See More: Vim <URL:../i3blocks/time_script/show_time.sh>


# Variables: --------------------------------------------------------------------
PATH_ADDRESS="/tmp"
ARGS="$*"
## To keep the storage space clean, Data is stored in the temporary directory.
## $* is input argument. --------------------------------------------------------


# Conditions: -------------------------------------------------------------------
HELP (){
    echo -e "\n\t -l [--open]\
    \n\t\t Check the time taken by opening the laptop door.\
    \n\t    [--close]\
    \n\t\t Lock the system when the laptop door closes.\
    \n"
    exit
}
## The user can see the program's general guide using the argument (-h)

BAD_ARG (){
    echo -e "Bad Argument \nSee -h option"
    exit
}
## Use when the user entered the wrong argument.

NO_ARG (){
    echo -e "There is no argument. try again. \nSee -h option"
    exit
}
## Use when the argument is not entered. ----------------------------------------


# Function: ---------------------------------------------------------------------
OPT_CHECK (){
    if [[ ! -z "$OPTARG" ]];then
	if [[ "$ARGS" != "-$OPTIONS $OPTARG" ]];then
	    BAD_ARG
	fi
    elif [[ "$ARGS" != "-$OPTIONS" ]];then
	BAD_ARG
    fi
}
## Checking the arguments with pre-selected states in the program.

UPTIME_GET (){
    if [[ $(uptime -p | grep -o "day") = "day" ]];then
	DAY=$(uptime -p | cut -f2 -d' ')
	HOUR=$(uptime -p | cut -f4 -d' ')
	MINUTE=$(uptime -p | cut -f6 -d' ')
    elif [[ $(uptime -p | grep -o "hour") = "hour" ]];then
	DAY="0"
	HOUR=$(uptime -p | cut -f2 -d' ')
	MINUTE=$(uptime -p | cut -f4 -d' ')
	sleep 1
	## When the laptop time is not reached for 1 day,
	## the output is uptime without displaying the day.
	## So it enters 0 manually.
    elif [[ $(uptime -p | grep -o "minute") = "minute" ]];then
	DAY="0"
	HOUR="0"
	MINUTE=$(uptime -p | cut -f2 -d' ')
	sleep 1
	## When the laptop time is not reached for 1 hour,
	## the output is uptime without displaying the hour.
	## So it enters 0 manually.
    fi
    ## These conditions will get the day/min/hour information from the "uptime".

    GET_M=$(( HOUR * 60 ))
    SUM=$(( MINUTE + GET_M ))
    ## Gain total minutes and hours (in minutes).
}
## Get the time used by the system. ---------------------------------------------


# Body: -------------------------------------------------------------------------
sleep .3
## This program uses "getopts" to interact with the user.
case "$1" in
    "")
    ### Empty argument.
	NO_ARG;;
    [!-]*)
    ### Arguments that do not start with "-".
	BAD_ARG;;
    -)
    ### An argument that consists of only "-".
       	BAD_ARG
esac
## The correct or incorrect condition of the first argument.

# Getopts Section:
## Part for user interaction. Getting input from the user,
## and executing the command corresponding to the input command.
while getopts ":hl:" OPTIONS;do
## Two points ":" in the first string mean the removal of additional messages.
## Two points ":" after each word means more input.
    case "$OPTIONS" in
	h)
	    OPT_CHECK
	    HELP;;
	l)
	    case "$OPTARG" in
		--close)
		    if [[ -z $(pgrep slimlock) ]];then
			/usr/bin/slimlock
			sleep 1
		    fi;;
		--open)
		    UPTIME_GET
		    sleep 1
		    OLD_UPTIME=$(cat $PATH_ADDRESS/get_uptime)
		    DEL_TIME=$(( SUM - OLD_UPTIME ))
		    sleep 1
		    if [[ "$DEL_TIME" -ge "30" ]];then
			rm -f "$PATH_ADDRESS"/get_time
			## If the time > 30 min from the time of the file,
			## The counter in i3blocks will be zero.
			sleep .3
			pkill -SIGRTMIN+11 i3blocks
			## After executing the terms,
			## The signal 11 is sent to i3blocks,
			## To refresh the "show_time.sh" script.
		    fi
		    NEW_UPTIME=$(( DEL_TIME + OLD_UPTIME ))
		    sleep 1
		    echo "$NEW_UPTIME" > "$PATH_ADDRESS"/get_uptime
		    rm -f "$PATH_ADDRESS"/acpid_lid_*
		    ;;
		*)
		    BAD_ARG
	    esac;;
	*)
	    BAD_ARG
    esac
done

# See More: Vim <URL:../i3blocks/i3blocks.conf#tn=show_time.sh>
