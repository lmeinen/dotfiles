#!/usr/bin/env bash

original_dir="$(pwd)"

cd "$(dirname "$0")" || exit

# import pywal colors
source "$HOME/.cache/wal/colors.sh"

grace=( --grace 5 --fade-in 5)
while getopts i name
do
  case $name in
    i) grace=();;
    ?) echo "Invalid option -$OPTARG" >&2
       exit 1;;
  esac
done

# ensure 1PW is locked
1password --lock

swaylock \
  --indicator-radius 160 \
  --indicator-thickness 20 \
  --inside-color 00000000 \
  --inside-clear-color 00000000 \
  --inside-ver-color 00000000 \
  --inside-wrong-color 00000000 \
  --key-hl-color "$color1" \
  --bs-hl-color "$color2" \
  --ring-color "$background" \
  --ring-clear-color "$color2" \
  --ring-wrong-color "$color5" \
  --ring-ver-color "$color3" \
  --line-uses-ring \
  --line-color 00000000 \
  --font 'JetBrains Mono:style=Regular:size=21' \
  --text-color 00000000 \
  --text-clear-color 00000000 \ #"$color2" \
  --text-wrong-color 00000000 \ #"$color5" \
  --text-ver-color 00000000 \ #"$color4" \
  --separator-color 00000000 \
  --screenshot \
  "${grace[@]}" \
  --effect-blur 10x10 \
  --effect-compose "100x100;center;$HOME/.config/sway/lock.png" \
  --daemonize
