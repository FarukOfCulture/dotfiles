#!/usr/bin/env sh
#if pgrep ncspot; then playerctl -p ncspot play-pause; else termrun ncspot; fi
! pgrep spotify && spotify

while ! playerctl -p spotify play-pause; do
	sleep 1
done
