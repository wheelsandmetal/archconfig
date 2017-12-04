#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#!/bin/sh
sudo bash $HOME/.config/scripts/wifi-spoof-bern.sh # Only need for Bern wifi, they only whitelisted 2 MAC address

# Swapping left control with caps, needed to use Xkb as xmodmap was being weird
# If this is a new install run, uncomment the line below and restart X then recomment it (or don't I don't care)
#sudo localectl set-x11-keymap gb pc105 "" ctrl:swapcaps

exec $HOME/.config/st/st &
exec $HOME/.config/dwm/dwm
