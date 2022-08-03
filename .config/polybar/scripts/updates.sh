#!/bin/sh

yay -Sy &>/dev/null

if test "$(pacman -Qu | wc -l)" -gt 0; then
	printf " %s" "$(pacman -Qu | wc -l)"
fi
