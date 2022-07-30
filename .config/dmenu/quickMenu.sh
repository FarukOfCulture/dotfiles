input=$(echo Vpn | dmenu)
test -z $input && exit 0

if test $input = 'Vpn' ; then
	if protonvpn-cli d; then
		test ! $(xdotool search --onlyvisible --class brave) && brave &
		exit 0
	fi
	#xdotool key --window $(xdotool search --class ncspot) q 2>/dev/null
	i3-msg [class="Spotify"] kill &
	protonvpn-cli c 'NL-FREE#7' && test ! $(xdotool search --onlyvisible --class brave) && brave --incognito &
	exit 0

elif test ${input:0:1} = 't'  && test ${input:1:1} -gt 0 ; then
	sleep ${input:1} && notify-send -u critical ALARM "Time Out" -i alarm-clock-panel
	exit 0
fi

coproc ( notify-send Tuxi "$(tuxi -r $input)" )

