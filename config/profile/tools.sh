#!/usr/bin/env sh

# less
export LESS="-FIRX -x2"
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export LESS_TERMCAP_ue=$'\E[0m'

# Default editor
_default_editor() {
  local nvim_path="$(command -v nvim)"
  [ -n "${nvim_path}" ] && echo "${nvim_path}" && return 0

  local vim_path="$(command -v vim)"
  [ -n "${vim_path}" ] && echo "${vim_path}" && return 0

  echo "vi" && return 0

  return 1
}
export EDITOR="$(_default_editor)"
export GIT_EDITOR="${EDITOR}"
