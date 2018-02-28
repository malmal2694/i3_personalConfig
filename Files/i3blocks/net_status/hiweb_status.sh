#!/bin/bash
## An application to get the original file of the "Hi Web" Site page,
## To receive the remaining traffic.
##
## Add following text in cron:
## $ crontab -e
## * * * * * ~/.i3/Files/i3blocks/net_status/hiweb_status.sh


## Variables: -------------------------------------------------------------------
PHP_ADDRESS="/tmp"
NAME="hiweb_info"
IFNAME="ADSL Internet Limited"
OFFLINE_ADDRESS="$HOME/.i3/Files/i3blocks/net_status"
## Data is stored in the temporary directory. -----------------------------------


# Body: -------------------------------------------------------------------------
wget http://panel.hiweb.ir/panel.php -O $PHP_ADDRESS/${NAME}.php

if [[ "$?" == "0" ]];then
## If the download is done correctly:
    if [[ $(grep -o "$IFNAME" $PHP_ADDRESS/${NAME}.php) == "$IFNAME" ]];then
    ## If the amount of traffic remaining in the file was available:
	cat $PHP_ADDRESS/${NAME}.php > "$OFFLINE_ADDRESS"/${NAME}_offline.php
	## Backup the file in the main directory,
	## For use when the Internet is not available.
	rm -f $PHP_ADDRESS/ERROR.hiweb
	## And delete the "ERROR.hiweb" file if it was available.
    else
	echo "ERROR!" > $PHP_ADDRESS/ERROR.hiweb
	## If the file was available, but the amount of traffic was unclear,
	## The "ERROR.hiweb" file will be created.
    fi
fi # ----------------------------------------------------------------------------

# See More: Vim <URL:./net_status.sh>
