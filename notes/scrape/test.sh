#!/bin/bash

# File to parse
file="wiz"

# Regular expression pattern
pattern="<a href='https:\/\/discworldskills\.com\/[^>]+'>[^<]+<\/a><\/td><td>[0-9]+<\/td>"

# Read the entire file content
file_content=$(<"$file")

# Enable globstar option for recursive matching (if required)
shopt -s globstar

# Match the pattern globally and print all occurrences
while [[ $file_content =~ $pattern ]]; do
  echo "${BASH_REMATCH[0]}"
  file_content=${file_content#*"${BASH_REMATCH[0]}"}
done

