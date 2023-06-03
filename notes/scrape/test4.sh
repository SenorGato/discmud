#!/bin/bash

# Input file
input_file="wiz_full_parse"

# Output file
output_file="wiz_finger"

# Remove " - 907" from each line and write to the output file
sed 's/ - [0-9]\+//' "$input_file" > "$output_file"
