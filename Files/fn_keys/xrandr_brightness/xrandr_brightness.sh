#!/bin/bash
# This program has been written to solve the problem of Up/Down brightness (LapTop).
## The user will change system's brightness through this program.
### The user can also increase/decrease the brightness of the monitor.


# Variables: --------------------------------------------------------------------
XOUT=$(xrandr | grep " connected " | head -1 | cut -f1 -d" ")
XBRGHT=$(xrandr --verbose | grep Brightness | cut -f2 -d: | cut -f2 -d" ")
SXBRGHT="xrandr --output $XOUT --brightness"
GET_NUM=$(echo "$XBRGHT" | cut -f2 -d.)
PKILL="pkill -SIGRTMIN+16 i3blocks"
ARGS="$*"
## xrandr [Command] is the primitive command line interface to RandR extension.
## "PKILL" for refresh i3blocks and show brightness.
## $* is input argument. --------------------------------------------------------


# Conditions: -------------------------------------------------------------------
HELP (){
    echo -e "\n\t -s\
    \n\t\t Set Brightness.\
    \n\t -b [up] or [down]\
    \n\t\t Increase/Decrease Brightness.\
    \n"
    exit
}
## The user can see the program's general guide using the argument (-h).

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


# Functions: --------------------------------------------------------------------
OPT_CHECK (){
    if [[ ! -z "$OPTARG" ]];then
	if [[ "$ARGS" != "-$OPTIONS $OPTARG" ]];then
	    BAD_ARG
	fi
    elif [[ "$ARGS" != "-$OPTIONS" ]];then
	BAD_ARG
    fi
}
## Checking the arguments with pre-selected states in the program. --------------


# Body: -------------------------------------------------------------------------
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
while getopts ":hb:s:" OPTIONS;do
## Two points ":" in the first string mean the removal of additional messages.
## Two points ":" after each word means more input.
    case "$OPTIONS" in
       	h)
	    OPT_CHECK
       	    HELP;;
	s)
      	    OPT_CHECK
	    case "$OPTARG" in
		0.[1-9])
		    ## User if entering numbers between 0.1 to 0.9.
		    $SXBRGHT "$OPTARG";;
		1.0)
		    ## User if entering 1.0 number.
		    $SXBRGHT 1.0;;
		*)
		    ## User in case of entering an unauthorized number.
		    BAD_ARG
	    esac
	    $PKILL;;
	b)
	    case "$OPTARG" in
		up)
		    OPT_CHECK
		    if [[ "$XBRGHT" == "1.0" ]];then
			exit
			## If the brightness was 100%, it would not be longer.
		    elif [[ $GET_NUM -ge "90" ]];then
			$SXBRGHT 1.0
			$PKILL
			exit
			## If brightness was 90%,
			## brightness would turn up to 100%.
		    fi
		    SUM=$(( GET_NUM + 10 ))
		    $SXBRGHT 0.$SUM
		    $PKILL;;
		    ## Each time the "up" command is executed,
		    ## the brightness increases by 10%.
		down)
		    OPT_CHECK
		    if [[ "$XBRGHT" == "0.0" ]];then
			exit
			## If the brightness was 0 or 10%,
			## the brightness would not be lower.
		    elif [[ "$XBRGHT" == "1.0" ]];then
			$SXBRGHT 0.9
			$PKILL
			## If the brightness was 100%,
			## it should be converted to 0.9 to decrease.
			exit
		    elif [[ $GET_NUM -le "10" ]];then
			exit
			## If the brightness was 10%,
			## the program would not reduce the brightness.
		    fi
		    SUB=$(( GET_NUM - 10 ))
		    $SXBRGHT 0.$SUB
		    $PKILL;;
		    ## Each time the "down" command is executed,
		    ## Lowers the brightness by 10%.
		*)
		    BAD_ARG
	    esac;;
	*)
	    BAD_ARG
    esac
done # --------------------------------------------------------------------------

# See More: Vim <URL:../../config#tn=xrandr_brightness>
