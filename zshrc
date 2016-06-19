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

zstyle :compinstall filename "${HOME}/.zshrc"

### My own configuration
ZSH_CONFIG_PATH="${HOME}/.zsh"

## Completion is a basic
source "${ZSH_CONFIG_PATH}/completion.zsh"

## autocorrect is really good
setopt correct

## Of course we want colors
autoload -U colors && colors

# (shared) history
HISTFILE=~/.zsh_history
HISTSIZE=4096
SAVEHIST=4096
setopt inc_append_history
setopt share_history

# plugins, something we love
source "${ZSH_CONFIG_PATH}/plugins.zsh"

# Load prompt
source "${ZSH_CONFIG_PATH}/prompt.zsh"

# Some alias, can belways usefull
source "${ZSH_CONFIG_PATH}/alias.zsh"

# And some mapping
source "${ZSH_CONFIG_PATH}/map.zsh"

eval $(dircolors ~/.dircolors)

# sometime I work on a mac ...
[[ "$(uname -s)" == "Darwin" ]] && source "${ZSH_CONFIG_PATH}/darwin"

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
