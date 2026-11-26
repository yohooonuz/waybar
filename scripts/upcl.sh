#!/usr/bin/env bash

CheckUpdates() {
    (
        flock 9
        if [[ -f /tmp/UpAval.txt ]] && (($(date +%s) - $(stat -c %Y /tmp/UpAval.txt) < 30)); then
            exit 0
        fi
        local std rc
        std=$(checkupdates --nocolor 2>/dev/null)
        rc=$?
        [[ $rc -ne 0 && $rc -ne 2 ]] && exit 0
        {
            echo "standard=($(awk '{print $1}' <<<"$std"))"
            echo
            echo "aur=($(aur-check-updates --nofailed --raw | awk '{print $1}'))"
        } >/tmp/UpAval.txt
    ) 9>/tmp/upcl.lock
}

ShowUpAval() {
    [[ -f /tmp/UpAval.txt ]] && . /tmp/UpAval.txt
    Ss=${#standard[@]}
    Aa=${#aur[@]}
    if ((Ss && Aa)); then
        echo "Ŝ $Ss 󰏕 | Â $Aa 󰏕"
    elif ((Ss)); then
        echo "Ŝ $Ss 󰏕"
    elif ((Aa)); then
        echo "Â $Aa 󰏕"
    else
        echo "Ô 󰏓"
    fi
}

UpCl() {
    paru -Syu
    paru -Sc
    sudo pacman -Rns $(pacman -Qdtq)
    pkill -SIGRTMIN+9 waybar
}

case $1 in
cu)
    CheckUpdates
    ;;
show)
    ShowUpAval
    ;;
upncl)
    UpCl
    ;;
*)
    ;;
esac
