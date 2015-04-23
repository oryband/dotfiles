# have screen will start x
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
