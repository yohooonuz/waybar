#!/usr/bin/env bash

CACHE_FILE="/tmp/prev_brightness"
CACHE_FILE_EX="/tmp/prev_brightness_ex"

CURRENT_BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/brightness)
MAX_BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/max_brightness)

CURRENT_BRIGHTNESS_EX=$(ddcutil --bus=4 getvcp 10 -t | awk -F " " '{print $4}')

DIM_VALUE=$((MAX_BRIGHTNESS / 100))
[ $DIM_VALUE -lt 1 ] && DIM_VALUE=1

if [ -f "$CACHE_FILE" ]; then
    OLD_BRIGHTNESS=$(cat "$CACHE_FILE")
    OLD_BRIGHTNESS_EX=$(cat "$CACHE_FILE_EX")

    brightnessctl set "$OLD_BRIGHTNESS"
    ddcutil --bus=4 setvcp 10 "$OLD_BRIGHTNESS_EX"
    pkill -SIGRTMIN+8 waybar

    rm "$CACHE_FILE"
    rm "$CACHE_FILE_EX"
else
    if [ "$CURRENT_BRIGHTNESS" -le "$DIM_VALUE" ]; then
        exit 0
    fi

    echo "$CURRENT_BRIGHTNESS_EX" >"$CACHE_FILE_EX"
    echo "$CURRENT_BRIGHTNESS" >"$CACHE_FILE"

    ddcutil --bus=4 setvcp 10 0
    pkill -SIGRTMIN+8 waybar
    brightnessctl set "$DIM_VALUE"
fi
