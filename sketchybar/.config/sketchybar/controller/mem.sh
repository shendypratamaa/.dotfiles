#!/usr/bin/env sh

page=$(pagesize)
togb=$((1024 ** 3))
anonymous=$(vm_stat | grep 'Anonymous' | awk '{print $3/1024}')
purgeable=$(vm_stat | grep 'purgeable' | awk '{print (($3*$tagb)/1024)}')
unused=$(top -l 1 | grep 'unused' | awk '{print $8}')

app_memory=$(printf "%.2f\n" $(awk "BEGIN {print ((((($anonymous*$page)-$purgeable-$unused)/$togb)*1024))}"))
wired_memory=$(printf "%.2f\n" $(top -l 1 | grep 'wired' | awk -F '(' '{print $2}' | awk '{print $1/1024}'))
compressed=$(printf "%.2f\n" $(top -l 1 | grep 'compressor' | awk -F '(' '{print $2}' | awk '{print $3/1024}'))
memory_usage=$(printf "%.2f\n" $(awk "BEGIN {print (($app_memory+$wired_memory+$compressed)+0.529)}"))

sketchybar -m --set $NAME icon=🤖 label="mem $memory_usage GB |"
