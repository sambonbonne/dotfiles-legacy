ZINIT_HOME="${HOME}/.cache/.zinit/bin"
ZINIT_MAIN="${ZINIT_HOME}/zinit.zsh"

if [ ! -f "${ZINIT_MAIN}" ]; then
  mkdir -p "${ZINIT_HOME}"
  git clone https://github.com/zdharma/zinit "${ZINIT_HOME}"
fi

source "${ZINIT_MAIN}"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit ice src"src"
zinit load "zsh-users/zsh-completions"

zinit load "zsh-users/zsh-autosuggestions"
bindkey '^[ ' autosuggest-accept

zinit load "hlissner/zsh-autopair"

export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
zinit load "zsh-users/zsh-syntax-highlighting"

zinit load "zsh-users/zsh-history-substring-search"
# in normal mode, up/down keys
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
# in vi mode, j/k keys
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

zinit load "chrissicool/zsh-256color"

zinit ice has"tmux"
zinit load "jreese/zsh-titles"

# # zplug "MichaelAquilina/zsh-auto-notify", if:"{ command -v notify-send ; } >/dev/null 2>&1"
# # export AUTO_NOTIFY_THRESHOLD=20
# # export AUTO_NOTIFY_TITLE="· %command → %exit_code ·"
# # export AUTO_NOTIFY_BODY="Duration: %elapsed seconds"
# zplug "marzocchi/zsh-notify", if:"{ command -v notify-send ; } >/dev/null 2>&1"
# #zstyle ':notify:*' blacklist-regex 'kak|nvim|vim'
# zstyle ':notify:*' enable-on-ssh yes
# zstyle ':notify:*' command-complete-timeout 20
# zstyle ':notify:*' error-title "(╯°□°)╯ ︵ ┻━┻"
# zstyle ':notify:*' success-title "(⌐■_■)"

zinit load "johnhamelink/env-zsh"

ZSH_COMMAND_TIME_MIN_SECONDS=15
ZSH_COMMAND_TIME_MSG="Execution time: %s sec"
ZSH_COMMAND_TIME_EXCLUDE=(time kak tmx tmux docker-compose)
zinit load "popstas/zsh-command-time"

zinit compinit

# configure some plugins after loading
export ZSH_AUTOSUGGEST_STRATEGY=("match_prev_cmd")
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=12'
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=14'
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=13'
