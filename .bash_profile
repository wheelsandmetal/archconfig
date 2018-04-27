#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$(tty)" = "/dev/tty1" ]; then
	exec startx
fi

export PATH="$HOME/.cargo/bin:$PATH"
