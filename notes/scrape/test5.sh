#!/bin/bash

filename="wiz_finger"
headers="-H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/112.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8' -H 'Accept-Language: en-US,en;q=0.5' -H 'Authorization: Basic YXNhbWk6d3lzaXd5Zw==' -H 'Connection: keep-alive' -H 'Cookie: User=asami-1' -H 'Upgrade-Insecure-Requests: 1' -H 'Pragma: no-cache' -H 'Cache-Control: no-cache'"

while IFS= read -r line; do
    echo "${line} ${headers}"
done < "$filename"

