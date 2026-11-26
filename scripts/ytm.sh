#!/usr/bin/env bash

MoveFocus() {
    hyprctl dispatch "hl.dsp.focus({ workspace = $1 })"
}

hyprctl dispatch 'hl.dsp.focus({ monitor = "eDP-1" })' &>/dev/null
MoveFocus 8 &>/dev/null && setsid -f brave-origin --app=https://music.youtube.com/ &>/dev/null
sleep 3
MoveFocus 9 &>/dev/null && easyeffects &>/dev/null
exit 0
