# Global variables
if [ -f /etc/zsh/zprofile ]; then
  source /etc/zsh/zprofile
fi
if [ -f ~/.profile ]; then
  source ~/.profile
fi

if [[ $TERM == xterm-termite && -f /etc/profile.d/vte.sh ]]; then
  . /etc/profile.d/vte.sh
  __vte_osc7
fi

COMMAND_NOT_FOUND_FILE="/usr/share/doc/pkgfile/command-not-found.zsh"
[[ -f "${COMMAND_NOT_FOUND_FILE}" ]] && source $COMMAND_NOT_FOUND_FILE

# Lines configured by zsh-newuser-install
setopt appendhistory autocd beep extendedglob nomatch
unsetopt notify
# End of lines configured by zsh-newuser-install

zstyle :compinstall filename '/home/samuel/.zshrc'

### My own configuration
ZSH_CONFIG_PATH="${HOME}/.zsh"
function load_zsh_config() {
  source "${ZSH_CONFIG_PATH}/${1}.zsh"
}
load_zsh_config "detect_os"

## Completion is a basic
load_zsh_config "completion"

## autocorrect is really good
setopt correct

## Of course we want colors
autoload -U colors && colors

# (shared) history
HISTFILE=~/.zsh_history
HISTSIZE=8192
SAVEHIST=16384
setopt inc_append_history
setopt share_history

# plugins, something we love
load_zsh_config "plugins"

# Load prompt
load_zsh_config "prompt"

## Some alias, can belways usefull
load_zsh_config "alias"

## And some mapping
load_zsh_config "map"

## Don't forget abbreviations
load_zsh_config "abbreviations"

eval $(dircolors ~/.dircolors)

# sometime I work on a mac ...
is_on_darwin && load_zsh_config "darwin"

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

# If we have custom configuration
_custom_configuration_file="${ZSH_CONFIG_PATH}/custom.zsh"
[[ -f "${_custom_configuration_file}" ]] && source "${_custom_configuration_file}"
