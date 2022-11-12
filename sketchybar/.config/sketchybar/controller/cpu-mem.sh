#!/usr/bin/env sh

cpu=$(printf "%.2f\n" $(top -l 2 | grep -E "^CPU" | tail -1 | awk '{ print $3 + $5 }'))

page=$(pagesize)
togb=$((1024 ** 3))
anonymous=$(vm_stat | grep 'Anonymous' | awk '{print $3/1024}')
purgeable=$(vm_stat | grep 'purgeable' | awk '{print (($3*$tagb)/1024)}')
unused=$(top -l 1 | grep 'unused' | awk '{print $8}')

app_memory=$(printf "%.2f\n" $(awk "BEGIN {print ((((($anonymous*$page)-$purgeable-$unused)/$togb)*1024))}"))
wired_memory=$(printf "%.2f\n" $(top -l 1 | grep 'wired' | awk -F '(' '{print $2}' | awk '{print $1/1024}'))
compressed=$(printf "%.2f\n" $(top -l 1 | grep 'compressor' | awk -F '(' '{print $2}' | awk '{print $3/1024}'))
memory_usage=$(printf "%.2f\n" $(awk "BEGIN {print (($app_memory+$wired_memory+$compressed)+0.529)}"))

sketchybar -m --set $NAME label="🧠 cpu $cpu % | 🤖 memory $memory_usage GB |"
