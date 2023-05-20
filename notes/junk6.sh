#!/usr/bin/env bash

data="{alignment}{quite evil}{burden}{10}{gp}{279}{hp}{1342}{maxgp}{279}{maxhp}{1342}{xp}{1077072}"

# Set the delimiter
delimiter="}"

# Remove leading '{' from the data
data=${data#\{}

# Split the data into an array based on the delimiter '}'
IFS="$delimiter"
read -ra values <<< "$data"

burden=${values[3]#\{}
gp=${values[5]#\{}
hp=${values[7]#\{}
xp=${values[13]#\{}

formatted_string=$(printf "Burden:%s GP:%s HP:%s XP:%s" "$burden" "$gp" "$hp" "$xp")
echo "$formatted_string"
