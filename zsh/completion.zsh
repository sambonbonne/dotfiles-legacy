autoload -Uz compinit && compinit
autoload bashcompinit && bashcompinit

# prevent removing space after completion, for example when piping
ZLE_REMOVE_SUFFIX_CHARS=""

zstyle ':completion:*' menu select=2

zstyle ':completion:*' squeeze-slashes true

# root path for sudo
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# don't complete the same thing twice
#zstyle ':completion:*:*:(ls|rm|mv|cp|vi|vim|nvim|view|nview|vimdiff|nvimdiff):*' ignore-line true

# for editing completion ignore tmp files
zstyle ':completion:*:*:(vi|vim|nvim|view|nview):*:*files' ignored-patterns '*~|*.swp'

# some pattern for scripts
zstyle ':completion:*:*:sh:*:*files' file-patterns '*.(sh)'
zstyle ':completion:*:*:bash:*:*files' file-patterns '*.(sh|bash)'
zstyle ':completion:*:*:zsh:*:*files' file-patterns '*.(sh|zsh)'
zstyle ':completion:*:*:(node|nodejs):*:*files' file-patterns '*.(js|mjs)'
zstyle ':completion:*:*:php:*:*files' file-patterns '*.php'
zstyle ':completion:*:*:(python|python2|python3|py):*:*files' file-patterns '*.py'

# completion sections
#zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format $'\e[00;36m%d\033[0m'
#zstyle ':completion:*:messages' format $'\e[00;34m%d\033[0m'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true

# some colors
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:commands' list-colors '=*=32'
zstyle ':completion:*:builtins' list-colors '=*=32'
zstyle ':completion:*:functions' list-colors '=*=33'
zstyle ':completion:*:aliases' list-colors '=*=33'
zstyle ':completion:*:reserved-words' list-colors '=*=31'
zstyle ':completion:*:parameters' list-colors '=*=31'
#zstyle ':completion:*:options' list-colors '=^(-- *)=37'

zstyle ':completion:*:*:kill:*' list-colors '=(#b) #([0-9]#)*( *[a-z])*=34=31=33'

# explicitly say nothing found
zstyle ':completion:*:warnings' format 'No matches for: %d'

# cache can be good
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "/tmp/zsh_completion_cache"

setopt completealiases
setopt HIST_IGNORE_DUPS

bindkey '^I' expand-or-complete-prefix
bindkey '^[[Z' reverse-menu-complete
which stack >/dev/null 2>&1 && eval "$(stack --bash-completion-script stack)"

which scw 2&>1 >/dev/null && eval "$(scw autocomplete script shell=zsh)"
