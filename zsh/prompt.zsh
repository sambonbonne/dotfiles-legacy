autoload -U promptinit && promptinit
setopt PROMPT_SUBST

PROMPT='$(zsh_build_prompt)'
RPROMPT=""

# this function is required
# because if we don't use %{%}, ZSH will break completion
# as escape codes in PROMPT are counted as a char when completing
function zsh_build_prompt() {
  SHELL_LAST_STATUS=$?

  COLOR_BLACK="%{$fg_no_bold[black]%}"
  COLOR_RED="%{$fg_no_bold[red]%}"
  COLOR_GREEN="%{$fg_no_bold[green]%}"
  COLOR_YELLOW="%{$fg_no_bold[yellow]%}"
  COLOR_BLUE="%{$fg_no_bold[blue]%}"
  COLOR_MAGENTA="%{$fg_no_bold[magenta]%}"
  COLOR_CYAN="%{$fg_no_bold[cyan]%}"
  COLOR_WHITE="%{$fg_no_bold[white]%}"
  COLOR_RESET="%{$reset_color%}"

  build_prompt
}
