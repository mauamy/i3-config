#!/bin/bash

output=$1
modVal=$2
current=$(xrandr --verbose | grep -i brightness | awk '{print $2}')
setValue=$current

if [ "$modVal" = "" ]; then
	bc <<< "$current*100 / 1" # '/ 1' cuts the decimals 
	exit 0
fi

# increase value if current less then 1.0
if [[ "$modVal" = "+"* ]] || [[ "$modVal" = "-"* ]]; then
	sign="${modVal:0:1}"
	value="${modVal:1}"
	setValue=$(bc <<< "scale=2; $current $sign $value/100")
elif [[ "$modVal" =~ [0-9] ]]; then
	setValue=$(bc <<< "scale=2; $modVal/100")
fi


if (( $(echo "$setValue > 1.0" |bc -l) )); then
  	setValue=1
fi

if (( $(echo "$setValue < 0.0" |bc -l) )); then
  	setValue=0
fi

xrandr --output $output --brightness $setValue
polybar-msg hook brightness 1
