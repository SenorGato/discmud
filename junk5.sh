#!/usr/bin/env bash
burden=10
gp=279
hp=1342
xp=1077072

formatted_string=$(printf "Burden:%d GP:%d HP:%d XP:%d" "$burden" "$gp" "$hp" "$xp")
echo "$formatted_string"
