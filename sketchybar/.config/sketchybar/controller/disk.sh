#!/usr/bin/env sh

# DISK=$(df -H | awk '/\/dev\/disk3s1/ {printf("%s\n", $4*1024/1024)}')

DISK=$(df -H | awk '/\/dev\/disk4s3s1/ {printf("%s\n", $4*1024/1024)}')

DISKICON=􀤂

sketchybar -m --set $NAME icon=$DISKICON label="$DISK GB |"
