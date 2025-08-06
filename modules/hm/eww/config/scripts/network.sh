#!/usr/bin/env bash

network() {
    CONNECTION_TYPE=$(nmcli -t -f TYPE,STATE device | grep -E "^ethernet:connected$|^wifi:connected$" | awk -F: '{print $1}')
    if [[ "$CONNECTION_TYPE" == "wifi" ]]; then
        NAME=$(nmcli -t -f ACTIVE,SSID dev wifi | awk -F: '$1=="yes"{print $2}')
        STRENGTH=$(nmcli -f IN-USE,SIGNAL dev wifi | grep '*' | awk '{print $2}')
        
        if (( STRENGTH > 80 )); then
            ICON="󰤨"
        elif (( STRENGTH > 60 )); then
            ICON="󰤥"
        elif (( STRENGTH > 40 )); then
            ICON="󰤢"
        elif (( STRENGTH > 20 )); then
            ICON="󰤟"
        elif (( STRENGTH >= 0 )); then
            ICON="󰤯"
        else
            ICON="󰤭"
        fi
    elif [[ "$CONNECTION_TYPE" == "ethernet" ]]; then
        NAME=$(nmcli -t -f NAME connection show --active | grep ethernet)
        ICON="󰈀"
    else
        NAME=""
        ICON="󰲛"
    fi
    echo '{"name": "'"$NAME"'", "icon": "'"$ICON"'"}'
}

network
ip monitor link | while read -r line; do
    network
done
