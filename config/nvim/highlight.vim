let s:custom_colors = {
      \ 'darkred':    052,
      \ 'darkgreen':  023,
      \ 'darkyellow': 130,
      \ 'lightred':    203,
      \ 'lightgreen':  150,
      \ 'lightyellow': 221,
      \ }

let g:statusline_mode_colors = {
      \   'normal': {
      \     'ctermbg': 23,
      \     'guibg':   "green"
      \   },
      \   'insert': {
      \     'ctermbg': 52,
      \     'guibg':   "red"
      \   },
      \   'replace': {
      \     'ctermbg': 130,
      \     'guibg':   "yellow"
      \   }
      \ }

function! g:Colorize(group, colors)
  let l:command = 'highlight ' . a:group

  for l:part in [ 'ctermbg', 'ctermfg', 'guibg', 'guifg' ]
    if has_key(a:colors, l:part)
      let l:command .= ' ' . l:part . '=' . a:colors[l:part]
    endif
  endfor

  exec l:command
endfunction

call g:Colorize('ErrorSign',   { 'ctermfg': s:custom_colors.lightred })
call g:Colorize('WarningSign', { 'ctermfg': s:custom_colors.lightyellow })
