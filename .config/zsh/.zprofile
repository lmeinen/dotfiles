
# If running from tty7 start sway
[ "$(tty)" = "/dev/tty1" ] && exec sway
