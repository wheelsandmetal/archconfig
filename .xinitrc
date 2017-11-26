sudo bash /home/jakob/.config/scripts/wifi-spoof-bern.sh
xmodmap /home/jakob/.config/scripts/switchcapctl
make -C /home/jakob/.config/st &&
make -C /home/jakob/.config/dwm &&
exec /home/jakob/.config/dwm/dwm
