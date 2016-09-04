#!/bin/sh

# load user Xresources
[ -f "$HOME/.Xresources" ] && xrdb -merge $HOME/.Xresources
[ -f "$HOME/.Xmodmap" ] && xmodmap $HOME/.Xmodmap

# load all xinitrc.d/ scripts
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh; do [ -x "$f" ] && . "$f"; done
    unset f
fi

# virtualbox
[ -f /usr/bin/VBoxClient-all ] && /usr/bin/VBoxClient-all

# lock desktop timer
xautolock -time 10 -locker "i3lock-wrapper" &

# toggle external screen if connected
external-monitor &

# FIXME
# redshift-gtk &

# inital wallpaper, next wallpapers are switched by cron
feh --bg-scale "$(find $HOME/Documents/interfacelift-downloader/wallpapers/*.jpg | shuf -n1)"

exec i3  # >> ~/i3.log 2>&1

# vim:filetype=sh
