#!/usr/bin/env bash

data="{alignment}{quite evil}{burden}{10}{gp}{279}{hp}{1342}{maxgp}{279}{maxhp}{1342}{xp}{1077072}"

# Set the delimiter
delimiter="}"

# Remove leading '{' from the data
data=${data#\{}

# Split the data into an array based on the delimiter '}'
IFS="$delimiter"
read -ra values <<< "$data"

# Print the desired elements (2nd, 3rd, 4th, and 7th)
echo "${values[1]}"
echo "${values[2]}"
echo "${values[3]}"
echo "${values[6]}"
