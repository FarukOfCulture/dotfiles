#!/bin/sh

yay -Sy &>/dev/null

if test "$(yay -Qu | wc -l)" -gt 0; then
	printf " %s" "$(yay -Qu | wc -l)"
fi
