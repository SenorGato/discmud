#!/usr/bin/env bash

pattern="\{([^{}]+)\}\{([^{}]+)\}"

tail -f ./logs/prompt.log | while IFS= read -r line; do
    if [[ $line =~ $pattern ]]; then
        key="${BASH_REMATCH[1]}"
        value="${BASH_REMATCH[2]}"
        line="${line/${BASH_REMATCH[0]}/}"
        declare "$key=$value"
        
        # Extract the key-value pairs
        burden=${values[3]#\{}
        gp=${values[5]#\{}
        hp=${values[7]#\{}
        xp=${values[13]#\{}
        
        # Write the first 3 key-value pairs to "left_prompt.log"
        printf "Burden:%d GP:%d HP:%d\n" "$burden" "$gp" "$hp" > left_prompt.log
        
        # Write the last key-value pair to "right_prompt.log"
        printf "XP:%d\n" "$xp" > right_prompt.log
    else
        echo "$line"
    fi
done
