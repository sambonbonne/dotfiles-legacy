set showtabline=2

let s:tl_colors = {
      \   'bg': { 'term': '032', 'gui': "#0087D7" },
      \   'fg': { 'term': '255', 'gui': "#EEEEEE" },
      \
      \   'grey':  { 'term': '251', 'gui': "#C6C6C6" },
      \   'black': { 'term': '024', 'gui': "#005F87" },
      \
      \   'blue':   { 'term': '027',  'gui': "#005FFF" },
      \   'green':  { 'term': '029',  'gui': "#00875F" },
      \   'red':    { 'term': '131', 'gui': "#AF5F5F" },
      \   'yellow': { 'term': '100', 'gui': "#878700" }
      \ }

function! s:initColors()
  call g:Colorize('TabLine', {
        \ 'cterm':   "NONE",
        \ 'term':    "NONE",
        \ 'gui':     "NONE",
        \ 'ctermfg': s:tl_colors.fg.term,
        \ 'guifg':   s:tl_colors.fg.gui,
        \ 'ctermbg': s:tl_colors.bg.term,
        \ 'guibg':   s:tl_colors.bg.gui
        \ })
  call g:Colorize('TabLineModified', {
        \ 'cterm':   "NONE",
        \ 'term':    "NONE",
        \ 'gui':     "NONE",
        \ 'ctermfg': s:tl_colors.fg.term,
        \ 'guifg':   s:tl_colors.fg.gui,
        \ 'ctermbg': s:tl_colors.yellow.term,
        \ 'guibg':   s:tl_colors.yellow.gui
        \ })
  call g:Colorize('TabLineReadOnly', {
        \ 'cterm':   "NONE",
        \ 'term':    "NONE",
        \ 'gui':     "NONE",
        \ 'ctermfg': s:tl_colors.fg.term,
        \ 'guifg':   s:tl_colors.fg.gui,
        \ 'ctermbg': s:tl_colors.bg.term,
        \ 'guibg':   s:tl_colors.bg.gui
        \ })
  call g:Colorize('TabLineModifiedReadOnly', {
        \ 'cterm':   "NONE",
        \ 'term':    "NONE",
        \ 'gui':     "NONE",
        \ 'ctermfg': s:tl_colors.fg.term,
        \ 'guifg':   s:tl_colors.fg.gui,
        \ 'ctermbg': s:tl_colors.red.term,
        \ 'guibg':   s:tl_colors.red.gui
        \ })

  call g:Colorize('TabLineSel', {
        \ 'cterm':   "bold",
        \ 'term':    "bold",
        \ 'gui':     "bold",
        \ 'ctermfg': s:tl_colors.green.term,
        \ 'guifg':   s:tl_colors.green.gui,
        \ 'ctermbg': s:tl_colors.fg.term,
        \ 'guibg':   s:tl_colors.fg.gui
        \ })
  call g:Colorize('TabLineSelModified', {
        \ 'cterm':   "bold",
        \ 'term':    "bold",
        \ 'gui':     "bold",
        \ 'ctermfg': s:tl_colors.yellow.term,
        \ 'guifg':   s:tl_colors.yellow.gui,
        \ 'ctermbg': s:tl_colors.fg.term,
        \ 'guibg':   s:tl_colors.fg.gui
        \ })
  call g:Colorize('TabLineSelReadOnly', {
        \ 'cterm':   "bold",
        \ 'term':    "bold",
        \ 'gui':     "bold",
        \ 'ctermfg': s:tl_colors.green.term,
        \ 'guifg':   s:tl_colors.green.gui,
        \ 'ctermbg': s:tl_colors.grey.term,
        \ 'guibg':   s:tl_colors.grey.gui
        \ })
  call g:Colorize('TabLineSelModifiedReadOnly', {
        \ 'cterm':   "bold",
        \ 'term':    "bold",
        \ 'gui':     "bold",
        \ 'ctermfg': s:tl_colors.red.term,
        \ 'guifg':   s:tl_colors.red.gui,
        \ 'ctermbg': s:tl_colors.grey.term,
        \ 'guibg':   s:tl_colors.grey.gui
        \ })

  call g:Colorize('TabLineFill', {
        \ 'cterm':   "NONE",
        \ 'term':    "NONE",
        \ 'gui':     "NONE",
        \ 'ctermfg': s:tl_colors.grey.term,
        \ 'guifg':   s:tl_colors.grey.gui,
        \ 'ctermbg': s:tl_colors.black.term,
        \ 'guibg':   s:tl_colors.black.gui
        \ })
endfunction " s:initColors()

function! SetCustomTabLine()
  let l:tabLine = ''

  for i in range(tabpagenr('$'))
    let l:index = i + 1

    " set the tab page number (for mouse clicks)
    let l:tabLine .= '%' . l:index . 'T'

    "let l:tabLine .= ' %{SetCustomTabLabel(' . index . ')} '
    let l:tabLine .= SetCustomTabLabel(index)
  endfor " i in range(tabpagenr('$'))

  " after the last tab fill with TabLineFill and reset tab page nr
  let l:tabLine .= '%#TabLineFill#%T'

  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    "let l:tabLine .= '%=%#TabLine#%999Xclose'
    let l:tabLine .= '%=%#TabLine#%999X X '
  endif

  return l:tabLine
endfunction " SetCustomerTabLine()

function! SetCustomTabLabel(index)
  let l:buflist = tabpagebuflist(a:index)
  let l:winnr = tabpagewinnr(a:index)
  let l:buf = buflist[l:winnr - 1]
  let l:bufname = fnamemodify(bufname(l:buf), ':t')
  let l:bufvars = getbufvar(l:buf, '')
  let l:bufmodified = getbufvar(l:buf, "&mod")
  let l:bufreadonly = getbufvar(l:buf, "&ro")

  let l:content = ''

  if a:index == tabpagenr()
    if l:bufmodified && l:bufreadonly
      let l:content .= '%#TabLineSelModifiedReadOnly#'
    elseif l:bufmodified
      let l:content .= '%#TabLineSelModified#'
    elseif l:bufreadonly
      let l:content .= '%#TabLineSelReadOnly#'
    else
      let l:content .= '%#TabLineSel#'
    endif " l:bufmodified
  else
    if l:bufmodified && l:bufreadonly
      let l:content .= '%#TabLineModifiedReadOnly#'
    elseif l:bufmodified
      let l:content .= '%#TabLineModified#'
    elseif l:bufreadonly
      let l:content .= '%#TabLineReadOnly#'
    else
      let l:content .= '%#TabLine#'
    endif " l:bufmodified
  endif " index == tabpagenr()

  let l:content .= ' ' . a:index

  if strlen(l:bufname) > 0
    let l:content .= ' ' . fnamemodify(bufname(l:buf), ':t')
  endif " strlen(l:bufname) > 0

  return l:content . ' %#TabLineFill# '
endfunction " SetCustomTabLabel()

set tabline=%!SetCustomTabLine()

if has("autocmd")
  autocmd ColorScheme * call s:initColors()
endif " has("autocmd")

call s:initColors()
