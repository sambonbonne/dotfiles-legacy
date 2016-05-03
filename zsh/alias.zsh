# Commands alias
alias ll='ls -FhlX --color=always --hide="*~"'
alias la='ls -AFhlX --color=always --hide="*~"'
alias search='grep -rnF --exclude "*~" --color=always'
alias zsh_history='mv ~/.zsh_history ~/.zsh_history_bad && strings ~/.zsh_history_bad > ~/.zsh_history && fc -R ~/.zsh_history && rm ~/.zsh_history_bad'
alias ports='netstat -pln'
command -v thefuck >/dev/null 2>&1 && eval "$(thefuck --alias)"

# Editing
alias vimlog='vim -w ~/.vimlog'
alias nvimdiff='nvim -d'
alias nview='nvim -R'
alias nvimlog='nvim -w ~/.nvimlog'

# Paging
alias nless='nvim -R -c "nnoremap q :q!<Enter>" -'
alias vless='vim -R -c "nnoremap q :q!<Enter>" -'

# Specific aliases
alias vim_clean_swp='find ./ -type f -name "\.*sw[klmnop]" -delete'

# Extensions aliases
alias -s bash=bash
alias -s sh=bash
alias -s json=nvim
