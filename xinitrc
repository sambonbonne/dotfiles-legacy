# X parameters
xset -b
setxkbmap -option compose:ralt # compose key

# decorations
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
feh --bg-scale "${HOME}/.config/background.png"

# utils
uxrvtd -q -o -f
compton -b --config ~/.config/compton.conf
redhisft &

# start WM
exec spectrwm
