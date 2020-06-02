#!/usr/bin/env sh

DPI="$(xdpyinfo | grep 'resolution:' | grep -o '[0-9]\+x[0-9]\+' | head -n 1 | cut -d 'x' -f 1)"
[ -n "$DPI" ] && echo "$DPI" > "${AUTORANDR_PROFILE_FOLDER}/dpi"
