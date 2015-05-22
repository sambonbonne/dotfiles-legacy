# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=2048
SAVEHIST=4096
setopt appendhistory autocd beep extendedglob nomatch
unsetopt notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/samuel/.zshrc'

autoload -Uz compinit && compinit
# End of lines added by compinstall

### My own configuration
export PATH=$HOME/.npm/bin:$PATH
export EDITOR=/usr/bin/vim

# Fish-like syntax highlighting (available in AUR for Arch)
SYNTAX_HIGHLIGHT_FILE=/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
if [[ -a $SYNTAX_HIGHLIGHT_FILE ]]; then
    source $SYNTAX_HIGHLIGHT_FILE
fi

## Completion is a basic
zstyle ':completion:*' menu select
setopt completealiases
setopt HIST_IGNORE_DUPS

## Of course we want colors
autoload -U colors && colors

## Some alias, can belways usefull
# Global alias
# Commands alias
alias ll='ls -FhlX --color=always --hide="*~"'
alias la='ls -AFhlX --color=always --hide="*~"'
alias search='grep -rnF --exclude "*~" --color=always'
alias supwifi='curl "1.1.3.1/reg.php" -d "url=E2B8F3578D88E9E36CD7BB15C0C60E8AC72C51875E24&username=denis_s&password=FV7h0ZF8"'

# vim (vundle) function
function vundle() {
    if [ -z "$1" ] || [ $1 = "help" ]; then
        echo "Install, update or clean Vundle plugins.\n\nUsage: vundle <operation>\nOperations:"
        echo "\tinstall\tInstall plugins"
        echo "\tupdate\tUpdate plugins"
        echo "\tclean\tClean plugins"
    else
        if [ $1 = "install" ]; then
            vim +PluginInstall +qall
        elif [ $1 = "update" ]; then
            vim +PluginUpdate +qall
        elif [ $1 = "clean" ]; then
            vim +PluginClean +qall
        else
            echo "Unknown operation $1."
        fi
    fi
}

### Oh yeah my prompt
autoload -U promptinit && promptinit
source ~/.zsh/git

setopt PROMPT_SUBST
local prompt_always_parse='$(git_prompt_string)'
PROMPT="%{$fg_no_bold[cyan]%}%n%{$reset_color%}@%{$fg_no_bold[blue]%}%m%{$reset_color%}:%{$fg_no_bold[yellow]%}%~ %{$fg_no_bold[white]%}>%{$reset_color%} "
RPROMPT="[%{$fg_no_bold[white]%}%T%{$reset_color%} %(?.%{$fg_no_bold[green]%}.%{$fg_no_bold[red]%})%?%{$reset_color%}]%(1j. (%{$fg_no_bold[magenta]%}%j%{$reset_color%}J%).)${prompt_always_parse}"

zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
