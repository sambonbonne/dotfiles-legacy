autoload -Uz compinit && compinit
autoload bashcompinit && bashcompinit

zstyle ':completion:*' menu select=2

# root path for sudo
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# don't complete the same thing twice
zstyle ':completion:*:*:(ls|rm|mv|cp|vi|vim|nvim|view|nview|vimdiff|nvimdiff):*' ignore-line true

# for editing completion ignore tmp files
zstyle ':completion:*:*:(vi|vim|nvim|view|nview):*:*files' ignored-patterns '*~|*.swp'

# some pattern for scripts
zstyle ':completion:*:*:sh:*:*files' file-patterns '*.(sh)'
zstyle ':completion:*:*:bash:*:*files' file-patterns '*.(sh|bash)'
zstyle ':completion:*:*:zsh:*:*files' file-patterns '*.(sh|zsh)'
zstyle ':completion:*:*:(node|nodejs):*:*files' file-patterns '*.(js|mjs)'
zstyle ':completion:*:*:php:*:*files' file-patterns '*.php'
zstyle ':completion:*:*:(python|python2|python3|py):*:*files' file-patterns '*.py'

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
