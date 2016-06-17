# Commands alias
alias ll='ls -FhlX --color=always --hide="*~"'
alias la='ls -AFhlX --color=always --hide="*~"'
alias search='grep -rnF --exclude "*~" --color=always'
alias zsh_history='mv ~/.zsh_history ~/.zsh_history_bad && strings ~/.zsh_history_bad > ~/.zsh_history && fc -R ~/.zsh_history && rm ~/.zsh_history_bad'
alias ports='netstat -pln'
command -v thefuck >/dev/null 2>&1 && eval "$(thefuck --alias)"

# Editing
alias vimlog='vim -w ~/.vimlog'
alias nvimdiff='nvim -d'
alias nview='nvim -R'
alias nvimlog='nvim -w ~/.nvimlog'

# Paging
alias nless='nvim -R -c "nnoremap q :q!<Enter>" -c "set noswapfile" -'
alias vless='vim -R -c "nnoremap q :q!<Enter>" -c "set noswapfile" -'

# Specific aliases
alias vim_clean_swp='find ./ -type f -name "\.*sw[klmnop]" -delete'

# Extensions aliases
alias -s bash=bash
alias -s sh=bash
alias -s json=nvim


# python virtualenv facility
function venv() {
    if [[ "$VIRTUAL_ENV" == "" ]]; then
        [[ "$1" != "" ]] && source "./$1/bin/activate" || echo "Where is the env?"
        rehash
    elif [[ "$1" == "update" ]]; then
        pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
    else
        deactivate || unset VIRTUAL_ENV
        rehash
    fi
}


# Tmux
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

function colors_list() {
    local text="${1:-}"

    [ -n "${text}" ] && text=" ${text}"

    for i in {0..255}; do
        printf "\x1b[38;5;${i}m%03d${text}\e[0m\n" ${i}
    done
}
