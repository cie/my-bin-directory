#!/bin/bash
# baraction.sh script for scrotwm status bar
# Based on script at Arch Wiki in scrotwm section
#
# This shows battery, wifi & mem info

# ** Requires acpi for battery
# ** warning awk version & dependency not checked **

# delay
SLEEP_SEC=1
BLINK=0

span() {
    perl -e '$_=shift; $_.=" " while length($_) < '$1';print;' "$2"
}

while :; do
    # Wireless
    # On this system quality is a percentage
    # Battery
    BAT="$(acpi -b | grep -oP '\d+%' | sed s/%//)"
    if [ $BAT -lt 15 ]; then 
        if [ $BLINK = 1 ]; then BAT=""; fi
    else
        BAT="$BAT%"
        acpi -b | grep Charging > /dev/null && BAT="$BAT+"
    fi
    DATE="$(date +"%Y-%m-%d %A %H:%M:%S")"

    POM=$(/home/cie/bin/pom)
    echo "$(span 67 "$POM") $(span 50 "$BAT") $(span 30 "$DATE")" | iconv -f utf8 -t latin2

    sleep $SLEEP_SEC
    let BLINK=1-$BLINK
done

# EOF
