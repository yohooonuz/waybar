#!/usr/bin/env bash

exec 9>/tmp/ddc-brightness.lock
flock -w 0.5 9 || exit 0

ScrollUp() {
  if [[ $1 -eq 47 ]]; then
    ddcutil --bus=4 setvcp 10 + 3

  else
    ddcutil --bus=4 setvcp 10 + 2
  fi
}

ScrollDown() {
  if [[ $1 -eq 3 ]]; then
    ddcutil --bus=4 setvcp 10 - 3
  else
    ddcutil --bus=4 setvcp 10 - 2
  fi
}

CurrentBrightness=$(ddcutil --bus=4 getvcp 10 -t | awk -F " " '{print $4}')

case $1 in
up)
  ScrollUp $CurrentBrightness
  ;;
down)
  ScrollDown $CurrentBrightness
  ;;
*)
  ;;
esac

pkill -SIGRTMIN+8 waybar
