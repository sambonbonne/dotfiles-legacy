#!/usr/bin/env sh

ensure_directory .config/kak
link_config "config/kak/kakrc"
link_config "config/kak/colors"
link_config "config/kak-lsp"
check_command "kak"

# plugins are installed inside Kakoune
