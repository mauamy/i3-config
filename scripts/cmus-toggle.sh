#!/bin/bash

status=$(cmus-remote -Q | grep "status" | cut -d" " -f2)

if [[ "$status" = "playing" ]]; then
	cmus-remote --pause
else
	cmus-remote --play
fi
