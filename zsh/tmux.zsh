#!/usr/bin/env zsh

function tmx() {
    if [[ -z "${1}" ]]; then
        tmux -2 list-sessions -F "#{?session_attached,$fg[cyan],$fg[white]}#{session_name}$fg[white] - #{session_windows} window(s)"
    else
        tmux has-session -t "${1}" >/dev/null 2>&1 || TMUX="" tmux -2 new-session -s "${1}" -d
        ( [ -z "${TMUX}" ] && tmux -2 attach -t "$1" ) || tmux -2 switch -t "${1}"
        [ -n "${2}" ] && tmx "$@"
    fi
}

function tmc() {
    local commands_to_launch
    set -A commands_to_launch -- "$@"
    commands_to_launch=("${commands_to_launch[@]:2}")

    local session_name="${1}"

    if tmux has-session -t "${session_name}" >/dev/null 2>&1; then
        local _confirm
        local _window_name="commands-${#commands_to_launch}"

        read -q "_confirm?Session ${session_name} already exists, are you sure? "
        echo ""

        [[ "${_confirm}" == "n" ]] && return 0

        echo "Launching into new window ${_window_name} in ${session_name}"
        tmux -2 new-window -t "${session_name}" -n "${_window_name}"
    else
        TMUX="" tmux -2 new-session -d -s "${session_name}"
    fi

    echo "Run ${#commands_to_launch} commands in ${session_name}"

    local launch_command
    local first=1

    for launch_command in "${commands_to_launch[@]}"; do
        [ $first -eq 1 ] && first=0 || tmux -2 split-window -t "${session_name}" >/dev/null
        tmux -2 select-layout -t "${session_name}" even-vertical >/dev/null
        tmux -2 send -t "${session_name}" "${launch_command}" ENTER >/dev/null
    done
}

function __tmux_sessions() {
    local expl
    local -a sessions

    sessions=( ${${(f)"$(command tmux list-sessions)"}/:[ $'\t']##/:} )
    _describe -t sessions 'sessions' sessions "$@"
}
compdef __tmux_sessions tmx

# eventually start tmux
if [[ $- == *i* ]] && [ -z "${TMUX}" ] && command -v tmux >/dev/null 2>&1 ; then
  tmux ls >/dev/null 2>&1
  if [ $? -ne 0 ] ; then
    tmux -2 new -s default
  else
    printf "\n$fg[blue]Some tmux sessions available$fg[white]\n"
    tmx
    echo ""
  fi
fi
