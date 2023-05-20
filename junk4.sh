#!/usr/bin/env bash

data="{alignment}{quite evil}{burden}{10}{gp}{279}{hp}{1342}{maxgp}{279}{maxhp}{1342}{xp}{1077072}"

# Set the delimiter
delimiter="}"

# Remove leading '{' from the data
data=${data#\{}

# Split the data into an array based on the delimiter '}'
IFS="$delimiter"
read -ra values <<< "$data"

# Print the desired elements (2nd, 3rd, 4th, and 7th) without leading '{'

formatted_string=$(printf "Burden:%d GP:%d HP:%d XP:%d" "${values}" "$gp" "$hp" "$xp")
echo "$formatted_string"

echo "${values[3]#\{}"
echo "${values[5]#\{}"
echo "${values[7]#\{}"
echo "${values[13]#\{}"

