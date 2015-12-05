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
HISTSIZE=2048
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

# ZGEN loading
ZGEN_INSTALL_DIR="${HOME}/.zsh/zgen"
[[ -f "${ZGEN_INSTALL_DIR}/zgen.zsh" ]] || git clone https://github.com/tarjoilija/zgen.git "${ZGEN_INSTALL_DIR}"
source "${ZGEN_INSTALL_DIR}/zgen.zsh"
if ! zgen saved; then
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load tarruda/zsh-autosuggestions

    zgen save
fi

## Some alias, can belways usefull
# Commands alias
alias ll='ls -FhlX --color=always --hide="*~"'
alias la='ls -AFhlX --color=always --hide="*~"'
alias search='grep -rnF --exclude "*~" --color=always'
alias zsh_history='mv ~/.zsh_history ~/.zsh_history_bad && strings ~/.zsh_history_bad > ~/.zsh_history && fc -R ~/.zsh_history && rm ~/.zsh_history_bad'
alias ports='netstat -pln'
alias fuck="thefuck" # fuck is thefuck in arch :/

### Oh yeah my prompt
autoload -U promptinit && promptinit
setopt PROMPT_SUBST

local nbsp=$'\u00A0'
if [[ -n "$SSH_CLIENT" || "$LOGNAME" == "root" ]]; then
    PROMPT="%{$fg_no_bold[cyan]%}%n%{$reset_color%}@%{$fg_no_bold[blue]%}%m%{$reset_color%}:%{$fg_no_bold[yellow]%}%~ %{$fg_no_bold[white]%}→%{$reset_color%}$nbsp"
else
    PROMPT="%{$fg_no_bold[blue]%}%~ %(?.%{$fg_no_bold[green]%}.%{$fg_bold[red]%})→%{$reset_color%}$nbsp"
fi

source ~/.zsh/git
local prompt_always_parse='$(git_prompt_string)'
RPROMPT="[%{$fg_no_bold[white]%}%T%{$reset_color%} %(?.%{$fg_no_bold[green]%}.%{$fg_no_bold[red]%})%?%{$reset_color%}]%(1j. (%{$fg_no_bold[magenta]%}%j%{$reset_color%}J%).)${prompt_always_parse}"

zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

eval $(dircolors ~/.dircolors)

# sometime I work on a mac ...
[[ "$(uname -s)" == "Darwin" ]] && source ~/.zsh/darwin || true # we put a "true" because we have a non-zero status in not in OS X
