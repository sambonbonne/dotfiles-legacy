##
# jump command
# @author Samuel DENIS <samuel@denis.tech>
#
# @TODO make a plugin from this
##

# the command
function jump() { # @TODO allow to jump to subdirectory?
  if [ -n "${1}" ]; then
    local _path
    local _jumped=0
    for _path in ${JUMP_DIRECTORIES}; do
      if [ -d "${_path}/${1}" ]; then
        cd "${_path}/${1}"
        _jumped=1
        break
      fi
    done

    [ ${_jumped} -eq 0 ] && echo "Can't jump to ${1} in any of the directories in ${JUMP_DIRECTORIES}" && return 1

    [[ -n "${JUMP_HOOK_AFTER}" ]] && `echo "${JUMP_HOOK_AFTER}"`
  else
    echo "Usage: jump <directory>"
    echo "  You need to configure %{$JUMP_DIRECTORIES%} as an array before using jump"
  fi

  return 0
}

# completion function
function __jump_paths() { # @TODO prevent completion after one path
  local expl
  local _path
  local -a paths

    for _path in ${JUMP_DIRECTORIES}; do
      paths+=(${${(f)"$(ls -1 -d $_path/*/ | xargs -n1 basename)"}/:[ $'\t']##/:})
    done

  _arguments "1: :(${paths})"
}

# completion definition
compdef __jump_paths jump

# eventual alias creation
[[ -n "${JUMP_ALIAS}" ]] && alias `echo "${JUMP_ALIAS}"`='jump' && compdef __jump_paths `echo "${JUMP_ALIAS}"`
