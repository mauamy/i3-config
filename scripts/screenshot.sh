#!/bin/sh

screenshotPath=~/Pictures/Screenshots/%Y-%m-%d-%T-screenshot.png

if [ "$1" = "screen" ]; then
	scrot -e 'xclip -selection clipboard -t image/png -i $f' $screenshotPath
elif [ "$1" = "sel" ]; then
	scrot -s -e 'xclip -selection clipboard -t image/png -i $f' $screenshotPath
elif [ "$1" = "window" ]; then
	scrot -u -e 'xclip -selection clipboard -t image/png -i $f' $screenshotPath
else
	echo "unknown option '$1'"
	exit 1
fi

if [ $? -ne 0 ]; then
	echo "screenshot failed"
	exit 1
fi

notify-send "Screenshot saved to ~/$(date +"%Y-%m-%d-%T")-screenshot.png"

