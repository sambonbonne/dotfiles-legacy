#!/usr/bin/env sh

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
