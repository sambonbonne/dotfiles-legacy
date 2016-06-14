## We want git informations
# Modify the colors and symbols in these variables as desired.
GIT_PROMPT_SYMBOL="%{$fg[white]%}✓%{$reset_color%}"
GIT_PROMPT_MODIFIED="%{$fg[yellow]%}±%{$reset_color%}"
GIT_PROMPT_STAGED="%{$fg[green]%}±%{$reset_color%}"
GIT_PROMPT_UNTRACKED="%{$fg[cyan]%}+%{$reset_color%}"
GIT_PROMPT_AHEAD=" %{$fg[blue]%}↑NUM%{$reset_color%}"
GIT_PROMPT_BEHIND=" %{$fg[magenta]%}↓NUM%{$reset_color%}"
GIT_PROMPT_MERGING=" %{$fg[red]%}⚡︎%{$reset_color%}"

# Show Git branch/tag, or name-rev if on detached head
function parse_git_branch() {
  (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}

# Show different symbols as appropriate for various Git repository states
# Compose this value via multiple conditional appends.
function parse_git_state_full() {
  local GIT_STATE=""
  local git_status="$(git status --porcelain 2> /dev/null)"

  if [[ "${git_status}" =~ ($'\n'|^).M ]]; then
    GIT_STATE="${GIT_STATE}${GIT_PROMPT_MODIFIED}"
  fi

  if [[ "${git_status}" =~ ($'\n'|^)A ]]; then
    GIT_STATE="${GIT_STATE}${GIT_PROMPT_STAGED}"
  fi

  if [[ $(\grep -c "^??" <<< "$git_status") -gt 0 ]]; then
    GIT_STATE="${GIT_STATE}${GIT_PROMPT_UNTRACKED}"
  fi

  local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
  if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
    GIT_STATE="${GIT_STATE}${GIT_PROMPT_MERGING}"
  fi

  local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_AHEAD" -gt 0 ]; then
    GIT_STATE="${GIT_STATE}${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}"
  fi

  local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_BEHIND" -gt 0 ]; then
    GIT_STATE="${GIT_STATE}${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}"
  fi

  if [[ -n $GIT_STATE ]]; then
    echo "${GIT_STATE}"
  else
    echo "${GIT_PROMPT_SYMBOL}"
  fi
}

function clean_branch_color() {
  local git_status="$(git status --porcelain 2> /dev/null)"
  local _color=''

  if [[ "${git_status}" =~ ($'\n'|^).M ]]; then
    _color="${_color}%{$fg_no_bold[yellow]%}"
  elif [[ "${git_status}" =~ ($'\n'|^)A ]]; then
    _color="${_color}%{$fg_no_bold[green]%}"
  fi

  [[ -z "${_color}" ]] && _color="%{$fg_no_bold[blue]%}"

  echo -n "${_color}"
}

# If inside a Git repository, print its branch and state
function git_prompt_string() {
  local git_where="$(parse_git_branch)"
  git_where="${git_where#(refs/heads/|tags/)}"
  if [ -n "${git_where}" ]; then
    if [[ ${COLUMNS} -gt 90 ]]; then
      echo " {$(parse_git_state_full) %{$reset_color%}%{$fg[cyan]%}${git_where}%{$reset_color%}}"
    elif [[ ${COLUMNS} -gt 60 ]]; then
      echo " %{$reset_color%}$(clean_branch_color)${git_where}%{$reset_color%}"
    else
      echo " %{$reset_color%}$(clean_branch_color)${git_where[1,10]}%{$reset_color%}"
    fi
  fi
}
