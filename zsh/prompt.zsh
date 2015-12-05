### Oh yeah my prompt
autoload -U promptinit && promptinit
setopt PROMPT_SUBST

local virtualenv_prompt_parse='$([[ "$VIRTUAL_ENV" != "" ]] && echo " $(basename $VIRTUAL_ENV)")'

local nbsp=$'\u00A0'
if [[ -n "$SSH_CLIENT" || "$LOGNAME" == "root" ]]; then
    PROMPT="%{$fg_no_bold[cyan]%}%n%{$reset_color%}@%{$fg_no_bold[blue]%}%m%{$reset_color%}:%{$fg_no_bold[yellow]%}%~%{$fg_no_bold[red]%}${virtualenv_prompt_parse}%{$reset_color%}"
else
    #PROMPT="%{$fg_no_bold[blue]%}%~ %(?.%{$fg_no_bold[green]%}→.%{$fg_bold[red]%}!)%{$reset_color%}$nbsp"
    PROMPT="%{$fg_no_bold[blue]%}%~%{$fg_no_bold[red]%}${virtualenv_prompt_parse}%{$reset_color%}"
fi
BASE_PROMPT="$PROMPT"

source ~/.zsh/git
local git_prompt_parse='$(git_prompt_string)'
RPROMPT="[%{$fg_no_bold[white]%}%T%{$reset_color%} %(?.%{$fg_no_bold[green]%}.%{$fg_no_bold[red]%})%?%{$reset_color%}]%(1j. (%{$fg_no_bold[magenta]%}%j%{$reset_color%}J%).)${git_prompt_parse}"

function zle-line-finish {
    PROMPT="$BASE_PROMPT %(?.%{$fg_no_bold[green]%}→.%{$fg_bold[red]%}!)%{$reset_color%}$nbsp"
}
zle -N zle-line-finish

function zle-keymap-select {
    case "$KEYMAP" in
        vicmd)
            PROMPT="$BASE_PROMPT %{$fg_no_bold[yellow]%}?%{$reset_color%} "
            ;;
        main|viins)
            zle-line-finish
            ;;
    esac
    zle reset-prompt
}
zle -N zle-keymap-select
