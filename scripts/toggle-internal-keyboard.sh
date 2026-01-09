#!/bin/bash

# Path to internal keyboard inhibit control
INTERNAL_KB="/sys/class/input/event3/device/inhibited"

# Check if any Keychron keyboard is connected (vendor 3434)
if lsusb | grep -q "3434:"; then
    # External keyboard connected - disable internal
    echo 1 > "$INTERNAL_KB"
else
    # No external keyboard - enable internal
    echo 0 > "$INTERNAL_KB"
fi
