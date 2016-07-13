ZPLUG_HOME="${HOME}/.zsh/zplug"
ZPLUG_MAIN="${ZPLUG_HOME}/zplug"

installPluginManager() {
	mkdir -p "${ZPLUG_HOME}"
	git clone https://github.com/b4b4r07/zplug "${ZPLUG_HOME}"
	source "${ZPLUG_MAIN}"
	zplug update --self
}

[[ -f "${ZPLUG_MAIN}" ]] && source "${ZPLUG_MAIN}" || installPluginManager

ZPLUG_CLONE_DEPTH=10


zplug "zplug/zplug"

zplug "zsh-users/zsh-completions"

zplug "zsh-users/zsh-autosuggestions"
bindkey '^[ ' autosuggest-accept

zplug "zsh-users/zsh-history-substring-search", nice:12
# in normal mode, up/down keys
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
# in vi mode, j/k keys
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
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

zplug "akoenig/gulp.plugin.zsh", if:"which gulp"

zplug "Seinh/git-prune", if:"which git"


zplug check --verbose || zplug install
zplug load
