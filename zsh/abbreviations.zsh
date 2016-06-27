typeset -Ag abbreviations

#local _pipe_char=$'\174'

abbreviations=(
  #"${_pipe_char}l"  '| less -R'
  'LS'  '| less -R'
  'GP'  '| grep -n'
  'AK'  '| awk'
  'WC'  '| wc'
)

expand-abbreviation() {
  local MATCH
  LBUFFER=${LBUFFER%%(#m)[_a-zA-Z0-9]#}
  LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
  zle self-insert
}

zle -N expand-abbreviation
bindkey " " expand-abbreviation
