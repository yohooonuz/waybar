#!/usr/bin/env bash

config_file=$(mktemp /tmp/waybar_cava.XXXXXX)
trap 'pkill -P $$ 2>/dev/null; rm -f "$config_file"' EXIT
trap 'exit' INT TERM

cat >"$config_file" <<EOF
[general]
framerate = 30
bars = 24 

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
EOF

cava -p "$config_file" | sed -u '
s/;//g
y/01234567/▁▂▃▄▅▆▇█/
s/▁/<span color="#cba6f7">▁<\/span>/g
s/▂/<span color="#cba6f7">▂<\/span>/g
s/▃/<span color="#89b4fa">▃<\/span>/g
s/▄/<span color="#74c7ec">▄<\/span>/g
s/▅/<span color="#89dceb">▅<\/span>/g
s/▆/<span color="#f5c2e7">▆<\/span>/g
s/▇/<span color="#eba0ac">▇<\/span>/g
s/█/<span color="#f38ba8">█<\/span>/g
'
