## We want git informations
# Modify the colors and symbols in these variables as desired.
GIT_PROMPT_SYMBOL="%{$fg[white]%}✓%{$reset_color%}"
GIT_PROMPT_MODIFIED="%{$fg[yellow]%}±%{$reset_color%}"
GIT_PROMPT_STAGED="%{$fg[green]%}±%{$reset_color%}"
GIT_PROMPT_AHEAD=" %{$fg[blue]%}↑NUM%{$reset_color%}"
GIT_PROMPT_BEHIND=" %{$fg[magenta]%}↓NUM%{$reset_color%}"
GIT_PROMPT_MERGING=" %{$fg[red]%}⚡︎%{$reset_color%}"

# Show Git branch/tag, or name-rev if on detached head
function parse_git_branch() {
  (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}

# Show different symbols as appropriate for various Git repository states
# Compose this value via multiple conditional appends.
function parse_git_state() {
  local GIT_STATE=""

  if ! git diff --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MODIFIED
  fi

  if ! git diff --cached --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_STAGED
  fi

  local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
  if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MERGING
  fi

  local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_AHEAD" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}
  fi

  local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_BEHIND" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}
  fi

  if [[ -n $GIT_STATE ]]; then
    echo "$GIT_STATE"
  else
    echo "$GIT_PROMPT_SYMBOL"
  fi
}

# If inside a Git repository, print its branch and state
function git_prompt_string() {
  local git_where="$(parse_git_branch)"
  [ -n "$git_where" ] && echo " {$(parse_git_state) %{$reset_color%}%{$fg[cyan]%}${git_where#(refs/heads/|tags/)}%{$reset_color%}}"
}
