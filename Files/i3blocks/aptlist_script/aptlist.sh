#!/bin/bash
## An application to list upgraded packages for updates.
## And send its output to aptlist_i3blocks.sh
## See More: Vim <URL:./apt_i3blocks.sh>
##	         <URL:../../../config#tn=aptlist.sh>


# Variables: --------------------------------------------------------------------
LIST="/tmp/aptlist"
APT="apt list --upgradable"
## "LIST": To keep the storage space clean.
## Data is stored in the temporary directory.
## "APT": The package update command. -------------------------------------------


# Conditions: -------------------------------------------------------------------
if [[ ! -z "$*" ]];then
    echo -e "This app does not support the argument. Just run it."
    exit
fi
## This app runs without input.
## If the user enters the argument, the program will exit. ----------------------


# Body: -------------------------------------------------------------------------
while true;do
    HOLD_PACK=$(apt-mark showhold)
    ## Use "apt-mark" to lock packages that should not be updated.
    if [[ ! -f "$LIST" ]] && [[ $($APT 2> /dev/null | grep -v "$HOLD_PACK" \
    | grep -o "upgradable" | head -1) == "upgradable" ]];then
	## If the case does not exist, Also prepare a package to update.
	$APT 2> /dev/null | grep -v "$HOLD_PACK" | grep "upgradable" > "$LIST"
    elif [[ -f "$LIST" ]] && [[ $($APT 2> /dev/null | grep -v "$HOLD_PACK" \
    | grep -c "upgradable") != $(wc -l "$LIST" | cut -f1 -d' ') ]];then
    ## If the case exists,
    ## and number of packages from the packages inside the file does not match...
	$APT 2> /dev/null | grep -v "$HOLD_PACK" | grep "upgradable" > "$LIST"
    fi
    sleep 1m
done # --------------------------------------------------------------------------
