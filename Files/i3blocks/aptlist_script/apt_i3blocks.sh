#!/bin/bash
## An app to display the number of packages updated via APT
## This application is a supplement to the aptlist.sh
## See More: Vim <URL:./aptlist.sh>


# Variables: --------------------------------------------------------------------
TMP_ADDRESS="/tmp/aptlist"
## To keep the storage space clean, Data is stored in the temporary directory.


# Body: -------------------------------------------------------------------------
if [[ ! -z "$*" ]];then
    echo -e "This app does not support the argument. Just run it."
    exit
    ## This app runs without input.
    ## If the user enters the argument, the program will exit.
elif [[ -f "$TMP_ADDRESS" ]];then
    APT_CHECK=$(wc -l $TMP_ADDRESS | cut -f1 -d' ')
else
    APT_CHECK="0"
fi
## We receive and maintain the number of packages available for updating.

if [[ ! -z $(apt-mark showhold) ]];then
    APT_MARK="+"
else
    APT_MARK=""
fi
## If some packages are locked, the + sign will be added.

if [[ "$APT_CHECK" == "0" ]];then
    echo -e "<span foreground='#404040'>  \
"$APT_MARK"$APT_CHECK update avaliable</span>"
    ## When there is no package for updating, the output text is gray.
else
    echo -e "<span foreground='#FFFFFF'>  \
"$APT_MARK"$APT_CHECK update avaliable</span>"
    ## When there is a package for updating, the output text is white.
fi # ----------------------------------------------------------------------------

# See More: Vim <URL:../i3blocks.conf#tn=apt_i3blocks>
