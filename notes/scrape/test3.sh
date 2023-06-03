#!/bin/bash

# File with names
names_file="wiz_full_parse"

# Output file
output_file="urls.txt"

# Base URL
base_url="http://discworld.starturtle.net/lpc/secure/finger.c?player="

# Read the names file and generate URLs
while IFS= read -r name; do
  url="${base_url}${name}"
  echo "$url" >> "$output_file"
done < "$names_file"

