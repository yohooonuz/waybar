#!/usr/bin/env bash

grep "disabled = true," $HOME/.config/hypr/hyprland.lua
Status=$?

if [[ $Status -eq 0 ]]; then
    sed -i '/disabled = true,/d' $HOME/.config/hypr/hyprland.lua
else
    sed -i '/output = "eDP-1",/a \ \tdisabled = true,' $HOME/.config/hypr/hyprland.lua
fi
