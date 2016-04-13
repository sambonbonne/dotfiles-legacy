### Oh yeah my prompt
autoload -U promptinit && promptinit
setopt PROMPT_SUBST

local virtualenv_prompt_parse='$([[ "${VIRTUAL_ENV}" != "" ]] && echo " $(basename ${VIRTUAL_ENV})")'

PROMPT=""

local _default_username="samuel"
if [[ "${LOGNAME}" != "${USER}" || "${LOGNAME}" != "${_default_username}" || "${USER}" != "${_default_username}" ]] ; then
	PROMPT="${PROMPT}%{$fg_no_bold[cyan]%}%n%{$reset_color%}"
fi
unset _default_username

if [[ -n "${SSH_CLIENT}" ]] ; then
	[ -n "${PROMPT}" ] && PROMPT="${PROMPT}@"
	PROMPT="${PROMPT}%{$fg_no_bold[blue]%}%M%{$reset_color%}"
fi

# no SSH nor different username : take a really light prompt
[ -z "${PROMPT}" ] && PROMPT="%{$fg_no_bold[blue]%}%~"

PROMPT="${PROMPT} %{$fg_no_bold[yellow]%}%~%{$fg_no_bold[red]%}${virtualenv_prompt_parse}%{$reset_color%}"
BASE_PROMPT="${PROMPT}"

# right prompt
source ~/.zsh/git
local git_prompt_parse='$(git_prompt_string)'
RPROMPT="[%{$fg_no_bold[white]%}%T%{$reset_color%} %(?.%{$fg_no_bold[green]%}.%{$fg_no_bold[red]%})%?%{$reset_color%}]%(1j. (%{$fg_no_bold[magenta]%}%j%{$reset_color%}J%).)${git_prompt_parse}"

# current vi mode and last status
function zle-line-finish zle-keymap-select {
    PROMPT="${BASE_PROMPT} "

	local _nbsp=$'\u00A0'
    case "${KEYMAP}" in
        vicmd)
            PROMPT="${PROMPT}%{$fg_no_bold[yellow]%}?"
            ;;
        *)
	        PROMPT="${PROMPT}%(?.%{$fg_no_bold[green]%}→.%{$fg_bold[red]%}!)"
            ;;
    esac

	PROMPT="${PROMPT}%{$reset_color%}${_nbsp}"

	zle && zle reset-prompt
}
zle -N zle-line-finish
zle -N zle-keymap-select
zle-line-finish
