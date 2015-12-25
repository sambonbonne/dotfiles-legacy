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

COMMAND_NOT_FOUND_FILE=/usr/share/doc/pkgfile/command-not-found.zsh
[[ -f $COMMAND_NOT_FOUND_FILE ]] && source $COMMAND_NOT_FOUND_FILE

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=4096
SAVEHIST=4096
setopt appendhistory autocd beep extendedglob nomatch
unsetopt notify
bindkey -v
# End of lines configured by zsh-newuser-install

zstyle :compinstall filename '/home/samuel/.zshrc'
autoload -Uz compinit && compinit

### My own configuration

## Completion is a basic
zstyle ':completion:*' menu select
setopt completealiases
setopt HIST_IGNORE_DUPS
bindkey '^[[Z' reverse-menu-complete

## Of course we want colors
autoload -U colors && colors

# Load prompt
source ~/.zsh/prompt.zsh

# ZGEN loading
ZGEN_INSTALL_DIR="${HOME}/.zsh/zgen"
[[ -f "${ZGEN_INSTALL_DIR}/zgen.zsh" ]] || git clone https://github.com/tarjoilija/zgen.git "${ZGEN_INSTALL_DIR}"
source "${ZGEN_INSTALL_DIR}/zgen.zsh"
if ! zgen saved; then
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load tarruda/zsh-autosuggestions

    zgen save
fi

# Enable autosuggestions automatically and prepare prompt
zle-line-init() {
    zle autosuggest-start
    zle-line-finish && zle reset-prompt
}
zle -N zle-line-init
bindkey '^ ' vi-forward-blank-word

## Some alias, can belways usefull
# Commands alias
alias ll='ls -FhlX --color=always --hide="*~"'
alias la='ls -AFhlX --color=always --hide="*~"'
alias search='grep -rnF --exclude "*~" --color=always'
alias nvimdiff='nvim -d'
alias zsh_history='mv ~/.zsh_history ~/.zsh_history_bad && strings ~/.zsh_history_bad > ~/.zsh_history && fc -R ~/.zsh_history && rm ~/.zsh_history_bad'
alias ports='netstat -pln'
command -v thefuck >/dev/null 2>&1 && eval "$(thefuck --alias)"

# python virtualenv facility
function venv() {
    #[[ "$VIRTUAL_ENV" == "" ]] && source "./$1/bin/activate" || deactivate
    if [[ "$VIRTUAL_ENV" == "" ]]; then
        [[ "$1" != "" ]] && source "./$1/bin/activate" || echo "Where is the env?"
    else
        deactivate || unset VIRTUAL_ENV
    fi
}

zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

eval $(dircolors ~/.dircolors)

# sometime I work on a mac ...
[[ "$(uname -s)" == "Darwin" ]] && source ~/.zsh/darwin || true # we put a "true" because we have a non-zero status if not in OS X
