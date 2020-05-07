#!/usr/bin/env sh

ensure_directory .config/kak
link_config "config/kak/kakrc"
check_command "kak"

# plugins installation
git clone https://github.com/andreyorst/plug.kak.git ~/.config/kak/plugins/plug.kak
