# Build a prompt, POSIX style

export VIRTUAL_ENV_DISABLE_PROMPT=1 # we set it manually

test "${COLOR_BLACK}" = "" && export COLOR_BLACK=$(echo -en '\033[00;30m')
test "${COLOR_RED}" = "" && export COLOR_RED=$(echo -en '\033[00;31m')
test "${COLOR_GREEN}" = "" && export COLOR_GREEN=$(echo -en '\033[00;32m')
test "${COLOR_YELLOW}" = "" && export COLOR_YELLOW=$(echo -en '\033[00;33m')
test "${COLOR_BLUE}" = "" && export COLOR_BLUE=$(echo -en '\033[00;34m')
test "${COLOR_MAGENTA}" = "" && export COLOR_MAGENTA=$(echo -en '\033[00;35m')
test "${COLOR_CYAN}" = "" && export COLOR_CYAN=$(echo -en '\033[00;36m')
test "${COLOR_WHITE}" = "" && export COLOR_WHITE=$(echo -en '\033[01;37m')
test "${COLOR_RESET}" = "" && export COLOR_RESET=$(echo -en '\033[0m')

PROMPT_NBSP=$'\u00A0'
PROMPT_STATE_SEPARATOR=" ${COLOR_BLACK}❭${COLOR_RESET}${PROMPT_NBSP}"
PROMPT_USER="$(id -u -n)"
PROMPT_HOSTNAME="$(hostname -s)"

build_prompt() {
  last_status=$?

  test "${SHELL_LAST_STATUS}" != "" && last_status="${SHELL_LAST_STATUS}"

  # first line

  echo -n "${COLOR_BLACK}╭${COLOR_RESET} "

  echo -n "${COLOR_BLUE}${PROMPT_USER}${COLOR_RESET}"

  if [ "${SSH_CLIENT}" != "" ]; then
    echo -n "${PROMPT_STATE_SEPARATOR}${COLOR_CYAN}${PROMPT_HOSTNAME}${COLOR_RESET}"
  fi

  echo -n "${PROMPT_STATE_SEPARATOR}$(prompt_path)"

  git_state="$(prompt_git_state)"
  test "${git_state}" != "" && echo -n "${PROMPT_STATE_SEPARATOR}⍿${git_state}"

  test "${VIRTUAL_ENV}" != "" && echo -n "${PROMPT_STATE_SEPARATOR}⦚${COLOR_YELLOW}$(basename "${VIRTUAL_ENV}")${COLOR_RESET}"

  # second line

  printf "\n"
  echo -n "${COLOR_BLACK}╰${COLOR_RESET} "

  if [ "${last_status}" != "0" ]; then
    echo -n "${COLOR_MAGENTA}${last_status}${COLOR_RESET}${PROMPT_NBSP}"
  fi

  echo -n "$(prompt_end_indicator ${last_status}) "
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

  git_num_ahead="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
  git_num_behind="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"

  if [ "${git_num_ahead}" -gt 0 ]; then
    if [ "${git_num_behind}" -gt 0 ]; then
      git_state="⇅ ${git_state}"
    else
      git_state="↑ ${git_state}"
    fi
  elif [ "${git_num_behind}" -gt 0 ]; then
    git_state="↓ ${git_state}"
  fi

  echo -n "${git_color}${git_state}${COLOR_RESET}"
}

prompt_end_indicator() {
  last_status="${1}"

  end_indicator_color="${COLOR_YELLOW}"

  if [ "${KEYMAP}" = "vicmd" ]; then
    end_indicator_color="${COLOR_BLUE}"
  elif [ "${last_status}" != "0" ]; then
    end_indicator_color="${COLOR_RED}"
  else
    end_indicator_color="${COLOR_GREEN}"
  fi

  echo -n "${end_indicator_color}❯${COLOR_RESET}"
}
