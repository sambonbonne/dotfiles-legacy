#!/usr/bin/env sh

mkdir -p ~/.tmux/plugins
link_config "tmux.conf"
link_config "tmux"
command -v git >/dev/null 2>&1 && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || echo "Can't install Tmux plugins manager"
check_command "tmux"
