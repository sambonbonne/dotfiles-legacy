set laststatus=2

let s:colors = {
      \   'bg': { 'term': 32,  'gui': "green" },
      \   'fg': { 'term': 255, 'gui': "white" },
      \ 
      \   'grey':  { 'term': 251, 'gui': "grey" },
      \   'black': { 'term':  24, 'gui': "black" },
      \ 
      \   'blue':   { 'term': 27 },
      \   'green':  { 'term': 29 },
      \   'red':    { 'term': 131 },
      \   'yellow': { 'term': 100 }
      \ }

let s:colors.modes = {
      \   'normal': {
      \     'term':    "none",
      \     'gui':     "bold",
      \     'ctermbg': s:colors.green.term,
      \     'guibg':   "green"
      \   },
      \   'insert': {
      \     'term':    "bold",
      \     'gui':     "bold",
      \     'ctermbg': s:colors.red.term,
      \     'guibg':   "red"
      \   },
      \   'replace': {
      \     'term':    "bold",
      \     'gui':     "bold",
      \     'ctermbg': s:colors.yellow.term,
      \     'guibg':   "yellow"
      \   }
      \ }

function s:initColors()
  call g:Colorize('statusline', {
        \ 'term':    "NONE",
        \ 'gui':     "NONE",
        \ 'ctermfg': s:colors.fg.term,
        \ 'guifg':   s:colors.fg.gui,
        \ 'ctermbg': s:colors.bg.term,
        \ 'guibg':   s:colors.bg.gui
        \ })
  call g:Colorize('statuslineNC', {
        \ 'term':    "NONE",
        \ 'gui':     "NONE",
        \ 'ctermfg': s:colors.grey.term,
        \ 'guifg':   s:colors.grey.gui,
        \ 'ctermbg': s:colors.black.term,
        \ 'guibg':   s:colors.black.gui
        \ })

  call g:Colorize('SL_badge_blue', { 'ctermbg': s:colors.blue.term,   'ctermfg': s:colors.fg.term })
  call g:Colorize('SL_badge_green',  { 'ctermbg': s:colors.green.term,  'ctermfg': s:colors.fg.term })
  call g:Colorize('SL_badge_yellow', { 'ctermbg': s:colors.yellow.term, 'ctermfg': s:colors.fg.term })
  call g:Colorize('SL_badge_red',    { 'ctermbg': s:colors.red.term,    'ctermfg': s:colors.fg.term })

  call g:Colorize('SLNC_badge_blue', { 'ctermbg': s:colors.blue.term,   'ctermfg': s:colors.grey.term })
  call g:Colorize('SLNC_badge_green',  { 'ctermbg': s:colors.green.term,  'ctermfg': s:colors.grey.term })
  call g:Colorize('SLNC_badge_yellow', { 'ctermbg': s:colors.yellow.term, 'ctermfg': s:colors.grey.term })
  call g:Colorize('SLNC_badge_red',    { 'ctermbg': s:colors.red.term,    'ctermfg': s:colors.grey.term })

  call g:Colorize('SL_text_grey',   { 'ctermfg': s:colors.grey.term,   'ctermbg': s:colors.bg.term, 'cterm': "bold" })
  call g:Colorize('SL_text_yellow', { 'ctermfg': s:colors.yellow.term, 'ctermbg': s:colors.bg.term, 'cterm': "bold" })
  call g:Colorize('SL_text_red',    { 'ctermfg': s:colors.red.term,    'ctermbg': s:colors.bg.term, 'cterm': "bold" })
  call g:Colorize('SL_text_green',  { 'ctermfg': s:colors.green.term,  'ctermbg': s:colors.bg.term, 'cterm': "bold" })

  call g:Colorize('SLNC_text_grey',   { 'ctermfg': s:colors.grey.term,   'ctermbg': s:colors.black.term })
  call g:Colorize('SLNC_text_yellow', { 'ctermfg': s:colors.yellow.term, 'ctermbg': s:colors.black.term })
  call g:Colorize('SLNC_text_red',    { 'ctermfg': s:colors.red.term,    'ctermbg': s:colors.black.term })
  call g:Colorize('SLNC_text_green',  { 'ctermfg': s:colors.green.term,  'ctermbg': s:colors.black.term })

  call g:Colorize('SL_mode', s:colors.modes.normal) " mode color
endfunction " s:initColors

call s:initColors()

function! LiteFilePath(trailingSlash)
  let l:path = split(expand("%:h"), "/")

  if a:trailingSlash
    let l:path[len(l:path) - 1] = l:path[len(l:path) - 1] . "/"
  endif " trailing

  if len(l:path) == 0
    return "?"
  elseif len(l:path) == 1
    if (l:path[0] == "." || l:path[0] == "./")
      return ""
    else
      return l:path[0]
    endif " l:path[0] == '.'
  endif " len(l:path) == [0|1]

  if l:path[0] . "/" . l:path[1] == $HOME
    let l:path = l:path[2:]
    call insert(l:path, "~")
  endif " $HOME replace

  let l:reduced = []

  for l:directory in l:path[0:len(path) - 2]
    let l:short = l:directory[0]

    if l:short == "." && len(l:directory) > 1
      let l:short = "." . l:directory[1]
    end

    if stridx(l:directory, "-") >= 0
      let l:short = l:short . "-" . l:directory[stridx(l:directory, "-") + 1]
    endif " stridx(l:directory, '-') >= 0

    call add(l:reduced, l:short)
  endfor " directory in l:path

  return join(l:reduced, "/") . "/" . l:path[len(path) - 1]
endfunction " s:filepath

function! s:statuslineFocus()
  setlocal statusline=\ \ %#SL_mode#\ \ •\ \ %0*                               " current mode
  setlocal statusline+=\ \ %#SL_text_grey#%{LiteFilePath(1)}%0*%t              " filename
  setlocal statusline+=\ %6(%#SL_badge_green#\ %l\ %)%#SL_badge_blue#\ %L\ %0* " current and max line
  setlocal statusline+=\ %#SL_badge_green#\ %-6(%c\ %0*%)                      " current column
  setlocal statusline+=\ %#SL_badge_blue#\ %Y\ %0*                             " file type

  if (tolower(&fileencoding) == tolower(&encoding))
    setlocal statusline+=\ %#SL_badge_blue#
  else
    setlocal statusline+=\ %#SL_badge_yellow#
  endif " tolower(&encoding) == "utf8"
  setlocal statusline+=\ %{&fenc==\"\"?&enc:&fenc}\ %0* " encoding

  if !&readonly
    setlocal statusline+=\ %#SL_badge_yellow#\ %{strftime(\"%H:%M\",getftime(expand(\"%%\")))}\ %0* " last write
  endif " !&readonly

  setlocal statusline+=%=%< " got to the right and eventually truncate

  if exists("b:git_dir")
    setlocal statusline+=\ %#SL_badge_blue#\ %{fugitive#statusline()}\ %0* " Git infos (if using git)
  endif " exists('b:git_dir')

  setlocal statusline+=\ %(%#SL_text_red#%{neomake#statusline#LoclistStatus()}%0*%)\  " lint/compile warnings/errors
endfunction " statuslineFocus

function! s:statuslineUnfocus()
  setlocal statusline=\ \ %#SLNC_badge_blue#\ \ •\ \ %0*            " mode badge
  setlocal statusline+=\ \ %#SLNC_text_grey#%{LiteFilePath(1)}%0*%t " filename
  setlocal statusline+=\ \ %#SLNC_badge_green#\ %l\ %0*             " current line
  setlocal statusline+=\ %#SLNC_badge_blue#\ %Y\ %0*                " file type

  if (tolower(&fileencoding) == tolower(&encoding))
    setlocal statusline+=\ %#SLNC_badge_blue#
  else
    setlocal statusline+=\ %#SLNC_badge_yellow#
  endif " tolower(&encoding) == "utf8"
  setlocal statusline+=\ %{&fenc==\"\"?&enc:&fenc}\ %0* " encoding

  if !&readonly
    if &modified
      setlocal statusline+=\ %#SLNC_badge_red#
    else
      setlocal statusline+=\ %#SLNC_badge_green#
    endif " &modified

    setlocal statusline+=\ %{strftime(\"%H:%M\",getftime(expand(\"%%\")))}\ %0* " last write
  endif " !&readonly

  setlocal statusline+=%=%< " got to the right and eventually truncate

  setlocal statusline+=\ %(%#SLNC_text_red#%{neomake#statusline#LoclistStatus()}%*%) " lint/compile warnings/errors
endfunction " statuslineUnfocus

"call s:statuslineFocus()

if has("autocmd")
  augroup statusline
    autocmd!

    function! s:InsertStatuslineColor(mode)
      if a:mode == 'i'
        call g:Colorize('SL_mode', s:colors.modes.insert) " mode color (applied on filename)
      else
        call g:Colorize('SL_mode', s:colors.modes.replace) " mode color (applied on filename)
      endif
    endfunction

    autocmd InsertEnter  * call s:InsertStatuslineColor(v:insertmode)
    autocmd InsertChange * call s:InsertStatuslineColor(v:insertmode)
    autocmd InsertLeave  * call g:Colorize('SL_mode', s:colors.modes.normal)

    autocmd BufRead,BufNewFile,WinEnter * call s:statuslineFocus()
    autocmd WinLeave * call s:statuslineUnfocus()
  augroup END
endif " has("autocmd")
