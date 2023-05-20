##!/usr/bin/env bash

pattern="\{([^{}]+)\}\{([^{}]+)\}"

tail -f ./logs/prompt.log | while IFS= read -r line; do
    echo "$line"

    data="$line"

    # Set the delimiter
    delimiter="}"

    # Remove leading '{' from the data
    data=${data#\{}

    # Split the data into an array based on the delimiter '}'
    IFS="$delimiter"
    read -ra values <<< "$data"

    # Extract the key-value pairs
    burden=${values[3]#\{}
    gp=${values[5]#\{}
    hp=${values[7]#\{}
    xp=${values[13]#\{}    

    # Debugging statements
    echo "burden=$burden"
    echo "gp=$gp"
    echo "hp=$hp"
    echo "xp=$xp"

    # Append the new line to "left_prompt.log"
    printf "Burden:%d GP:%d HP:%d\n" "$burden" "$gp" "$hp" >> left_prompt.log

    # Write the last key-value pair to "right_prompt.log"
    printf "XP:%d\n" "$xp" > right_prompt.log

    # Display the new line to stdout
    echo "New line: $line"
done
