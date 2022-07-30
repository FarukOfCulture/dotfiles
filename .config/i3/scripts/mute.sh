#!/usr/bin/env sh

pactl set-sink-mute @DEFAULT_SINK@ toggle
if test "$(pactl get-sink-mute @DEFAULT_SINK@)" = 'Mute: yes'; then notify-send -t 1000 -i audio-volume-muted -u low 'Volume' Muted; else notify-send -i audio-volume-high -u low 'Volume' 'Unmuted'; fi
