let s:tried_quit = {
      \ 'buf': 0,
      \ 'tab': 0,
      \ 'all': 0
      \ }

let s:close_commands = {
      \ 'buf': 'quit!',
      \ 'tab': 'if tabpagenr("$") == 1 | quitall! | else | tabclose! | endif',
      \ 'all': 'qall!'
      \ }

let s:max_delay_safety = 5

function! s:tryClose(type)
  if (s:tried_quit[a:type] <= 0)
    let l:command = substitute(s:close_commands[a:type], '!', '', 'g')

    silent exe l:command

    let s:tried_quit[a:type] = strftime("%s")
  else
    if (strftime("%s") - s:tried_quit[a:type] < s:max_delay_safety)
      silent exe s:close_commands[a:type]
    else
      let s:tried_quit[a:type] = 0
    endif
  endif
endfunction " s:tryClose

if has('autocmd')
  augroup QuickQuitEvents
    autocmd!

    autocmd WinEnter * let s:tried_quit['buf'] = 0
    autocmd TabEnter * let s:tried_quit['tab'] = 0
  augroup END " QuickQuitEvents
endif " has('autocmd')

nnoremap <silent> <Plug>(QuickQuitBuffer) :call <SID>tryClose('buf')<CR>
nnoremap <silent> <Plug>(QuickQuitTab) :call <SID>tryClose('tab')<CR>
nnoremap <silent> <Plug>(QuickQuitAll) :call <SID>tryClose('all')<CR>
