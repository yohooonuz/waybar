#!/usr/bin/env bash

if [[ -r $HOME/Documents/bashcolors_utils.sh ]]; then
    source "$HOME/Documents/bashcolors_utils.sh"
else
    exit 1
fi

svol() {
    wpctl set-volume @DEFAULT_AUDIO_SINK@ $1%
    cmdstatus=$?

    if ((cmdstatus == 0)); then
        printf "${green}󰗅 Volume set ${blue} ${red}%i${blue}%%\n" $1
        sleep 1
        exit 0
    fi
}
printf "\n\t\t${teal}󰜴 ${sapphire}Set Volume ${teal} ${sapphire}DEVICE ${teal}󰜱\n\n\n"

printf "\t${magenta}󱄠 󰬹  󰬺󰬹󰬹 󰮷\n${white}"
read -n 3 -p "ㅤ⋙ㅤ" vol

echo

if [[ -z $vol ]] || [[ ! $vol =~ ^[0-9]+$ ]]; then
    printf "${pink}󰟿 Invalid input!"
    sleep 1
    exit 1
elif ((vol >= 100)); then
    svol 100
else
    svol $vol
fi
