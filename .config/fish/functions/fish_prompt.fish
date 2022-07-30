function fish_prompt
	set -f last_status $status
	set -f last_duration $CMD_DURATION
	
	set_color --bold blue
	echo -n (prompt_pwd)\ 
	set_color normal
	
	if test $last_duration -gt 2000
		set -f h (echo "scale=0; $last_duration/3600000" | bc)
		set -f m (echo "scale=0; $last_duration/60000-$h*60" | bc)
		set -f s (echo "scale=0; $last_duration/1000-$m*60" | bc)
		set_color --bold yellow

		test $h -gt 0 && echo -n $h\h
		test $m -gt 0 && echo -n $m\m
		test $s -gt 0 && echo -n $s\s
		echo -n ' '
			
	end

	if test $last_status -eq 0
		set_color --bold green
	else
		set_color --bold red
	end

	echo -n $prompt\ 
	set_color normal
end

