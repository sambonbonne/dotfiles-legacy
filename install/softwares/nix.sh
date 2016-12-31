#!/usr/bin/env sh

ensure_directory .nixpkgs
link_config "nixpkgs/config.nix"
check_command "nix-env"
