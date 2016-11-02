#
# ~/.profile
# Eventually sourced by the shell
#

# disable XON/XOFF
stty -ixon

## Utils

str_contains() {
    local string="${1}"
	local substring="${2}"
	if test "${string#*$substring}" != "${string}"; then
		return 0
	else
		return 1
	fi
}

## Path

# Append if exists and not already in path
path_append() {
	[ -d "${1}" ] && (! str_contains "${PATH}" "${1}") && PATH="${1}:${PATH}"
}

# Some custom bin (mine, PIP, NPM, Composer ...)
path_append "${HOME}/bin"
path_append "${HOME}/.local/bin"
path_append "${HOME}/.npm/bin"
path_append "${HOME}/.composer/vendor/bin"

## Other specific configurations

# Start SSH agent if not exists and warn if no stored key
_start_ssh_agent=1
if [[ ${_start_ssh_agent} -eq 1 ]]; then
  if [[ -z "${SSH_AUTH_SOCK}" ]]; then
    SSH_RUNTIME_DIR=${XDG_RUNTIME_DIR-/tmp}
    pidof ssh-agent 2>&1 > /dev/null || { ssh-agent -a "${SSH_RUNTIME_DIR}/ssh-agent.socket" 2>&1 > /dev/null && echo "\033[0;32mSSH agent started\033[0m" ; }
    export SSH_AUTH_SOCK="${SSH_RUNTIME_DIR}/ssh-agent.socket" ; export SSH_AGENT_PID="$(pidof ssh-agent)"
  fi

  ssh-add -L 2>&1 > /dev/null || echo "\033[0;31mNo SSH key stored, don't forget to add one\033[0m"
fi

# Enventual unprivileged pkgsrc config
local pkgsrc_env_path="${HOME}/pkg"
if [ -d "${pkgsrc_env_path}" ]; then
	path_append "${pkgsrc_env_path}/bin"
	path_append "${pkgsrc_env_path}/sbin"
	export CVSEDITOR="${EDITOR}"
	export CVS_RSH="ssh"
fi
unset pkgsrc_env_path

# Eventually source Nix own env
local nix_env_path="${HOME}/.nix-profile/etc/profile.d/nix.sh"
[ -e "${nix_env_path}" ] && . "${nix_env_path}"
unset nix_env_path

## Exports (at the end because we need $PATH to be filled)

# globals
export LANG=fr_FR.UTF-8
export LANGUAGE=fr_FR:en_US:en
export LOCALE=fr_FR.UTF-8
export LC_ADDRESS=fr_FR.UTF-8
export LC_COLLATE=fr_FR.UTF-8
export LC_CTYPE=fr_FR.UTF-8
export LC_IDENTIFICATION=fr_FR.UTF-8
export LC_MEASUREMENT=fr_FR.UTF-8
export LC_MESSAGES=fr_FR.UTF-8
export LC_MONETARY=fr_FR.UTF-8
export LC_NAME=fr_FR.UTF-8
export LC_NUMERIC=fr_FR.UTF-8
export LC_PAPER=fr_FR.UTF-8
export LC_TELEPHONE=fr_FR.UTF-8
export LC_TIME=fr_FR.UTF-8

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
export LESS="-FIRX -x4"
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
