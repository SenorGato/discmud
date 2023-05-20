#!/usr/bin/env bash

file="./left_prompt.log"

# Monitor file changes using inotifywait
while inotifywait -e modify "$file" 2>/dev/null; do
  burden_line=$(grep '^Burden' "$file" | awk -F ':' '{print $2}')
  echo -n "Burden: $burden_line"
done
