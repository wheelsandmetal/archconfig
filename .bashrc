#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Alias file
source ~/.config/.aliases

PS1="\[\e[35m\]\u@\h \[\e[0m\]\W \$ "
