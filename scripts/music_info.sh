#!/usr/bin/env bash 

state=$(playerctl status 2>&1)

if [[ -z $state || $state == *"No players found"* || $state == "Stopped" ]]; then
    echo "󰟢 "
else
    info=$(playerctl metadata --format "{{title}}")
    echo "$info"
fi
