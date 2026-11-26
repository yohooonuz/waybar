#!/usr/bin/env bash

shopt -s nullglob
files=(
    /usr/share/applications/*.desktop
    /var/lib/flatpak/exports/share/applications/*.desktop
    $HOME/.local/share/flatpak/exports/share/applications/*.desktop
    $HOME/.local/share/applications/*.desktop
)
shopt -u nullglob

list_apps() {
    awk '
    function flush() {
      if (file == "" || name == "") return
      if (hidden) delete apps[name] 
      else        apps[name] = file 
    }
    FNR == 1 { flush(); file = FILENAME; name = ""; hidden = 0; in_entry = 0 }
    /^\[/    { in_entry = ($0 == "[Desktop Entry]"); next }
    in_entry && /^Name=/ && name == ""       { name = substr($0, 6) }
    in_entry && /^(NoDisplay|Hidden)=true/   { hidden = 1 }
    END {
      flush()
      for (n in apps) print n "\t" apps[n]
    }
  ' "${files[@]}" | sort -f -t $'\t' -k1,1
}

selected=$(list_apps |
    fzf --delimiter=$'\t' \
        --with-nth=1 \
        --prompt="  ~>  " \
        --layout=reverse \
        --border=rounded \
        --margin=4% \
        --color="bg:#1e1e2e,bg+:#24273a,fg:#b4befe,fg+:#b7bdf8" \
        --color="hl:#f38ba8,hl+:#a6e3a1,info:#f9e2af,prompt:#89b4fa" \
        --color="pointer:#89dceb,spinner:#89dceb" \
        --color="border:#cba6f7" |
    cut -f2)

if [ -n "$selected" ]; then
    setsid -f gtk-launch "$(basename "$selected")" >/dev/null 2>&1
fi
