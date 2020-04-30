# Commands alias
alias l='ls -Fhl --group-directories-first --color=always --hide="*~"'
alias ll='ls -AFhl --group-directories-first --color=always --hide="*~"'
alias search='grep -RnF --exclude "*~" --color=always'
alias c='clear && l'
alias zsh_history='mv ~/.zsh_history ~/.zsh_history_bad && strings ~/.zsh_history_bad > ~/.zsh_history && fc -R ~/.zsh_history && rm ~/.zsh_history_bad'
alias ports='ss -atn'
alias monochrome='sed "s,\x1B\[[0-9;]*[a-zA-Z],,g"'
alias clean_tmp_files='find . -type f -name "*~" -exec rm -f {} \;'
alias forcessh='ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
alias clean_tmp_docker_images='docker images | grep "^<none>" | tr -s ' ' | cut -d ' ' -f 3 | xargs docker rmi'
command -v thefuck >/dev/null 2>&1 && eval "$(thefuck --alias)"

# Editing
alias vimlog='vim -w ~/.vimlog'
alias nvimdiff='nvim -d'
alias nview='nvim -R'
alias nvimlog='nvim -w ~/.nvimlog'

# repeating
function multi() {
  local count=$(( $1 + 0 ))
  local command=""

  for arg in "${@:2}"; do
    command="${command} ${arg}"
  done

  while [ $count -gt 0 ]; do
    eval "${command}"
    count=$(( count - 1 ))
  done
}

# Encrypting
alias cipher='openssl rsautl -encrypt -pubin -inkey'
alias decipher='openssl rsautl -decrypt -inkey'

function quickedit() {
  local place_to_search="${2:-./}"
  local result="$(grep -m 1 --exclude "*~" --exclude-dir .git/ -rnF "${1}" ${place_to_search} | head -n 1 | cut -d: -f1,2)"

  [[ -z "${result}" ]] && echo "No match found for « ${1} »" && return 1

  local file="$(echo $result | cut -d: -f1)"
  local line="$(echo $result | cut -d: -f2)"

  ${EDITOR} "${file}" "+${line}"
}

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

# jump
JUMP_ALIAS="jp"
JUMP_DIRECTORIES=("${HOME}/dev" "${HOME}/dev/www")
JUMP_HOOK_AFTER='ls -FhlX --color=always --hide="*~"'
source "${ZSH_CONFIG_PATH}/jump.zsh"


# not always needed but fun
function colors_list() {
  local text="${1:-}"

  [ -n "${text}" ] && text=" ${text}"

  for i in {0..255}; do
    printf "\x1b[38;5;${i}m%03d${text}\e[0m\n" ${i}
  done
}

# some utils
function pdfshrink() {
  gs -sDEVICE=pdfwrite -dCompatibilityLEvel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dBATCH -dQUIET -sOutputFile="${2}" "${1}"
}
function pdfXshrink() {
  gs -sDEVICE=pdfwrite -dCompatibilityLEvel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dBATCH -dQUIET -sOutputFile="${2}" "${1}"
}

# steam is sometimes a bitch
alias steam_clean='find ~/.steam/root/ \( -name "libgcc_s.so*" -o -name "libstdc++.so*" -o -name "libxcb.so*" -o -name "libgpg-error.so*" \) -print -delete'
