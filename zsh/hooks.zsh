chpwd() {
  emulate -L zsh

  check_activate_venv
}

check_activate_venv() {
  if [ -z "${VIRTUAL_ENV}" ]; then
    VENV_PATH="$(find "$(pwd)" -maxdepth 1 -type d \( -name "env_*" -o -name "*_env" \) | head -1)"
    VENV_ACTIVATE_PATH="${VENV_PATH}/bin/activate"
    test -f "${VENV_ACTIVATE_PATH}" && source "${VENV_ACTIVATE_PATH}" && rehash
  fi
}

# launch at startup
check_activate_venv
