# When using C-Z, use fg if nothing to suspend

ctrl-z-fg() {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}

zle -N ctrl-z-fg
bindkey '^Z' ctrl-z-fg
