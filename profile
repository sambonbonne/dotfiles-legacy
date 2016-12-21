#
# ~/.profile
# Eventually sourced by the shell
#

# disable XON/XOFF
stty -ixon

SH_CONFIG_PATH="${HOME}/.config/profile"

source "${SH_CONFIG_PATH}/path.sh"
source "${SH_CONFIG_PATH}/ssh_agent.sh"

# Eventually source Nix own env
local nix_env_path="${HOME}/.nix-profile/etc/profile.d/nix.sh"
[ -e "${nix_env_path}" ] && . "${nix_env_path}"
unset nix_env_path

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

# sometimes the TERM variable is not really pretty
if [[ $TERM == xterm || $TERM == vt220 ]]; then
    export TERM="xterm-256color"
fi

# some little configurations
export LESS="-FIRX -x2"
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export LESS_TERMCAP_ue=$'\E[0m'

# Eventually, Java and/or Android
[ -d "/usr/lib/jvm/default" ] && export JAVA_HOME="/usr/lib/jvm/default"
[ -d "/opt/android-sdk" ] && export ANDROID_HOME="/opt/android-sdk"
