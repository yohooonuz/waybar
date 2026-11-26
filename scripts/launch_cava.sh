#!/usr/bin/env bash

hyprctl dispatch 'hl.dsp.focus({ monitor = "eDP-1" })'
hyprctl dispatch 'hl.dsp.focus({ workspace = 10 })'
kitty -o confirm_os_window_close=0 -e cava
