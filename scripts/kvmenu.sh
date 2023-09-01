#!/bin/bash

vmlist=$(virsh list --all | grep -v "^$" | tail -n +3 | awk '{print $2" | "$3$4";"}' | tr -d '\n')

echo "$vmlist"

TOP_MENU=$(rofi -sep ";" -dmenu -i -p 'KVMs' -theme ~/.cache/wal/colors-rofi-dark.rasi -location 0 -xoffset -14 -yoffset -52 -width 10 -hide-scrollbar -line-padding 4 -padding 20 -lines 4 <<< $vmlist)

if [ -z "$TOP_MENU" ]; then
    exit 0
fi

VMName=$(echo "$TOP_MENU" | cut -d'|' -f1 | tr -d ' ')
State=$(echo "$TOP_MENU" | cut -d'|' -f2 | tr -d ' ')

actions="reboot|shutdown"
if [ "$State" == "shutoff" ]; then
    actions="start"
fi


action=$(rofi -sep "|" -dmenu -i -p "$TOP_MENU" -theme ~/.cache/wal/colors-rofi-dark.rasi -location 0 -xoffset -14 -yoffset -52 -width 10 -hide-scrollbar -line-padding 4 -padding 20 -lines 4 <<< $actions)

virsh $action $VMName
