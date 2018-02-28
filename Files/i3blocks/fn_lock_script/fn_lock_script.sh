#!/bin/bash
## An application to display the status of the Lock keys.
## Like: Num Lock and Caps Lock.


# Variables: --------------------------------------------------------------------
COLOR1="#404040"
CIRCLE1="#404040"
COLOR2="#404040"
CIRCLE2="#404040"
## Specifies the color of the posts and also the circle.
## White and green colors. ------------------------------------------------------


# Conditions: -------------------------------------------------------------------
if [[ ! -z "$*" ]];then
    echo -e "This app does not support the argument. Just run it."
    exit
    ## This app runs without input.
    ## If the user enters the argument, the program will exit.
elif [[ $(xset -q | grep -i num | cut -f5 -d: | cut -f5 -d" ") == "on" ]];then
    COLOR1="#FFFFFF"
    CIRCLE1="#00FF25"
fi
## If Num Lock is on,
## the background color will be white and the circle will be green.

if [[ $(xset -q | grep -i caps | cut -f3 -d: | cut -f4 -d" ") == "on" ]];then
    COLOR2="#FFFFFF"
    CIRCLE2="#00FF25"
fi
## If Caps Lock is on,
## the background color will be white and the circle will be green. -------------


# Body: -------------------------------------------------------------------------
echo -e "<span foreground='$CIRCLE1'>●</span>\
 <span foreground='$COLOR1'>Num</span>\
   <span foreground='$CIRCLE2'>●</span>\
 <span foreground='$COLOR2'>Caps</span>"
## Show Status Lock Keys. -------------------------------------------------------

# See More: Vim <URL:../i3blocks.conf#tn=keyboard_layout.sh>
