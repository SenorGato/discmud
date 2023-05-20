#!/usr/bin/env bash

data="{alignment}{quite evil}{burden}{10}{gp}{279}{hp}{1342}{maxgp}{279}{maxhp}{1342}{xp}{1077072}"

# Set the delimiter
delimiter="}"

# Remove leading '{' from the data
data=${data#\{}

# Split the data into an array based on the delimiter '}'
IFS="$delimiter"
read -ra values <<< "$data"

# Extract the key-value pairs
burden=${values[3]#\{}
gp=${values[5]#\{}
hp=${values[7]#\{}
xp=${values[13]#\{}

# Write the first 3 key-value pairs to "left_prompt.log"
printf "Burden:%d GP:%d HP:%d\n" "$burden" "$gp" "$hp" > left_prompt.log

# Write the last key-value pair to "right_prompt.log"
printf "XP:%d\n" "$xp" > right_prompt.log
