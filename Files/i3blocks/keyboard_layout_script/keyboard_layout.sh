#!/bin/bash
## An application for displaying keyboard language.


# Conditions: -------------------------------------------------------------------
if [[ ! -z "$*" ]];then
    echo -e "This app does not support the argument. Just run it."
    exit
fi
## This app runs without input.
## If the user enters the argument, the program will exit. ----------------------


# Body: -------------------------------------------------------------------------
if [[ $(xset -q | grep -i scroll | cut -f7 -d:) != " off" ]];then
    echo -e "<span foreground='#00FF25'></span>"
else
    echo -e "<span foreground='#404040'></span>"
fi
## If scroll lock is on, then the language is Farsi,
## And the circle will be green.
## Otherwise, the circle will remain gray. --------------------------------------

# See More: Vim <URL:../i3blocks.conf#tn=keyboard_layout.sh>
