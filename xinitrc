# X parameters
xset -b
setxkbmap -option compose:ralt # compose key

# decorations
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
feh --bg-scale "${HOME}/.config/background.png"

# utils
uxrvtd -q -o -f
compton -b --config ~/.config/compton.conf

# start WM
xss-lock -- i3lock -f -i "${HOME}/.config/background.png" &
exec spectrwm
