#!/usr/bin/env bash

if [[ -r $HOME/Documents/bashcolors_utils.sh ]]; then
    source "$HOME/Documents/bashcolors_utils.sh"
else
    exit 1
fi

sbright() {
    brightnessctl -qn set $1%
    cmdstatus=$?

    if ((cmdstatus == 0)); then
        printf "${green} Brightness set ${blue} ${red}%i${blue}%%\n" $1
        sleep 1
        exit 0
    fi
}
printf "\n\t\t${teal}󰜴 ${sapphire}Set Brightness ${cyan} ${sapphire}eDP-1 ${teal}󰜱\n\n\n"

printf "\t${magenta}󰳲 󰬹  󰬺󰬹󰬹 󰮷\n${white}"
read -n 3 -p "ㅤ⋙ㅤ" bright

echo

if [[ -z $bright ]] || [[ ! $bright =~ ^[0-9]+$ ]]; then
    printf "${pink}󰟿 Invalid input!"
    sleep 1
    exit 1
elif ((bright >= 100)); then
    sbright 100
else
    sbright $bright
fi
