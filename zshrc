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
zstyle ':completion:*' menu select=2
setopt completealiases
setopt HIST_IGNORE_DUPS
bindkey '^[[Z' reverse-menu-complete

## Of course we want colors
autoload -U colors && colors

# plugins, something we love
source ~/.zsh/plugins.zsh

bindkey "^E" zce
bindkey '^ ' vi-forward-blank-word
bindkey '^[ ' autosuggest-accept

# Prepare prompt
function zle-line-init() {
    zle-line-finish && zle reset-prompt
}
zle -N zle-line-init

# Load prompt
source ~/.zsh/prompt.zsh

## Some alias, can belways usefull
# Commands alias
alias ll='ls -FhlX --color=always --hide="*~"'
alias la='ls -AFhlX --color=always --hide="*~"'
alias search='grep -rnF --exclude "*~" --color=always'
alias zsh_history='mv ~/.zsh_history ~/.zsh_history_bad && strings ~/.zsh_history_bad > ~/.zsh_history && fc -R ~/.zsh_history && rm ~/.zsh_history_bad'
alias ports='netstat -pln'
command -v thefuck >/dev/null 2>&1 && eval "$(thefuck --alias)"

alias vim_clean_swp='find ./ -type f -name "\.*sw[klmnop]" -delete'
alias vimlog='vim -w ~/.vimlog'
alias nvimdiff='nvim -d'
alias nview='nvim -R'
alias nvimlog='nvim -w ~/.nvimlog'

tmx() {
    if [[ -z "$1" ]]; then
		tmux -2 list-sessions -F "#{?session_attached,$fg[cyan],$fg[white]}#{session_name}$fg[white] - #{session_windows} window(s)"
    elif tmux has -t "$1" 2>&1 > /dev/null; then
        [ -z $TMUX ] && tmux -2 attach -t "$1" || tmux -2 switch -t "$1"
    else
        TMUX="" tmux -2 new-session -s "$1" -d
        [ -z $TMUX ] && tmux -2 attach -t "$1" || tmux -2 switch -t "$1"
    fi
}
function __tmux_sessions() {
    local expl
    local -a sessions

    sessions=( ${${(f)"$(command tmux list-sessions)"}/:[ $'\t']##/:} )
    _describe -t sessions 'sessions' sessions "$@"
}
compdef __tmux_sessions tmx

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

zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

eval $(dircolors ~/.dircolors)

# sometime I work on a mac ...
[[ "$(uname -s)" == "Darwin" ]] && source ~/.zsh/darwin || true # we put a "true" because we have a non-zero status if not in OS X

# eventually start tmux
if [[ $- == *i* ]] && [ -z $TMUX ] && command -v tmux >/dev/null 2>&1 ; then
    tmux ls >/dev/null 2>&1
    if [ $? -ne 0 ] ; then
        tmux -2 new -s default
    else
        echo "\n$fg[blue]Some tmux sessions available$fg[white]"
        tmux -2 ls | cut -d ":" -f 1
        echo ""
    fi
fi
