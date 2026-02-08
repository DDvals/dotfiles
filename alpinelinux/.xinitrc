#!/bin/sh

setxkbmap -layout it
xrandr --output Virtual-1 --mode 1920x1080

dwmblocks &
dunst &

feh --bg-scale ~/wallpapers/wp11936769-cyberpunk-pixel-wallpapers.png

if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
  eval $(dbus-launch --sh-syntax --exit-with-session)
fi
exec dwm
