autoload -Uz compinit && compinit
autoload bashcompinit && bashcompinit

zstyle ':completion:*' menu select=2

# root path for sudo
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# don't complete the same thing twice
zstyle ':completion:*:*:(ls|rm|mv|cp|vi|vim|nvim):*' ignore-line true

# for file editing, ignore tmp
zstyle ':completion:*:*:(vi|vim|nvim):*:*files' ignored-patterns '.?*(~|.swp)'

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
