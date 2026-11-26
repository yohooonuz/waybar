#!/usr/bin/env bash

if [[ -r "$HOME/Documents/bashcolors_utils.sh" ]]; then
    source "$HOME/Documents/bashcolors_utils.sh"
else
    exit 1
fi

countdown() {
    for i in {3..0}; do
        printf "\r${green}%s ${blue}in ${red}%d\e[K" "$1" "$i"
        sleep 1
    done
}

printf "\n\t\t\t${teal}󰜴 ${sapphire}Power Actions ${teal}󰜱\n\n\n"

printf "\t\t${cyan}󰕅 Power Options:${magenta}

\t󰬺 󰷛 LockScreen
\t󰬻  ReLogin
\t󰬼  ReBoot
\t󰬽  PowerOff
\t󰬾 󰜺 CancelAction\n\n"

printf "\t${yellow}%s\n" " 󰬺  󰬾 󰮷${white}"
read -n 1 -p "ㅤ⋙ㅤ" option

echo
echo

if [[ -z $option ]] || [[ ! $option =~ ^[1-5]$ ]]; then
    echo "${pink}󰟿 Invalid Input!${default}"
    sleep 1
    exit 1
fi

case "$option" in
1)
    countdown "󰷛 LockScreen"
    hyprlock >/dev/null 2>&1
    ;;
2)
    countdown " ReLogin"
    hyprctl dispatch "hl.dsp.exit()"
    ;;
3)
    countdown " ReBoot"
    systemctl reboot
    ;;
4)
    countdown " PowerOff"
    systemctl poweroff
    ;;
*)
    exit 0
    ;;
esac
