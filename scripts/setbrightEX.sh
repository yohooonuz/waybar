#!/usr/bin/env bash

if [[ -r $HOME/Documents/bashcolors_utils.sh ]]; then
    source "$HOME/Documents/bashcolors_utils.sh"
else
    exit 1
fi

sbright() {
    exec 9>/tmp/ddc-brightness.lock
    flock -w 2 9 || {
        printf "\n\t${pink}󰟿 Monitor is busy!\n"
        return 1
    }

    ddcutil --bus=4 setvcp 10 $1
    cmdstatus=$?

    exec 9>&-
    pkill -SIGRTMIN+8 waybar

    if ((cmdstatus == 0)); then
        printf "${green} Brightness set ${blue} ${red}%i${blue}%%\n" $1
        sleep 1
        exit 0
    fi
}
printf "\n\t\t${teal}󰜴 ${sapphire}Set Brightness ${cyan} ${sapphire}HDMI-A-2 ${teal}󰜱\n\n\n"

printf "\t${magenta}󰳲 󰬹  󰬾󰬹 󰮷\n${white}"
read -n 2 -p "ㅤ⋙ㅤ" bright

echo

if [[ -z $bright ]] || [[ ! $bright =~ ^[0-9]+$ ]]; then
    printf "${pink}󰟿 Invalid input!"
    sleep 1
    exit 1
elif ((bright >= 50)); then
    sbright 50
else
    sbright $bright
fi
