#!/usr/bin/env sh

ensure_directory .config/vifm
link_config "config/vifm/vifmrc"
link_config "config/vifm/colors"
check_command "vifm"
