### Oh yeah my prompt
autoload -U promptinit && promptinit
setopt PROMPT_SUBST

## Left prompt

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


## Right prompt
source ~/.zsh/git
function rprompt_cmd() {
    echo "[%{$fg_no_bold[white]%}%T%{$reset_color%} %(?.%{$fg_no_bold[green]%}.%{$fg_no_bold[red]%})%?%{$reset_color%}]%(1j. (%{$fg_no_bold[magenta]%}%j%{$reset_color%}J%).)$(git_prompt_string)"
}

ASYNC_RPROMPT_PROC=0
_async_rprompt_tmp_file="${HOME}/.zsh/.tmp_rprompt"
function precmd() {
    function async() {
        printf "%s" "$(rprompt_cmd)" > "${_async_rprompt_tmp_file}"
        kill -s USR1 $$
    }

    if [[ "${ASYNC_RPROMPT_PROC}" != 0 ]]; then
        kill -s HUP $ASYNC_RPROMPT_PROC >/dev/null 2>&1 || :
    fi

    async &!
    ASYNC_RPROMPT_PROC=$!
}

function TRAPUSR1() {
    RPROMPT="$(cat ${_async_rprompt_tmp_file})"
    ASYNC_RPROMPT_PROC=0
    zle && zle reset-prompt
}
