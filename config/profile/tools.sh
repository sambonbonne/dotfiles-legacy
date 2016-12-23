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

# a simple Vim pager
vless() {
  local pager_command=''

  if command -v nvim >/dev/null 2>&1; then
    pager_command="nvim"
  else
    pager_command="vim"
  fi

  pager_command="${pager_command} -R -c 'nnoremap q :q!<Enter>' -c 'set noswapfile'"

  if [[ "$#" -ne 1 ]]; then
    pager_command="${pager_command} -"
  else
    pager_command="${pager_command} ${1}"
  fi

  eval "${pager_command}"
}
