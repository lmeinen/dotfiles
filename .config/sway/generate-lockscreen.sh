#!/bin/sh

# Blur, add a lock icon and text to the center of an image
convert $1 -filter Gaussian -blur 0x8 -font Liberation-Sans \
    -pointsize 26 -fill white -gravity center \
    -annotate +0+160 "Type Password to Unlock" lock.png \
    -gravity center -composite $2
