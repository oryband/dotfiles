#!/usr/bin/env sh

DEFAULT_DPI=96

# try DPI from profile
printf "%s\n" "Trying to get DPI from \"${AUTORANDR_PROFILE_FOLDER}/dpi\""
DPI="$(cat "${AUTORANDR_PROFILE_FOLDER}/dpi" 2>/dev/null | head -n 1 | grep -o '[0-9]\+')"

# try dpi from primary monitor
if [ -z "$DPI" ]
then
     printf "%s\n%s\n" "No DPI value in profile \"$AUTORANDR_CURRENT_PROFILE\"" "Trying to calculate from primary monitor"
     DPX="$(xrandr -q | grep ' primary ' | grep -o ' [0-9]\+x' | grep -o '[0-9]\+')"
     DMM="$(xrandr -q | grep ' primary ' | grep -o ') [0-9]\+mm' | grep -o '[0-9]\+')"

     if [ -n "$DPX" -a -n "$DMM" ]
     then
          DPI="$(python -c "print( int( $DPX / ( $DMM * 0.039370079 ) ) )" )"
     fi
fi

if [ -z "$DPI" ]
then
     printf "%s\n%s\n" "Could not calculate DPI of primary monitor" "Using default"
     DPI=$DEFAULT_DPI
fi

printf "%s\n" "Resulting DPI: $DPI"

# sync dpi to xrdb
printf "%s\n" "Xft.dpi: $DPI" | xrdb -merge
