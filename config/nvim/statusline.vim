set laststatus=2

let s:sl_colors = {
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

let s:sl_colors.modes = {
      \   'normal': {
      \     'term':    "none",
      \     'gui':     "none",
      \     'ctermbg': s:sl_colors.green.term,
      \     'ctermfg': s:sl_colors.fg.term,
      \     'guibg':   s:sl_colors.green.gui,
      \     'guifg':   s:sl_colors.fg.gui
      \   },
      \   'insert': {
      \     'term':    "bold",
      \     'gui':     "bold",
      \     'ctermbg': s:sl_colors.red.term,
      \     'ctermfg': s:sl_colors.fg.term,
      \     'guibg':   s:sl_colors.red.gui,
      \     'guifg':   s:sl_colors.fg.gui
      \   },
      \   'replace': {
      \     'term':    "bold",
      \     'gui':     "bold",
      \     'ctermbg': s:sl_colors.yellow.term,
      \     'ctermfg': s:sl_colors.fg.term,
      \     'guibg':   s:sl_colors.yellow.gui,
      \     'guifg':   s:sl_colors.fg.gui
      \   }
      \ }

function! s:initColors()
  call g:Colorize('StatusLine', {
        \ 'cterm':   "NONE",
        \ 'term':    "NONE",
        \ 'gui':     "NONE",
        \ 'ctermfg': s:sl_colors.fg.term,
        \ 'guifg':   s:sl_colors.fg.gui,
        \ 'ctermbg': s:sl_colors.bg.term,
        \ 'guibg':   s:sl_colors.bg.gui
        \ })
  call g:Colorize('StatusLineNC', {
        \ 'cterm':   "NONE",
        \ 'term':    "NONE",
        \ 'gui':     "NONE",
        \ 'ctermfg': s:sl_colors.grey.term,
        \ 'guifg':   s:sl_colors.grey.gui,
        \ 'ctermbg': s:sl_colors.black.term,
        \ 'guibg':   s:sl_colors.black.gui
        \ })

  call g:Colorize('SL_badge_blue', {
        \ 'ctermbg': s:sl_colors.blue.term,
        \ 'ctermfg': s:sl_colors.fg.term,
        \ 'guibg': s:sl_colors.blue.gui,
        \ 'guifg': s:sl_colors.fg.gui
        \ })
  call g:Colorize('SL_badge_green', {
        \ 'ctermbg': s:sl_colors.green.term,
        \ 'ctermfg': s:sl_colors.fg.term,
        \ 'guibg': s:sl_colors.green.gui,
        \ 'guifg': s:sl_colors.fg.gui
        \ })
  call g:Colorize('SL_badge_yellow', {
        \ 'ctermbg': s:sl_colors.yellow.term,
        \ 'ctermfg': s:sl_colors.fg.term,
        \ 'guibg': s:sl_colors.yellow.gui,
        \ 'guifg': s:sl_colors.fg.gui
        \ })
  call g:Colorize('SL_badge_red', {
        \ 'ctermbg': s:sl_colors.red.term,
        \ 'ctermfg': s:sl_colors.fg.term,
        \ 'guibg': s:sl_colors.red.gui,
        \ 'guifg': s:sl_colors.fg.gui
        \ })

  call g:Colorize('SLNC_badge_blue', {
        \ 'ctermbg': s:sl_colors.blue.term,
        \ 'ctermfg': s:sl_colors.grey.term,
        \ 'guibg': s:sl_colors.blue.gui,
        \ 'guifg': s:sl_colors.grey.gui
        \ })
  call g:Colorize('SLNC_badge_green', {
        \ 'ctermbg': s:sl_colors.green.term,
        \ 'ctermfg': s:sl_colors.grey.term,
        \ 'guibg': s:sl_colors.green.gui,
        \ 'guifg': s:sl_colors.grey.gui
        \ })
  call g:Colorize('SLNC_badge_yellow', {
        \ 'ctermbg': s:sl_colors.yellow.term,
        \ 'ctermfg': s:sl_colors.grey.term,
        \ 'guibg': s:sl_colors.yellow.gui,
        \ 'guifg': s:sl_colors.grey.gui
        \ })
  call g:Colorize('SLNC_badge_red', {
        \ 'ctermbg': s:sl_colors.red.term,
        \ 'ctermfg': s:sl_colors.grey.term,
        \ 'guibg': s:sl_colors.red.gui,
        \ 'guifg': s:sl_colors.grey.gui
        \ })

  call g:Colorize('SL_text_grey', {
        \ 'ctermfg': s:sl_colors.grey.term,
        \ 'ctermbg': s:sl_colors.bg.term,
        \ 'cterm':   "NONE",
        \ 'guifg': s:sl_colors.grey.gui,
        \ 'guibg': s:sl_colors.bg.gui,
        \ 'gui':   "NONE"
        \ })
  call g:Colorize('SL_text_yellow', {
        \ 'ctermfg': s:sl_colors.yellow.term,
        \ 'ctermbg': s:sl_colors.bg.term,
        \ 'cterm': "bold",
        \ 'guifg': s:sl_colors.yellow.gui,
        \ 'guibg': s:sl_colors.bg.gui,
        \ 'gui': "bold"
        \ })
  call g:Colorize('SL_text_red', {
        \ 'ctermfg': s:sl_colors.red.term,
        \ 'ctermbg': s:sl_colors.bg.term,
        \ 'cterm': "bold",
        \ 'guifg': s:sl_colors.red.gui,
        \ 'guibg': s:sl_colors.bg.gui,
        \ 'gui': "bold"
        \ })
  call g:Colorize('SL_text_green', {
        \ 'ctermfg': s:sl_colors.green.term,
        \ 'ctermbg': s:sl_colors.bg.term,
        \ 'cterm': "bold",
        \ 'guifg': s:sl_colors.green.gui,
        \ 'guibg': s:sl_colors.bg.gui,
        \ 'gui': "bold"
        \ })

  call g:Colorize('SLNC_text_grey', {
        \ 'ctermfg': s:sl_colors.grey.term,
        \ 'ctermbg': s:sl_colors.black.term,
        \ 'guifg': s:sl_colors.grey.gui,
        \ 'guibg': s:sl_colors.black.gui
        \ })
  call g:Colorize('SLNC_text_yellow', {
        \ 'ctermfg': s:sl_colors.yellow.term,
        \ 'ctermbg': s:sl_colors.black.term,
        \ 'guifg': s:sl_colors.yellow.gui,
        \ 'guibg': s:sl_colors.black.gui
        \ })
  call g:Colorize('SLNC_text_red', {
        \ 'ctermfg': s:sl_colors.red.term,
        \ 'ctermbg': s:sl_colors.black.term,
        \ 'guifg': s:sl_colors.red.gui,
        \ 'guibg': s:sl_colors.black.gui
        \ })
  call g:Colorize('SLNC_text_green', {
        \ 'ctermfg': s:sl_colors.green.term,
        \ 'ctermbg': s:sl_colors.black.term,
        \ 'guifg': s:sl_colors.green.gui,
        \ 'guibg': s:sl_colors.black.gui
        \ })

  call g:Colorize('SL_mode', s:sl_colors.modes.normal) " mode color
endfunction " s:initColors

if has("autocmd")
  autocmd ColorScheme * call s:initColors()
endif " has("autocmd")

call s:initColors()

function! LiteFilePath(trailingSlash)
  let l:path = split(substitute(expand("%:h"), $HOME, "~", ""), "/")

  if len(l:path) == 0
    return ""
  endif " len(l:path) == 0

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
  if &filetype == "qf"
    setlocal statusline=\ %#SL_badge_yellow#\ [QUICK\ FIX]\ %0*
    setlocal statusline+=\ %#SL_badge_red#\ %L\ %0* " number of line/errors
    return
  endif

  setlocal statusline=\ \ %#SL_mode#\ \ •\ \ %0*                  " current mode
  setlocal statusline+=\ \ %#SL_text_grey#%{LiteFilePath(1)}%0*%t " filename
  setlocal statusline+=\ %6(%#SL_badge_green#\ %l\ %)             " current line
  setlocal statusline+=%#SL_badge_blue#\ %L\ %0*                  " max line
  setlocal statusline+=\ %#SL_badge_green#\ %c\ %0*               " current column
  setlocal statusline+=\ %#SL_badge_blue#\ %Y\ %0*                " file type

  if (tolower(&fileencoding) == tolower(&encoding))
    setlocal statusline+=\ %#SL_badge_blue#
  else
    setlocal statusline+=\ %#SL_badge_yellow#
  endif " tolower(&encoding) == "utf8"
  setlocal statusline+=\ %{&fenc==\"\"?&enc:&fenc}\ %0* " encoding

  setlocal statusline+=%=%< " got to the right and eventually truncate

  if exists("b:git_dir")
    setlocal statusline+=\ %#SL_badge_blue#\ %{fugitive#statusline()}\ %0* " Git infos (if using git)
  endif " exists('b:git_dir')

  setlocal statusline+=\ %(%#SL_text_red#%{neomake#statusline#LoclistStatus()}%0*%)\  " lint/compile warnings/errors
endfunction " statuslineFocus

function! s:statuslineUnfocus()
  if &filetype == "qf"
    setlocal statusline=\ %#SL_badge_yellow#\ [QUICK\ FIX]\ %0*
    setlocal statusline+=\ %#SL_badge_red#\ %L\ %0* " number of line/errors
    return
  endif

  setlocal statusline=\ \ %#SLNC_badge_blue#\ \ •\ \ %0*            " mode badge
  setlocal statusline+=\ \ %#SLNC_text_grey#%{LiteFilePath(1)}%0*%t " filename
  setlocal statusline+=\ \ %#SLNC_badge_green#\ %l\ %0*             " current line
  setlocal statusline+=\ %#SLNC_badge_blue#\ %Y\ %0*                " file type

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

if has("autocmd")
  augroup statusline
    autocmd!

    function! s:InsertStatuslineColor(mode)
      if a:mode == 'i'
        call g:Colorize('SL_mode', s:sl_colors.modes.insert) " mode color (applied on filename)
      else
        call g:Colorize('SL_mode', s:sl_colors.modes.replace) " mode color (applied on filename)
      endif
    endfunction

    autocmd InsertEnter  * call s:InsertStatuslineColor(v:insertmode)
    autocmd InsertChange * call s:InsertStatuslineColor(v:insertmode)
    autocmd InsertLeave  * call g:Colorize('SL_mode', s:sl_colors.modes.normal)

    autocmd BufRead,BufNewFile,WinEnter * call s:statuslineFocus()
    autocmd WinLeave * call s:statuslineUnfocus()
  augroup END
endif " has("autocmd")
