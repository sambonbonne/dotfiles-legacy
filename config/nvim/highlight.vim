let s:custom_colors = {
      \ 'darkred':     { 'term': 052, 'gui': "#5F0000" },
      \ 'darkgreen':   { 'term': 023, 'gui': "#005F5F" },
      \ 'darkyellow':  { 'term': 130, 'gui': "#AF7F00" },
      \ 'lightred':    { 'term': 203, 'gui': "#FF5F5F" },
      \ 'lightgreen':  { 'term': 150, 'gui': "#AFD787" },
      \ 'lightyellow': { 'term': 221, 'gui': "#FFDF5F" },
      \ }

function! g:Colorize(group, colors)
  let l:command = 'highlight ' . a:group

  for l:part in [ 'ctermbg', 'ctermfg', 'guibg', 'guifg', 'cterm', 'term', 'gui' ]
    if has_key(a:colors, l:part)
      let l:command .= ' ' . l:part . '=' . a:colors[l:part]
    endif
  endfor

  exec l:command
endfunction

function! s:customColors()
  call g:Colorize('ErrorSign', {
        \ 'ctermfg': s:custom_colors.lightred.term,
        \ 'guifg': s:custom_colors.lightred.gui
        \ })
  call g:Colorize('WarningSign', {
        \ 'ctermfg': s:custom_colors.lightyellow.term,
        \ 'guifg': s:custom_colors.lightyellow.gui
        \ })
endfunction " s:customColors

if has("autocmd")
  autocmd ColorScheme * call s:customColors()
endif " has("autocmd")
