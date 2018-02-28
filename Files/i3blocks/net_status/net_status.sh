#!/bin/bash
## An application to display the amount of data in the network,
## And display the remaining traffic from "Hi Web" services.


# Variables: --------------------------------------------------------------------
DNS1="77.77.77.77" # Hiweb DNS
DNS2="46.224.1.221" # Hiweb DNS
PING_CM="ping -c 1"
GET_INTERFACE=$(ip a | grep " UP " | cut -f2 -d: | sed -e s/^" "//)
VNSTAT=$(vnstat -q -i "$GET_INTERFACE" | grep today | cut -f3 -d\| \
    | sed -e s/" "//g -e s/MiB/" MiB"/ -e s/GiB/" GiB"/ -e s/KiB/" KiB"/)
## DNS Setup. (Optional)
## Ping with a request.
## Get the network interface name.
## Displays data usage in the network based on the network interface name,
## And setting it as "KiB", "MiB" and "GiB". ------------------------------------


# Conditions: -------------------------------------------------------------------
if [[ ! -z "$*" ]];then
    echo -e "This app does not support the argument. Just run it."
    exit
    ## This app runs without input.
    ## If the user enters the argument, the program will exit.
elif [[ $(nslookup $DNS1 | grep -o "can't") == "can't" ]];then
    DNS=$DNS2
else
    DNS=$DNS1
fi
## Check DNS and choose the correct address.

if [[ -z $VNSTAT ]];then
    VNSTAT="0 KiB"
fi
## If there is still no value for "today",
## Then the program will wait and until then, use "0 kiB". ----------------------


# Function: ---------------------------------------------------------------------
VNSTAT_SHOW (){
    if [[ $(ip a | grep "$GET_INTERFACE" \
	| grep -o "inet 192.168") == "inet 192.168" ]];then
    ## If the network interface has an Ip, The icon is displayed correctly.
	NET_ICON=""
    else
	NET_ICON=""
	VNSTAT=" N/A"
    fi

    if [[ $($PING_CM $DNS | grep -o " 1 received") == " 1 received" ]];then
    ## If the DNS is Ping, then the Internet is connected.
	INTERNET_ICON=""

	if [[ -f /tmp/ERROR.hiweb ]];then
	## If the Hiweb site has failed to connect,
	## The "ERROR.hiweb" file has been generated.
	    INTERNET_ICON=""
	fi

	if [[ ! -f /tmp/hiweb_info.php ]];then
	## If the Internet does not exist,
	## Or the network is checking for an Internet connection,
	## Then the hiweb_info.sh file will not exist.
	    INTERNET_ICON=""
	fi

	echo "$NET_ICON  $VNSTAT   $INTERNET_ICON  $TRAFFIC $SIZE"
	## If the Internet is finally connected,
	## Display the variables specified here.
    else
	echo "$NET_ICON  $VNSTAT     N/A"
	## Otherwise, all signs indicate that they are not connected.
    fi
    exit
}
## This function is used at the end of the program. -----------------------------


# Body: -------------------------------------------------------------------------
PHP_ADDRESS="$HOME/.i3/Files/i3blocks/net_status/hiweb_info_offline.php"

if [[ ! -z $(grep "اتمام حجم" "$PHP_ADDRESS") ]];then
    TRAFFIC=$(echo "Unlimited")
    SIZE=""
    VNSTAT_SHOW
fi
## If the Internet is unlimited, an unlimited word will be written.
## The term "Unlimited Internet" means the same end to fair use.

TRAFFIC=$(grep "ADSL Internet Limited" "$PHP_ADDRESS" | cut -f5 -d'=' | \
    cut -f2 -d'>' | cut -f1 -d'<')
if [[ ! -z $(echo "$TRAFFIC" | grep -o "\.") ]];then
    TRAFFIC=$(echo "$TRAFFIC" | grep -o ".*\." | sed -e s/\\.//)
fi
TRAFFIC=$(echo $TRAFFIC / 4 | bc)
## Calculate the Internet.
TCHAR=$(echo "$TRAFFIC" | wc -c)
SIZE="MiB"
## "PHP_ADDRESS", Location of data storage for offline use.
##                See More: Vim <URL:./hiweb_status.sh>
## "TRAFFIC", Displays remaining traffic.
## "TCHAR", Show the number of digits.

if [[ $TCHAR -ge "5" ]];then
    ORIG_NUM="$TRAFFIC"
    Decimal=$(( TCHAR - 3 ))
    CONVERT=$(( ORIG_NUM / 1000 ))
    TRAFFIC="$CONVERT.$(echo "$ORIG_NUM" | cut -c$Decimal)"
    SIZE="GiB"
fi
## If the output is higher than 5 digits,
## Then the remaining traffic will be calculated in GiB.

VNSTAT_SHOW
## The above function displays the amount of network and internet usage. --------

# See More: Vim <URL:../i3blocks.conf#tn=net_status.sh>
