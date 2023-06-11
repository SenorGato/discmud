#!/bin/bash

while IFS= read -r line; do
    if [[ $line =~ .*NO\ SITU.* ]]; then
        echo "$line"
    fi
done < 2013_auction
