#!/usr/bin/env sh

ensure_directory .config/kak
link_config "config/kak/kakrc"
link_config "config/kak-lsp"
check_command "kak"

# plugins installation
git clone https://github.com/robertmeta/plug.kak.git ~/.config/kak/plugins/plug.kak
