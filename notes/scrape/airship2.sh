#!/bin/bash

while IFS= read -r line; do
    split_line=$(echo "$line" | awk '{
        for(i=1; i<=NF; i++) {
            if ($i ~ /[0-9]+|NO SITU/) {
                numbers = numbers $i " "
            } else {
                names = names $i " "
            }
        }
        print names "," numbers
    }')
    echo "$split_line"
done < 2013_auction
