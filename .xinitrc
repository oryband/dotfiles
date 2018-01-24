#!/bin/sh

# load user Xresources
[ -f "$HOME/.Xresources" ] && xrdb -merge $HOME/.Xresources
[ -f "$HOME/.Xmodmap" ] && xmodmap $HOME/.Xmodmap

# load all xinitrc.d/ scripts
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh; do [ -x "$f" ] && . "$f"; done
    unset f
fi

# suspend desktop timer
/usr/bin/xautolock \
    -time 10 \
    -locker "systemctl suspend" \
    -notify 30 \
    -notifier "notify-send -u critical -t 10000 -- 'Suspending in 30s'" \
    -detectsleep &

xbindkeys
libinput-gestures-setup start

# toggle external screen if connected
external-monitor &

# logitech mouse
solaar --restart-on-wake-up &

# auto mount usb drives
udiskie &

# FIXME
# redshift-gtk &

exec i3  # >> ~/i3.log 2>&1

# vim:filetype=sh
