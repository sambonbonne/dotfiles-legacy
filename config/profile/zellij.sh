#!/usr/bin/env sh

function zj() {
  SESSIONS_LIST="$(zellij list-sessions | sed -e 's/(current)//g' | tr -s '[:blank:]')"

  if [ ! -z "${SESSIONS_LIST}" ]; then
    if which sk 2>&1 >/dev/null; then
      if [ -z "${1}" ]; then
        zellij attach "$(echo "${SESSIONS_LIST}" | sk)"
      else
        zellij attach "$(echo "${SESSIONS_LIST}" | sk -1 --query "${1}")"
      fi
    else
      echo "${SESSIONS_LIST}"
    fi
  fi
}
