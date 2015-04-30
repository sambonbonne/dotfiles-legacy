" My personnal vimrc file
" Based on the vimtutor example

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=100		" keep 100 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" my own options
" display line number
set number
" set smartindent
set tabstop=4		" size of hard tab stop
set shiftwidth=4	" size of an "indent"
set expandtab		" use space instead of tab
" fold method to indent
"set foldmethod=ident
" press space to insert a single char before cursor
nmap <Space> i_<Esc>r
" C-n to open NERDTree
map <C-n> :NERDTreeToggle<CR>
" automatically close the brackets
"inoremap {<Space> {}<C-o>i
inoremap {<Return> {<cr>}<C-o>O
" completion when you search a file (with :edit for exemaple)
set wildmode=longest,full
set wildmenu

" Yeah just put the clipboard on X11, okay ?
set clipboard=unnamedplus

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
set t_Co=256
let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized
set background=dark
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if has("gui_running")
    set guifont=Droid\ Sans\ Mono\ 10
    set lines=999 columns=999 " maybe the ugliest way to maximize a window
endif " gui running"

" Syntastic config
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " tpl file as html
  au BufNewFile,BufRead *.tpl set ft=html
  " twig file as html
  au BufNewFile,BufRead *.html.twig set ft=html
  " handlebar file as html
  au BufNewFile,BufRead *.hbs set ft=html

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  "autocmd FileType text setlocal textwidth=78

  " Highlight line number
  set cursorline
  hi clear CursorLine

  " Delete white space at end of line when save
  autocmd BufWritePre * :%s/\s\+$//e

  " PHP completion in all PHP files
  autocmd FileType php set omnifunc=phpcomplete#CompletePHP

  " HTML completion in all HMTL files
  autocmd FileType html,php set omnifunc=htmlcomplete#CompleteTags

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

  " Open NERDTree
  autocmd vimenter * NERDTree
  " Close it if this is the last buffer
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
  " Close it if this is the last buffer
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Statusline config
"set statusline=%f "tail of the filename
set laststatus=2
set statusline=%<%f\ %h%m%r
set statusline+=\ %(%#warningmsg#%{SyntasticStatuslineFlag()}%*%)
set statusline+=%=%-14.(%l,%c%V%)\ %P

" Local vimrc autoloading without asking (.lvimrc)
let g:localvimrc_ask=0
