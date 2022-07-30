#!/usr/bin/env sh


x=$(echo -n '' | dmenu)
while test -n "$x" ; do
	x=$(echo "scale=2; $x" | bc -l | dmenu)
done
