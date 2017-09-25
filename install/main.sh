#!/usr/bin/env sh

set -e

_git_repo="https://github.com/smumu/dotfiles"
_dotfiles_dir="${HOME}/dev/dotfiles"
_installation_dir="${HOME}"

# Clone or update dotfiles
if [ -d "${_dotfiles_dir}" ]; then
  command -v git >/dev/null 2>&1 || { echo "Found ${_dotfiles_dir} but can't update it"; return 0; }

  cd "${_dotfiles_dir}"
  #sh update.sh fetch
else
  command -v git >/dev/null 2>&1 || { echo "Git isn't install and ${_dotfiles_dir} doesn't exists, impossible to continue"; return 1; }

  echo "The Git repository ${_git_repo} will be cloned in ${_dotfiles_dir}"
  mkdir -p ${_dotfiles_dir}
  git clone "${_git_repo}" "${_dotfiles_dir}"
  cd "${_dotfiles_dir}"
fi

# create a director if needed
ensure_directory() {
  [ -d "${1}" ] || mkdir -p "${_installation_dir}/${1}"
}

ensure_directory ".config"

# quickly link a file
link_config() {
  local orig="${_dotfiles_dir}/${1}"
  local dest="${_installation_dir}/${2:-.${1}}"

  [ -L "${dest}" ] && return 0 # file is a symbolic link, don't change it

  if [ -f "${dest}" ]; then
    echo "Moving ${dest} to ${dest}.bak"
    mv "${dest}" "${dest}.bak"
  fi

  echo "Symlink ${orig} to ${dest}"
  ln -s "${orig}" "${dest}"
}

# check a command exists and display a message
check_command() {
  local success="${2:-${1} is installed and configured}"
  local fail="${3:-${1} is configured but not installed}"

  command -v "${1}" >/dev/null 2>&1 && echo "${success}" || echo "${fail}"
}

_softwares_dir="$(realpath "$(pwd)/$(dirname "${0}")")/softwares"

# get softwares configuration files
get_config_files() {
  ls "${_softwares_dir}" | sed -e 's/\t/\n/g' | grep '.sh$'
}

install_sofware() {
  [ -n "${1}" ] && { echo "${1}" | install_sofware; return 0; }

  local soft_name

  while read soft_name
  do
    [ -z "${soft_name}" ] && { echo "No software to configure given"; return 1; }

    local soft_install_script="${_softwares_dir}/${soft_name}.sh"

    [ ! -f "${soft_install_script}" ] && { echo "Can't find ${soft_name} configuration script"; return 1; }

    echo "Configuring ${soft_name}"
    INSTALL_DIR="${_installation_dir}" source "${soft_install_script}"
    echo "Configured ${soft_name}"
  done
}

if [ -n "${1}" ]; then
  install_sofware "${1}"
else
  get_config_files | sed -e 's/.sh$//g' | install_sofware
fi
