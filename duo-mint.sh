#!/bin/bash
# Zenbook Duo UX8406CA - Bottom screen management only (no backlight)

KEYBOARD_NAME="Zenbook Duo Keyboard"
BOTTOM_SCREEN="eDP-2"
MAIN_SCREEN="eDP-1"
INTERVAL=2

KEYBOARD_ATTACHED=false

while true; do
    if lsusb | grep -q "$KEYBOARD_NAME"; then
        if [ "$KEYBOARD_ATTACHED" = false ]; then
            echo "$(date) - Keyboard attached: turning OFF bottom screen"
            xrandr --output "$BOTTOM_SCREEN" --off
            KEYBOARD_ATTACHED=true
        fi
    else
        if [ "$KEYBOARD_ATTACHED" = true ]; then
            echo "$(date) - Keyboard detached: turning ON bottom screen"
            xrandr --output "$BOTTOM_SCREEN" --auto --below "$MAIN_SCREEN"
            KEYBOARD_ATTACHED=false
        fi
    fi
    sleep $INTERVAL
done
