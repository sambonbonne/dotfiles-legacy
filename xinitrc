# load env
test -f /etc/profile && . /etc/profile
export PATH="$PATH:/usr/bin:/bin:/usr/local/bin"
. ~/.config/profile/path.sh
. ~/.config/profile/lc.sh

# X parameters
systemctl --user import-environment DISPLAY
xset -b
setxkbmap -option compose:ralt # compose key
[ -f "${HOME}/.screenlayout/main.sh" ] && . ~/.screenlayout/main.sh

# decorations
[[ -f ~/.Xresources ]] && xrdb -load ~/.Xresources
xsetroot -solid #'000000'
~/.fehbg &

# utils
#uxrvtd -q -o -f
#/usr/bin/uxrvtd -q -o -f
#LD_PRELOAD=/usr/lib/libswmhack.so.0.0 uxrvtd -q -o -f
compton -b --config ~/.config/compton.conf


# start WM
xss-lock -- i3lock -f -c "23292D" -i "${HOME}/.config/background.png" &
exec spectrwm
