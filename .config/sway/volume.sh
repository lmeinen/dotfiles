#!/bin/bash

ctl=/usr/bin/pactl
lockfile="$HOME/.config/sway/.lockfile"
iconDir="$HOME/.local/share/icons"

getIcon() {
    status=$("$ctl" full-status)
    mute=$(echo "$status" | cut -d ' ' -f2)

    if [ "$mute" == "yes" ]; then
        echo "$iconDir/material_volume_off.svg"
    else
        echo "$iconDir/material_volume_up.svg"
    fi
}

# stackoverflow magic 
# https://askubuntu.com/questions/1266769/find-device-description-of-default-sink-from-pulseaudio
currDevice=$(pacmd list-sinks | grep -Pzo "\* index(.*\n)*" | sed \$d | grep -e "device.description" | cut -f2 -d\")
current=$(pulseaudio-ctl current | tr -d '%')

if [ "$1" == "mute" ]; then
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    dunstify -i "$(getIcon)" -u normal -h string:x-dunst-stack-tag:volume -a "$currDevice" "Volume muted" -h "int:value:${current}"
else
    if [ "$1" == "inc" ]; then
        opt="+"
    elif [ "$1" == "dec" ]; then
        opt="-"
    fi
    
    # Fake the animated volume
    for i in $(seq $2); do

	if (( $(echo "$current==0" | bc -l) )) && [ "$opt" == "up" ]; then
		exit 0;
	elif (( $(echo "$current==100" | bc -l) )) && [ "$opt" == "down" ]; then
		exit 0;
	fi

	# Note: pulseaudio-ctl doesn't support fractional volume increases
	pactl set-sink-volume @DEFAULT_SINK@ "${opt}1%"

	current=$(pulseaudio-ctl current | tr -d '%')

	echo "$current"

        dunstify -i "$(getIcon)" -u normal -h string:x-dunst-stack-tag:volume -a "$currDevice" "Volume at ${current}%" -h "int:value:${current}"
    done
fi
