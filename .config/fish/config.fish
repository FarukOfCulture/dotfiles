function share
	echo -n (curl -sL -F"file=@$argv" https://0x0.st 2>/dev/null) | xclip -sel c && xclip -sel c -o && echo ""
end

function fish_title
	if test -z "$argv"
		prompt_pwd
	else
		echo $argv
	end
end

function og
	sh -c "$argv"
end

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

switch $TERM
	case kitty st-256color
		set -g prompt "|>"
	case '*'
		set -g prompt "➜"
end

alias icat "kitty +kitten icat"
alias grep "grep --color=auto"
alias tmp "cd /tmp/tmp"
alias mkdir 'mkdir -pv'
alias agit "git -C ~ add -u; git -C ~ add ~/.local/bin/ ~/.config/i3 ~/wall ~/.config/dmenu/ ~/.config/nvim/ftplugin; git -C ~ commit -m 'commit'; git -C ~ push"
alias rm 'rm -rv'
alias unlock 'doas rm -i /var/lib/pacman/db.lck'
alias sxiv 'sxiv -b'
alias grep 'grep -Ei'
alias cp "cp -r"
alias df 'df -h'
alias du 'du -h'
alias free 'free -m'
alias bc 'bc -l'
alias la 'exa -la --color=auto --icons --no-time --group-directories-first'
alias ls 'exa -l --color=auto --icons --no-time --group-directories-first'
alias open 'mimeopen'
alias yta "yt-dlp --extract-audio --audio-format mp3 -o '%(title)s.%(ext)s' (xclip -sel c -o)"
alias ytv "yt-dlp -f 'bv*[ext=mp4]+ba[ext=m4a]' -o '%(title)s.%(ext)s' (xclip -sel c -o)"
alias copy 'xclip -sel clip'
alias copypic 'xclip -sel clip -t image/png'
alias paste 'xclip -sel clip -o'
alias pastepic 'xclip -t image/png -sel clip -o > /tmp/pastepic && sxiv /tmp/pastepic'
#alias anime 'gitrun https://raw.githubusercontent.com/pystardust/ani-cli/master/ani-cli'
alias nitrogen 'nitrogen; betterlockscreen -u (cat ~/.config/nitrogen/bg-saved.cfg | head -n -2 | tail -n 1 | cut -c 6-) >/dev/null & disown >/dev/null '
alias hst "history | sort -u | fzf | tr -d '\n' | copy"
alias conn "kdeconnect-cli -n SM-A207F"
