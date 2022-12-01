#!/bin/bash

# Terminate already running bar instances
# killall -q polybar
# If all your bars ipc enabled, you can also use
polybar-msg cmd quit

# Launch Polybar, using default config location ~/.config/polybar/config.ini
polybar -l trace -r -c $HOME/.config/polybar/config.ini mybar 2>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar launched..."
