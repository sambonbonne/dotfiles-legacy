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
bindkey -v
# End of lines configured by zsh-newuser-install

zstyle :compinstall filename '/home/samuel/.zshrc'

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

bindkey "^E" zce
bindkey '^ ' vi-forward-blank-word
bindkey '^[ ' autosuggest-accept

# Load prompt
source "${ZSH_CONFIG_PATH}/prompt.zsh"

## Some alias, can belways usefull
source "${ZSH_CONFIG_PATH}/alias.zsh"

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
