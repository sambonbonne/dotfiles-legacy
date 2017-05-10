if &compatible
  set nocompatible " needed for multiple lines list
endif " &compatible

function! s:trySource(script)
  if filereadable(a:script)
    execute "source " . a:script
    return 1
  else
    return 0
  endif " filereadable(a:script)
endfunction " trySource(script)

let s:nvimrc_end = "nvim/init.vim"

let s:possible = [
      \ ($HOME . "/dev/dotfiles/config/" . s:nvimrc_end),
      \ ($HOME . "/.config/" . s:nvimrc_end)
      \ ]

for s:script in s:possible
  if s:trySource(s:script)
    rtp+=s:script
    break
  endif
endfor " s:script in s:possible
