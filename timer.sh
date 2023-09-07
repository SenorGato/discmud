#!/usr/bin/env bash

filename="timers.log"

tac "$filename" | while IFS= read -r line; do
    if [[ "$line" < "$target_time" ]]; then
        break
    fi
    echo "$line"
done
