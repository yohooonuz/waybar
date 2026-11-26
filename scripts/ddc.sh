#!/usr/bin/env bash

LOCK=/tmp/ddc-brightness.lock
CACHE=/tmp/ddc-brightness.last

GetBright() {
  printf '{"text":"%s","percentage":%s}\n' "$1" "$1"
}

exec 9>"$LOCK"

flock -w 2 9 || {
  [[ -f $CACHE ]] && GetBright "$(<"$CACHE")" || printf '{"text":"?","percentage":0}\n'
  exit 0
}

raw="$(ddcutil --bus=4 getvcp 10 -t 2>/dev/null)"
bright="$(awk '{print $4}' <<<"$raw")"

if [[ $bright =~ ^[0-9]+$ ]]; then
  echo "$bright" >"$CACHE"
  GetBright "$bright"
else
  [[ -f $CACHE ]] && GetBright "$(<"$CACHE")" || printf '{"text":"?","percentage":0}\n'
fi
