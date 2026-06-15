#!/usr/bin/env bash

network() {
    CONNECTION_TYPE=$(nmcli -t -f TYPE,STATE device | grep -E "^ethernet:connected$|^wifi:connected$" | awk -F: '{print $1}')
    if [[ "$CONNECTION_TYPE" == "wifi" ]]; then
        NAME=$(nmcli -t -f ACTIVE,SSID dev wifi | awk -F: '$1=="yes"{print $2}')
        STRENGTH=$(nmcli -f IN-USE,SIGNAL dev wifi | grep '*' | awk '{print $2}')
        
        if (( STRENGTH > 80 )); then
            ICON="󰤨"
            IMAGE="radiowaves-1-symbolic.svg"
        elif (( STRENGTH > 60 )); then
            ICON="󰤥"
            IMAGE="radiowaves-2-symbolic.svg"
        elif (( STRENGTH > 40 )); then
            ICON="󰤢"
            IMAGE="radiowaves-3-symbolic.svg"
        elif (( STRENGTH > 20 )); then
            ICON="󰤟"
            IMAGE="radiowaves-3-symbolic.svg"
        elif (( STRENGTH >= 0 )); then
            ICON="󰤯"
            IMAGE="radiowaves-4-symbolic.svg"
        else
            ICON="󰤭"
            IMAGE="radiowaves-5-symbolic.svg"
        fi
    elif [[ "$CONNECTION_TYPE" == "ethernet" ]]; then
        NAME=$(nmcli -t -f NAME connection show --active | grep ethernet)
        ICON="󰈀"
        IMAGE="lan-symbolic.svg"
    else
        NAME=""
        ICON="󰤭"
        IMAGE="radiowaves-none-symbolic.svg"
    fi
    echo '{"name": "'"$NAME"'", "icon": "'"$ICON"'", "image": "'"$IMAGE"'", "strength": "'"$STRENGTH"'"}'
}

network
ip monitor link | while read -r line; do
    network
done
