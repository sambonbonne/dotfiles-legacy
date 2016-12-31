#!/usr/bin/env sh

link_config "tmux.conf"
link_config "tmux"

ensure_directory .tmux/plugins

_tmux_tpm_dir="${INSTALL_DIR}/.tmux/plugins/tpm"

if [ ! -d "${_tmux_tpm_dir}" ]; then
  command -v git >/dev/null 2>&1 && git clone https://github.com/tmux-plugins/tpm "${_tmux_tpm_dir}" || echo "Can't install Tmux plugins manager"
fi

check_command "tmux"
