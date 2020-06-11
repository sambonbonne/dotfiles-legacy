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
  kak_path="$(command -v kak)"
  test -n "${kak_path}" && echo "${kak_path}" && return 0

  nvim_path="$(command -v nvim)"
  test -n "${nvim_path}" && echo "${nvim_path}" && return 0

  vim_path="$(command -v vim)"
  test -n "${vim_path}" && echo "${vim_path}" && return 0

  echo "vi" && return 0
}
export EDITOR="$(_default_editor)"
export GIT_EDITOR="${EDITOR}"
test "${EDITOR}" = "nvim" && alias vim='nvim'
test "${EDITOR}" != "kak" && DIFFPROG="${EDITOR} -d"

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

# a more compatible difftool
_default_difftool() {
  local nvim_path="$(command -v nvim)"
  [ -n "${nvim_path}" ] && echo "${nvim_path} -d" && return 0

  local vim_path="$(command -v vim)"
  [ -n "${vim_path}" ] && echo "${vim_path} -d" && return 0

  local diff_so_fancy_path="$(command -v diff-so-fancy)"
  [ -n "${diff_so_fancy_path}" ] && echo "${diff_so_fancy_path}" && return 0

  echo "" && return 0
}
export DIFFTOOL="$(_default_difftool)"
export GIT_DIFFTOOL="${_default_difftool}"

# detect encoding of a file
detect_encoding() {
  tmp_encodings_file="/tmp/iconv_encodings"
  iconv --list | sed 's/\/\/$//' | sort > "${tmp_encodings_file}"

  for encoding in $`cat "${tmp_encodings_file}"`; do
    iconv -f "${encoding}" -t "UTF-8" "${1}" > /dev/null 2>&1 && printf "\033[32m✓\033[0m" || printf "\033[31m✗\033[0m"
    printf " ${encoding}\n"
  done

  rm "${tmp_encodings_file}"
}
