#!/bin/bash

# [Desktop Entry]
# Name=synergyc
# Exec=/bin/bash /home/linaro/network.sh &
# Type=Application

x=0

while !  /sbin/ifconfig | grep  -F  "192.168." > /dev/null ; do
    echo "no nework"
    if  test "$x" -gt 20000; then
        #Time out here
        exit 1
    x=$((x+1))
    sleep .1
    fi
done

synergyc 192.168.31.162
