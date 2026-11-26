#!/usr/bin/env bash

pIP() {
    ipp=$(curl -s ifconfig.me)
    if [[ -n "$ipp" ]]; then
        echo "$ipp"
    else
        echo "󰟢 ƥ"
    fi
}

lIP() {
    ipl=$(ip address show wlan0 | grep -w inet | awk -F " " '{print $2}' | cut -d '/' -f 1)
    if [[ -n "$ipl" ]]; then
        echo "$ipl"
    else
        echo "󰟢 ƪ"
    fi
}

case $1 in
p)
    pIP
    ;;
l)
    lIP
    ;;
pl)
    publik=$(pIP)
    lokal=$(lIP)
    printf "Ꮮ %sㅤ∣ㅤᏢ %s" "$lokal" "$publik"
    ;;
*)
    ;;
esac
