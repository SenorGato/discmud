#!/bin/bash

input_file="stuffage"
output_file="output.txt"
index=1

while IFS= read -r command; do
    echo "Executing Command: $command"
    echo "Index: $index" >> "$output_file"
    echo "-----------------------" >> "$output_file"
    eval "$command" >> "$output_file"
    echo "-----------------------" >> "$output_file"
    sleep 2
    ((index++))
done < "$input_file"
