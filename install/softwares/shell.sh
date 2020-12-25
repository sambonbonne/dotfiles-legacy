#!/usr/bin/env sh

# global config
link_config "dircolors"
link_config "profile"
link_config "config/profile"

# Bash
link_config "bashrc"
check_command "bash"

# Ion
link_config "config/ion"
check_command "ion"
# cargo install --git https://gitlab.redox-os.org/redox-os/ion/ ion-shell

# ZSH
link_config "zshrc"
link_config "zsh"
check_command "zsh"
