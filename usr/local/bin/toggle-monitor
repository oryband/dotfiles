#!/bin/bash
# toggle laptop monitor on/off

ARG=$(echo $1 | awk '{ print toupper($0) }')

LVDS1_ALIASES=(LVDS1 LVDS LAPTOP);
HDMI1_ALIASES=(HDMI1 HDMI);

LVDS1=$(printf "%s\n" "${LVDS1_ALIASES[@]}" | grep -c "^$ARG$")
HDMI1=$(printf "%s\n" "${HDMI1_ALIASES[@]}" | grep -c "^$ARG$")

if [[ $LVDS1 -eq 1 ]]; then OUTPUT="LVDS1";
elif [[ $HDMI1 -eq 1 ]]; then OUTPUT="HDMI1"; fi

IS_ACTIVE=$(xrandr | grep -cE "$OUTPUT connected (primary )?[1-9]+")
if [[ $IS_ACTIVE -eq 0 ]]; then
    xrandr --output $OUTPUT --auto
else
    xrandr --output $OUTPUT --off
fi
