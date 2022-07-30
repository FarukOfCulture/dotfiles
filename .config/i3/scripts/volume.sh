#!/usr/bin/env sh

func (){
x=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print substr($5,0,length($5)-1)}')
}

func
if [[ $x -lt 100 && ${1:0:1} = '+' ]] || [[ $x -gt 0 && ${1:0:1} = '-' ]]; then
	pactl set-sink-volume @DEFAULT_SINK@ $1
fi
func
dunstify -i audio-volume-high -t 1000 -u low $x%
