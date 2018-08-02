# X parameters
xset -b
setxkbmap -option compose:ralt # compose key

# decorations
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
feh --bg-scale "${HOME}/media/images/cityscape.png"

# utils
uxrvtd -q -o -f
~/.config/lemonbar/launch.sh
redhisft &

# start WM
exec spectrwm
