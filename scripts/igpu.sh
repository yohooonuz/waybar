#!/usr/bin/env bash

out=$(intel_gpu_top -J -s 500 -n 2 2>/dev/null)

busy=$(echo "$out" | jq -s 'flatten | .[-1].engines
  | to_entries
  | map(select(.key | startswith("Render/3D")))
  | .[0].value.busy // 0 | floor' 2>/dev/null)
freq=$(echo "$out" | jq -s 'flatten | .[-1].frequency.actual // 0 | floor' 2>/dev/null)

busy=${busy:-0}
freq=${freq:-0}

class="normal"
[ "$busy" -ge 70 ] && class="warning"
[ "$busy" -ge 90 ] && class="critical"

jq -nc --arg text "${busy}%" \
    --arg tip " <span color='#b4befe' size='9984'>${freq} MHz</span>" \
    --arg class "$class" \
    '{text: $text, tooltip: $tip, class: $class}'
