ZPLUG_HOME="${HOME}/.zsh/zplug"
ZPLUG_MAIN="${ZPLUG_HOME}/init.zsh"
ZPLUG_CACHE_DIR="${ZPLUG_HOME}/cache"

installPluginManager() {
	mkdir -p "${ZPLUG_HOME}"
	git clone https://github.com/zplug/zplug "${ZPLUG_HOME}"
	source "${ZPLUG_MAIN}"
}

if [[ -f "${ZPLUG_MAIN}" ]]; then
  source "${ZPLUG_MAIN}"
else
  installPluginManager
fi

zstyle :zplug:tag depth 10
zstyle ":zplug:config:setopt" only_subshell extended_glob


zplug "zplug/zplug"

zplug "zsh-users/zsh-completions"

zplug "zsh-users/zsh-autosuggestions"
bindkey '^[ ' autosuggest-accept

zplug "zsh-users/zsh-history-substring-search", defer:3
# in normal mode, up/down keys
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
# in vi mode, j/k keys
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug "hlissner/zsh-autopair", defer:2

zplug "chrissicool/zsh-256color"

zplug "sharat87/zsh-vim-mode"

zplug "hchbaw/zce.zsh"
bindkey "^F" zce

zplug "jreese/zsh-titles", if:"which tmux"

zplug "MichaelAquilina/zsh-auto-notify", if:"{ command -v notify-send ; } >/dev/null 2>&1"
export AUTO_NOTIFY_THRESHOLD=20
export AUTO_NOTIFY_TITLE="· %command → %exit_code ·"
export AUTO_NOTIFY_BODY="Duration: %elapsed seconds"

zplug "Tarrasch/zsh-bd"

zplug "Seinh/git-prune", if:"which git"

zplug "johnhamelink/env-zsh"


if ! zplug check; then
  zplug install
fi

zplug load

# configure some plugins after loading
export ZSH_AUTOSUGGEST_STRATEGY=("match_prev_cmd")
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=12'
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=14'
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=13'
