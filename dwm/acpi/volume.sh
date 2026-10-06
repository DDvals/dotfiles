#!/bin/sh

case "$1" in
    up)
        amixer set Master 5%+ >/dev/null
        ;;
    down)
        amixer set Master 5%- >/dev/null
        ;;
    mute)
        amixer set Master toggle >/dev/null
        ;;
esac

mute=$(amixer get Master | grep -o '\[on\]\|\[off\]' | head -1)
volume=$(amixer get Master | grep -o '[0-9]\+%' | head -1)

if [ "$mute" = "[off]" ]; then
    /usr/local/bin/user-run dunstify -a "volume" \
        -h string:x-dunst-stack-tag:volume \
        -h int:value:0 \
        "Volume" "Muted"
else
    percent=${volume%\%}
    /usr/local/bin/user-run dunstify -a "volume" \
        -h string:x-dunst-stack-tag:volume \
        -h int:value:"$percent" \
        "Volume" "$volume"
fi
