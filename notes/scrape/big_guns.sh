#!/bin/bash

input_file="stuffage"
output_file="raws"
index=1

while IFS= read -r url; do
    echo "Processing URL: $url"
    response=$(curl -s $url)
    echo "Index: $index" >> "$output_file"
    echo "$response" >> "$output_file"
    echo "----------------------------------" >> "$output_file"
    sleep 1
    ((index++))
done < "$input_file"
