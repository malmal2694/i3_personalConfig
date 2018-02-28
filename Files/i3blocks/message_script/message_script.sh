#!/bin/bash
## An application for displaying new telegram messages in i3blocks.


# Variables: --------------------------------------------------------------------
XDO_TELEGRAM=$(xdotool search telegram | tail -1)
XDO_WINDOW=$(xdotool getwindowname "$XDO_TELEGRAM" | sed -e s/\(.*/\(/)
## Get the name of the telegram window.
## Get the message value and delete the letters after brackets. -----------------


# Functions: --------------------------------------------------------------------
MSG_TELEGRAM (){
    if [[ "$XDO_WINDOW" == "Telegram (" ]];then
	MSG="#FFFFFF"
    fi
}
## Use xdotool to specify telegram messages.
## The existence of () in the name of the telegram window means a new message. --


# Body: -------------------------------------------------------------------------
MSG="#404040"
## The default color is gray
MSG_TELEGRAM
echo -e "<span foreground='$MSG'></span>"
## Display the icon color based on the above function ---------------------------
