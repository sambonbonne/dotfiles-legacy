#!/usr/bin/env sh

# Trackball settings

gsettings set org.gnome.desktop.peripherals.trackball scroll-wheel-emulation-button 8
gsettings set org.gnome.desktop.peripherals.trackball accel-profile adaptive

reset_keybinding() {
  gsettings list-recursively \
    | grep -F "${1}" \
    | cut -d '[' -f 1 \
    | while read -r line; do
      SCHEMA="$(echo "${line}" | cut -d ' ' -f 1)"
      KEY="$(echo "${line}" | cut -d ' ' -f 2)"
      gsettings set "${SCHEMA}" "${KEY}" "[]"
    done
    # | xargs -n 2 -I "{}" gsettings set "{}" "[]"
}

reset_keybindings() {
  for shortcut in "$@"; do
    reset_keybinding "${shortcut}"
  done
}

echo "Remove Gnome default bindings"
reset_keybindings '<Super>1' '<Super>2' '<Super>3' '<Super>4' '<Super>5' \
  '<Super>6' '<Super>7' '<Super>8' '<Super>9' '<Super>10' \
  '<Super>Tab' '<Alt>Tab' '<Shift><Super>Tab' '<Shift><Alt>Tab' \
  '<Alt>q' '<Alt>w' '<Alt>e' '<Alt>r' '<Alt>t' \
  '<Alt>a' '<Alt>s' '<Alt>d' '<Alt>f' '<Alt>g' \
  '<Alt>h' '<Alt>j' '<Alt>k' '<Alt>l' \
  '<Alt>y' '<Alt>u' '<Alt>i' '<Alt>o' '<Alt>p' \
  '<Alt>bracketleft' '<Alt>bracketright' \
  '<Alt>F4'


echo "Set new Gnome bindings"

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 \
  "[ '<Super>1', '<Super>q' ]"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 \
  "[ '<Shift><Super>exclam', '<Shift><Super>Q' ]"

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 \
  "[ '<Super>2', '<Super>w' ]"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2 \
  "[ '<Shift><Super>at', '<Shift><Super>W' ]"

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 \
  "[ '<Super>3', '<Super>e' ]"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3 \
  "[ '<Shift><Super>numbersign', '<Shift><Super>E' ]"

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 \
  "[ '<Super>4', '<Super>r' ]"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4 \
  "[ '<Shift><Super>dollar', '<Shift><Super>R' ]"

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 \
  "[ '<Super>5', '<Super>t' ]"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-5 \
  "[ '<Shift><Super>percent', '<Shift><Super>T' ]"

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 \
  "[ '<Super>6', '<Super>a' ]"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-6 \
  "[ '<Shift><Super>6', '<Shift><Super>A' ]"

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7 \
  "[ '<Super>7', '<Super>s' ]"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-7 \
  "[ '<Shift><Super>7', '<Shift><Super>S' ]"

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-8 \
  "[ '<Super>8', '<Super>d' ]"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-8 \
  "[ '<Shift><Super>asterisk', '<Shift><Super>D' ]"

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-9 \
  "[ '<Super>9', '<Super>f' ]"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-9 \
  "[ '<Shift><Super>left_parenthesis', '<Shift><Super>F' ]"

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-10 \
  "[ '<Super>10', '<Super>g' ]"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-10 \
  "[ '<Shift><Super>right_parenthesis', '<Shift><Super>G' ]"

gsettings set org.gnome.desktop.wm.keybindings switch-windows \
  "[ '<Super>Tab', '<Super>j' ]"

gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward \
  "[ '<Shift><Super>Tab', '<Super>k' ]"

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up \
  "[ '<Super>h' ]"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up \
  "[ '<Shift><Super>h' ]"

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down \
  "[ '<Super>l' ]"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down \
  "[ '<Shift><Super>l' ]"

gsettings set org.gnome.mutter.keybindings toggle-tiled-left \
  "[ '<Super>u' ]"
gsettings set org.gnome.desktop.wm.keybindings toggle-maximized \
  "[ '<Super>i' ]"
gsettings set org.gnome.mutter.keybindings toggle-tiled-right \
  "[ '<Super>o' ]"

gsettings set org.gnome.shell.keybindings open-application-menu \
  "[ '<Super>m' ]"
gsettings set org.gnome.desktop.wm.keybindings minimize \
  "[ '<Super>bracketleft' ]"
gsettings set org.gnome.desktop.wm.keybindings close \
  "[ '<Super>bracketright' ]"

gsettings set org.gnome.mutter.keybindings switch-monitor \
  "[ '<Super>p' 'XF86Display' ]"
