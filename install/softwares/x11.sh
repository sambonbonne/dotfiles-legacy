#!/usr/bin/env sh

ensure_directory .config/conky
ensure_directory .config/dunst
ensure_directory .config/lemonbar
ensure_directory .config/polybar

link_config "Xresources"
link_config "spectrwm.conf"
link_config "xinitrc"
link_config "xsession"
link_config "config/background.png"
link_config "config/redshift.conf"
link_config "config/conky"
link_config "config/dunst"
link_config "config/lemonbar"
link_config "config/polybar"
