#!/bin/bash
## An app to display video files not watch to in conky.


# Variables: --------------------------------------------------------------------
HOME_ADDRESS="$HOME/Downloads"
VIDEO_FORMAT=".mp4\\|.mkv\\|.Mkv\\|.avi\\|.mpg\\|.mov\\|.flv\\|.webm"
TMP_LIST="/tmp/videolist"
NULL_ADDRESS="/dev/null"
NUMBER="1"
## To keep the storage space clean, Data is stored in the temporary directory.
## And the outputs are poured into "Null". --------------------------------------


# Conditions: -------------------------------------------------------------------
if [[ ! -z "$*" ]];then
    echo -e "This app does not support the argument. Just run it."
    exit
    ## This app runs without input.
    ## If the user enters the argument, the program will exit.
elif [[ -f "$TMP_LIST" ]];then
    head -11 "$TMP_LIST"
    ## If the file is available, it will display the last 11 lines.
    if [[ -f "$TMP_LIST"-empty ]];then
	rm -f "$TMP_LIST"-empty
    fi
    ## If there was a "empty" file and there was the original file,
    ## Therefore, the file "empty" will be deleted.
else
    echo "Empty!" > "$TMP_LIST"-empty
    ## If the original file does not exist, the file "empty" will be created.
    while [ "$NUMBER" != "11" ];do
	echo >> "$TMP_LIST"-empty
	NUMBER=$((NUMBER +1))
    done
    head -11 "$TMP_LIST"-empty
    ## 11 lines are created at the end of the file and displayed.
fi
## Conditional for creating, deleting and displaying required files. ------------


# Body: -------------------------------------------------------------------------
sleep 3s

cd "$HOME_ADDRESS" || return
ls -1t > "$TMP_LIST"-ls
grep "$VIDEO_FORMAT" "$TMP_LIST"-ls > "$TMP_LIST" 2> "$NULL_ADDRESS"
## View files with the required extensions in the corresponding directory.
## And sending errors to "Null".
if [[ -z $(cat "$TMP_LIST") ]];then
    rm -f "$TMP_LIST"
    rm -f "$TMP_LIST"-ls
    ## If the original file is empty, its will be deleted.
else
    NUMBER="1"
    while [ "$NUMBER" != "11" ];do
	echo >> "$TMP_LIST"
	NUMBER=$((NUMBER +1))
    done
    rm -f "$TMP_LIST"-ls
    ## If the original file was not empty, 11 lines are added to the end.
fi # ----------------------------------------------------------------------------

# See More: Vim <URL:../conky0.conf#tn=video.sh>
