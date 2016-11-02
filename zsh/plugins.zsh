ZPLUG_HOME="${HOME}/.zsh/zplug"
ZPLUG_MAIN="${ZPLUG_HOME}/init.zsh"

installPluginManager() {
	mkdir -p "${ZPLUG_HOME}"
	git clone https://github.com/b4b4r07/zplug "${ZPLUG_HOME}"
	source "${ZPLUG_MAIN}"
	zplug update --self
}

if [[ -f "${ZPLUG_MAIN}" ]]; then
  source "${ZPLUG_MAIN}"
else
  installPluginManager
fi

zstyle :zplug:tag depth 10
zstyle ":zplug:config:setopt" only_subshell extended_glob


zplug "zplug/zplug"

zplug "knu/z", use:z.sh, nice:10
zplug "zsh-users/zsh-completions"

export ZSH_AUTOSUGGEST_STRATEGY="match_prev_cmd"
#export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=7'
zplug "zsh-users/zsh-autosuggestions"
bindkey '^[ ' autosuggest-accept

# set some colors
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=2'
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=1'
zplug "zsh-users/zsh-history-substring-search", nice:12
# in normal mode, up/down keys
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
# in vi mode, j/k keys
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
zplug "zsh-users/zsh-syntax-highlighting", nice:11

zplug "hlissner/zsh-autopair", nice:10

zplug "chrissicool/zsh-256color"

zplug "sharat87/zsh-vim-mode"

zplug "hchbaw/zce.zsh"
#bindkey "^E" zce
bindkey "^F" zce

zplug "jreese/zsh-titles", if:"which tmux"

zplug "marzocchi/zsh-notify", if:"which notify-send"
zstyle ':notify:*' error-title "(╯°□°)╯︵┻━┻"
zstyle ':notify:*' success-title "(⌐■_■)"
zstyle ':notify:*' command-complete-timeout 20

zplug "Tarrasch/zsh-bd"

zplug "Seinh/git-prune", if:"which git"


zplug check --verbose || zplug install
zplug load
