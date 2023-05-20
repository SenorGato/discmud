#!/usr/bin/env bash

file="./left_prompt.log"

# Monitor file changes using inotifywait
while inotifywait -e modify "$file" 2>/dev/null; do
  changes=$(grep -v 'burden' "$file")
  echo "$changes"
done
