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

# ZGEN loading
ZGEN_INSTALL_DIR="${HOME}/.zsh/zgen"
[[ -f "${ZGEN_INSTALL_DIR}/zgen.zsh" ]] || git clone https://github.com/tarjoilija/zgen.git "${ZGEN_INSTALL_DIR}"
source "${ZGEN_INSTALL_DIR}/zgen.zsh"
if ! zgen saved; then
    zgen load tarruda/zsh-autosuggestions
    zgen load zsh-users/zsh-syntax-highlighting

    zgen load chrissicool/zsh-256color
    zgen load sharat87/zsh-vim-mode
    zgen load jreese/zsh-titles

    zgen load marzocchi/zsh-notify

    zgen load Tarrasch/zsh-bd
    zgen load voronkovich/gitignore.plugin.zsh

    zgen load akoenig/gulp.plugin.zsh
    zgen load zsh-users/zsh-completions

    zgen save
fi

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
alias nvimdiff='nvim -d'
alias zsh_history='mv ~/.zsh_history ~/.zsh_history_bad && strings ~/.zsh_history_bad > ~/.zsh_history && fc -R ~/.zsh_history && rm ~/.zsh_history_bad'
alias ports='netstat -pln'
command -v thefuck >/dev/null 2>&1 && eval "$(thefuck --alias)"

alias tnew="tmux -2 new -s" && compdef _tmux tnew
alias tattach="tmux -2 attach -t"  && compdef _tmux tattach

alias binstean="bmake install clean; bmake clean-depends"

# python virtualenv facility
function venv() {
    if [[ "$VIRTUAL_ENV" == "" ]]; then
        [[ "$1" != "" ]] && source "./$1/bin/activate" || echo "Where is the env?"
    elif [[ "$1" == "update" ]]; then
        pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
    else
        deactivate || unset VIRTUAL_ENV
    fi
}

zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

eval $(dircolors ~/.dircolors)

# sometime I work on a mac ...
[[ "$(uname -s)" == "Darwin" ]] && source ~/.zsh/darwin || true # we put a "true" because we have a non-zero status if not in OS X

# eventually start tmux
if [ -z $TMUX ] && command -v tmux >/dev/null 2>&1 ; then
    tmux ls >/dev/null 2>&1
    if [ $? -ne 0 ] ; then
        tmux -2
    else
        echo "\n$fg[blue]Some tmux sessions available$fg[white]"
        tmux ls
        echo ""
    fi
fi
