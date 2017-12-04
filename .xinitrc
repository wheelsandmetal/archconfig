#!/bin/sh
sudo bash $HOME/.config/scripts/wifi-spoof-bern.sh # Only need for Bern wifi, they only whitelisted 2 MAC address

# Swapping left control with caps, needed to use Xkb as xmodmap was being weird
# If this is a new install run, uncomment the line below and restart X then recomment it (or don't I don't care)
#sudo localectl set-x11-keymap gb pc105 "" ctrl:swapcaps

exec $HOME/.config/st/st &
exec $HOME/.config/dwm/dwm
