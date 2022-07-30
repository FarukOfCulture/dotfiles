#!/bin/sh

eval "$(xdotool getactivewindow getwindowgeometry --shell)"

xdotool mousemove "$(echo "$WIDTH / 2 + $X" | bc)" "$(echo "$HEIGHT / 2 + $Y" | bc)"
