#!/usr/bin/env sh

if ! xdotool search --class update; then
	# $(alacritty --class update,update -e yay -Syu --answerclean All --answerdiff None && polybar-msg hook updates 1) &
	eval "kitty --class update -e yay -Syu --answerclean All --answerdiff None && polybar-msg hook updates 1" &
fi

i3-msg workspace "update"
