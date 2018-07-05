#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Alias file
source ~/.config/.aliases

PS1="\[\e[1m\][\h:\w] \[\e[31;1m\]%\[\e[0m\] "

# Resets terminal colour after PS1
#trap '[[ -t 1 ]] && tput sgr0' DEBUG
