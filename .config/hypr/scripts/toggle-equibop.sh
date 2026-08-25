#!/bin/bash
if hyprctl clients | grep -q "class: equibop"; then
    hyprctl dispatch togglespecialworkspace equibop
else
    equibop &
fi
