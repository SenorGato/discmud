#!/bin/bash

# File to parse
file="wiz_parse"

# Regular expression pattern
pattern="<a href='https:\/\/discworldskills\.com\/([^']+)'>([^<]+)<\/a><\/td><td>([0-9]+)<\/td>"

# Read the file line by line and match the pattern
while IFS= read -r line; do
  if [[ $line =~ $pattern ]]; then
    url="${BASH_REMATCH[1]}"
    value="${BASH_REMATCH[3]}"
    echo "/$url - $value"
  fi
done < "$file"
