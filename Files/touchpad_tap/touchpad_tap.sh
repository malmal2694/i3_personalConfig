#!/bin/bash
## A tool to enable Touch Tapping.
## By "Xinput" tool.
## $ sudo apt install xinput


# Variables: --------------------------------------------------------------------
TOUCH_MODEL="ELAN0501:00 04F3:3018 Touchpad"
## Specify the device name. -----------------------------------------------------


# Conditions: -------------------------------------------------------------------
if [[ ! -z "$*" ]];then
    echo -e "This app does not support the argument. Just run it."
    exit
fi
## This app runs without input.
## If the user enters the argument, the program will exit. ----------------------


# Body: -------------------------------------------------------------------------
VALUE_NUM=$(xinput list-props "$TOUCH_MODEL" | grep "libinput Tapping Enabled" \
		| head -1 | cut -f2 -d\( | cut -f1 -d\))
## Get the desired number to activate.
xinput set-prop "$TOUCH_MODEL" $VALUE_NUM 1
## Enable Tapping. --------------------------------------------------------------
