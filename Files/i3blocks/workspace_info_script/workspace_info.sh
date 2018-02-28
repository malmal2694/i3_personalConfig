#!/bin/bash
## An application to display the workspace in i3blocks


# Variables: --------------------------------------------------------------------
WORKINFO="i3-msg -t get_workspaces"
## Calling the workspace information in i3. -------------------------------------


# Conditions: -------------------------------------------------------------------
if [[ ! -z "$*" ]];then
    echo -e "This app does not support the argument. Just run it."
    exit
fi
## This app runs without input.
## If the user enters the argument, the program will exit. ----------------------


# Body: -------------------------------------------------------------------------
if [[ $($WORKINFO | grep -o "Desktop\"\,\"visible\"\:\true" |\
    grep -o "Desktop") == "Desktop" ]];then
    DESKTOP="#FFFFFF"
    GUI="#ABABAB"
    MONITOR="#ABABAB"
    DEVELOP="#ABABAB"
    echo -e "<span foreground='$DESKTOP'>  Desktop</span>      \
<span foreground='$GUI'>  GUI</span>\
    <span foreground='$DEVELOP'>  Developer</span>\
      <span foreground='$MONITOR'>  Monitor</span> "
    ## If we are in the first workspace (ie Desktop),
    ## The color of the workspace will be white.
    ## The colors of the other spaces are gray

elif [[ $($WORKINFO | grep -o "GUI\"\,\"visible\"\:\true" |\
    grep -o "GUI") == "GUI" ]];then
    DESKTOP="#ABABAB"
    GUI="#FFFFFF"
    ICON="#ABABAB"
    MONITOR="#ABABAB"
    DEVELOP="#ABABAB"
    echo -e "<span foreground='$DESKTOP'>  Desktop</span>      \
<span foreground='$GUI'><span foreground='$ICON'></span>  GUI</span>\
    <span foreground='$DEVELOP'><span foreground='$ICON'></span>  Developer</span>\
      <span foreground='$MONITOR'>  Monitor</span> "

elif [[ $($WORKINFO | grep -o "Monitor\"\,\"visible\"\:\true" |\
    grep -o "Monitor") == "Monitor" ]];then
    DESKTOP="#ABABAB"
    GUI="#ABABAB"
    MONITOR="#FFFFFF"
    DEVELOP="#ABABAB"
    echo -e "<span foreground='$DESKTOP'>  Desktop</span>      \
<span foreground='$GUI'>  GUI</span>\
    <span foreground='$DEVELOP'>  Developer</span>\
      <span foreground='$MONITOR'>  Monitor</span> "

elif [[ $($WORKINFO | grep -o "Developer\"\,\"visible\"\:\true" |\
    grep -o "Developer") == "Developer" ]];then
    DESKTOP="#ABABAB"
    GUI="#ABABAB"
    MONITOR="#ABABAB"
    DEVELOP="#FFFFFF"
    echo -e "<span foreground='$DESKTOP'>  Desktop</span>      \
<span foreground='$GUI'>  GUI</span>\
    <span foreground='$DEVELOP'>  Developer</span>\
      <span foreground='$MONITOR'>  Monitor</span> "
fi
## By running the program, only one condition will be run each time,
## And the color of the corresponding work space will be white. -----------------

# See More: Vim <URL:../i3blocks.conf#tn=workspace_info.sh>
