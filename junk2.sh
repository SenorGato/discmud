#!/usr/bin/env bash

data="{alignment}{quite evil}{burden}{10}{gp}{279}{hp}{1342}{maxgp}{279}{maxhp}{1342}{xp}{1077072}"

# Set the delimiter
delimiter="}"

# Remove leading '{' from the data
data=${data#\{}

# Split the data into an array based on the delimiter '}'
IFS="$delimiter"
read -ra values <<< "$data"

# Iterate over the values and remove leading '{'
for ((i = 1; i < ${#values[@]}; i += 2)); do
  value=${values[i]}
  value=${value#\{}
  echo "$value"
done

