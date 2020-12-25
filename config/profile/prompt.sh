# Build a prompt, POSIX style

COLOR_BLACK=$(echo -en '\033[00;30m')
COLOR_RED=$(echo -en '\033[00;31m')
COLOR_GREEN=$(echo -en '\033[00;32m')
COLOR_YELLOW=$(echo -en '\033[00;33m')
COLOR_BLUE=$(echo -en '\033[00;34m')
COLOR_MAGENTA=$(echo -en '\033[00;35m')
COLOR_PURPLE=$(echo -en '\033[00;35m')
COLOR_CYAN=$(echo -en '\033[00;36m')
COLOR_LIGHTGRAY=$(echo -en '\033[00;37m')
COLOR_LRED=$(echo -en '\033[01;31m')
COLOR_LGREEN=$(echo -en '\033[01;32m')
COLOR_LYELLOW=$(echo -en '\033[01;33m')
COLOR_LBLUE=$(echo -en '\033[01;34m')
COLOR_LMAGENTA=$(echo -en '\033[01;35m')
COLOR_LPURPLE=$(echo -en '\033[01;35m')
COLOR_LCYAN=$(echo -en '\033[01;36m')
COLOR_WHITE=$(echo -en '\033[01;37m')
COLOR_RESET=$(echo -en '\033[0m')

FONT_BOLD=$(tput bold)
FONT_NORMAL=$(tput sgr0)

PROMPT_NBSP=$'\u00A0'
PROMPT_STATE_SEPARATOR=" ${COLOR_BLACK}❭${COLOR_RESET}${PROMPT_NBSP}"
PROMPT_USER="$(id -u -n)"
PROMPT_HOSTNAME="$(hostname -s)"

function build_prompt() {
  last_status=$?

  test "${SHELL_LAST_STATUS}" != "" && last_status="${SHELL_LAST_STATUS}"

  # first line

  printf "${COLOR_BLACK}╭${COLOR_RESET} "

  printf "${COLOR_BLUE}${PROMPT_USER}${COLOR_RESET}"

  if [ "${SSH_CLIENT}" != "" ]; then
    printf "${PROMPT_STATE_SEPARATOR}${COLOR_CYAN}${PROMPT_HOSTNAME}${COLOR_RESET}"
  fi

  printf "${PROMPT_STATE_SEPARATOR}$(prompt_path)"

  git_state="$(prompt_git_state)"
  test "${git_state}" != "" && printf "${PROMPT_STATE_SEPARATOR}${git_state}"

  # second line

  printf "\n${COLOR_BLACK}╰${COLOR_RESET} "

  if [ "${last_status}" != "0" ]; then
    printf "${COLOR_MAGENTA}${last_status}${COLOR_RESET}${PROMPT_NBSP}"
  fi

  printf "$(prompt_end_indicator ${last_status}) "
}

prompt_path() {
  pwd -L | sed "s#$(getent passwd sam | cut -d ':' -f 6)#~#g"
}

prompt_git_state() {
  git_state="$(echo $(git symbolic-ref -q HEAD 2> /dev/null \
    || git name-rev --name-only --no-undefined --always HEAD 2> /dev/null) \
    | sed -e 's#refs/heads/##' | sed -e 's#tags/##')"

  test "${git_state}" = "" && return 0

  git_dir="$(git rev-parse --git-dir 2> /dev/null)"
  git_status="$(git status --porcelain 2> /dev/null)"
  git_color="${COLOR_CYAN}"

  if [ -r "${git_dir}/MERGE_HEAD" ]; then
    git_color="${COLOR_RED}"
  elif git status --porcelain 2> /dev/null | tr -d ' ' | grep -q '^M' 2>&1 >/dev/null; then
    git_color="${COLOR_YELLOW}"
  else
    git_color="${COLOR_GREEN}"
  fi

  printf "${git_color}${git_state}${COLOR_RESET}"
}

function prompt_end_indicator() {
  last_status="${1}"

  end_indicator_color="${COLOR_YELLOW}"

  if [ "${KEYMAP}" = "vicmd" ]; then
    end_indicator_color="${COLOR_BLUE}"
  elif [ "${last_status}" != "0" ]; then
    end_indicator_color="${COLOR_RED}"
  else
    end_indicator_color="${COLOR_GREEN}"
  fi

  printf "${end_indicator_color}❯${COLOR_RESET}"
}








