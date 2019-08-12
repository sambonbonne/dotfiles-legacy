#!/usr/bin/env sh

killall -q polybar
while pgrep -u "$(id -u)" -x polybar >/dev/null; do sleep 1; done

MONITOR="$(xrandr --query | grep primary | cut -d ' ' -f 1)" polybar top &
