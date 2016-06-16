function! preserve#save()
  setlocal lazyredraw
  let l:last_view = winsaveview()
  let l:last_search = @/

  return [ l:last_view, l:last_search ]
endfunction

function! preserve#restore(...)
  if a:0 == 0
    redraw
    setlocal nolazyredraw

    return 1
  endif " a:0 == 0

  if len(a:1) == 2
    let l:last_view   = a:1[0]
    let l:last_search = a:1[1]

    call winrestview(l:last_view)
    let @/ = l:last_search
    redraw
    setlocal nolazyredraw
  endif " len(a:1) == 2
endfunction

function! preserve#execute(command, ...)
  let l:current_view = preserve#save()

  if a:0 > 0 && a:1
    silent execute a:command
  else
    execute a:command
  endif " a:0 > 0 && a:1

  call preserve#restore(l:current_view)
endfunction
