#!/bin/sh

if eww windows | grep -q "\*brightness"; then
    eww update bright-level="$(brightnessctl -m -d intel_backlight | cut -d ',' -f 4 | tr -d '%')"
else
    eww close volume
    eww open brightness

    eww update bright-level="$(brightnessctl -m -d intel_backlight | cut -d ',' -f 4 | tr -d '%')"
    sleep 2
    sleep 1
    eww close brightness
fi
