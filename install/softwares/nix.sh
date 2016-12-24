#!/usr/bin/env sh

mkdir ~/.nixpkgs
link_config "nixpkgs/config.nix"
check_command "nix-env"
