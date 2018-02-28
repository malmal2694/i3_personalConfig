#!/bin/bash
# This program has been written to solve the problem of Mute/Unmute amixer.
## The user will mute/unmute the system's sound through this program.
### The user can also increase/decrease the volume of the system sound.


# Variables: --------------------------------------------------------------------
SAMIXER="amixer sset"
GAMIXER="amixer get Master"
PKILL="pkill -SIGRTMIN+15 i3blocks"
ARGS="$*"
## amixer [Package] is the command-line mixer for ALSA soundcard driver.
## "PKILL" for Refresh i3blocks and show volume.
## $* is input argument. --------------------------------------------------------


# Conditions: -------------------------------------------------------------------
HELP (){
    echo -e "\n\t -m\
    \n\t\t Mute/Unmute Volume\
    \n\
    \n\t -v [up] or [down]\
    \n\t\t Increase volume or Decreace volume\
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
UNMUTE_CHANNEL (){
    $SAMIXER Master unmute
    $SAMIXER Headphone unmute
    $SAMIXER Speaker unmute
    $SAMIXER PCM unmute
}
## Use amixer for unmute channel.
### Because with mute, all channels are muted.

MUTE (){
    $SAMIXER Master mute 2> /dev/null > /dev/null
    echo -e "Volume is Mute"
}
## If the sound is unmuted, it will mute the sound.

UNMUTE (){
    if [[ "$($GAMIXER | grep -o off] | head -1)" == "off]" ]];then
	UNMUTE_CHANNEL
    fi
}
## If the sound is muted, it will unmute the sound.

GET_VOLUME (){
    echo -e "Volume is $(amixer get Master | grep '%' | head -1 | cut -f2 -d[ \
    | cut -f1 -d])"
}
## Show the details of the sound from the 'amixer'.

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
while getopts ":hmv:" OPTIONS;do
## Two points ":" in the first string mean the removal of additional messages.
## Two points ":" after each word means more input.
    case "$OPTIONS" in
       	h)
	    OPT_CHECK
       	    HELP;;
	m)
      	    OPT_CHECK
       	    if [[ "$($GAMIXER | grep -o on] | head -1)" = "on]" ]];then
	    ## If the sound was not muted.
		MUTE
		$PKILL
	    else
		UNMUTE_CHANNEL 2> /dev/null > /dev/null
		$PKILL
       	       	echo -e "Volume is Unmute"
      	    fi
      	    exit;;
	v)
	    case "$OPTARG" in
		up)
		    OPT_CHECK
		    UNMUTE
		    $SAMIXER Master 10%+ > /dev/null
		    ## Raise the sound every 10%.
		    $PKILL
		    GET_VOLUME;;
		down)
		    OPT_CHECK
		    UNMUTE
		    $SAMIXER Master 10%- > /dev/null
		    ## Lowering the sound every 10%.
		    $PKILL
		    if [[ "$($GAMIXER | grep -o 65.25 | head -1 )" = "65.25" ]]
		    then
		    ## If the sound dB reaches 46.50 (meaning 0%),
		    ## the sound will be completely mute.
			MUTE
			$PKILL
		    else
			GET_VOLUME
			$PKILL
		    fi;;
		*)
		    BAD_ARG
	    esac;;
	*)
	    BAD_ARG
    esac
done # --------------------------------------------------------------------------

# See More: Vim <URL:../../config#tn=amixer_volume>
