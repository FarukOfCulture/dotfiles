#!/usr/bin/env sh

if [ -e /tmp/brightness ]; then exit 0; fi

touch /tmp/brightness

x=$(xrandr --verbose | grep Brightness: | cut -d ' ' -f 2)

if [[ $x < 1.0 && ${1:0:1} = '+' ]] || [[ $x > 0.0 && ${1:0:1} = '-' ]]; then
	xrandr --output DVI-0 --brightness $(echo $x $1 | bc)
fi

dunstify -t 1000 -u low 'Brightness' $(xrandr --verbose | awk '/Brightness/ {print "scale=0;" $2 "*100"}' | bc | awk -F. '{print $1}')

rm /tmp/brightness
