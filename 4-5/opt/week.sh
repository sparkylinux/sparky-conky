#!/bin/bash

font=("\${font vera:size=6}" "\${voffset -4}\${font vera:size=10}" "\${voffset -5}\${font vera:size=16}" "\${voffset -8}\${font vera:size=24}\${color3 ffffff}" "\${voffset -2}\${font vera:size=16}" "\${voffset -2}\${font vera:size=10}" "\${voffset -2}\${font vera:size=6}")
color=("" "" "" "\${color}" "" "" "")

for i in $(seq -3 3); do
echo -n "${font[$[i+3]]}$(date '+%d' -d "$i days")${color[3]}\${offset 3}"
done

