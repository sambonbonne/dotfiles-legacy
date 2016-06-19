# Vi mode
bindkey -v
bindkey '^ ' vi-forward-blank-word


## When using C-Z, use fg if nothing to suspend

# C-Z command
ctrl-z-fg() {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}

# C-Z mapping
zle -N ctrl-z-fg
bindkey '^Z' ctrl-z-fg
