" My personnal vimrc file
" Based on the vimtutor example

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Vundle config
filetype off
set rtp+=~/.vim/bundle/Vundle.vim " set the runtime path to include Vundle and initialize
call vundle#begin()
Plugin 'gmarik/Vundle.vim' " let Vundle manage Vundle, required End Vundle config

" Put your plugins here
Plugin 'scrooloose/syntastic'           " Syntax check plugin
Plugin 'Shougo/neocomplete.vim'         " Completion plugin
Plugin 'scrooloose/nerdtree'            " Best tree you can see
Plugin 'Xuyuanp/nerdtree-git-plugin'    " Git status flags on the tree
Plugin 'embear/vim-localvimrc'          " To add .lvimrc for each project you want
Plugin 'jeetsukumaran/vim-buffergator'  " Buffers list like NERDTree
Plugin 'airblade/vim-gitgutter'         " See +/-/~ for git
Plugin 'tpope/vim-fugitive'             " Git wrapper, don't put Vim on foreground
Plugin 'Shougo/neosnippet'              " Snippets, works well with Neocomplete
Plugin 'mattn/emmet-vim'                " Emmet for HTML facilities
Plugin 'ciaranm/detectindent'           " detect indent
" Some technos
Plugin 'pangloss/vim-javascript'
Plugin 'kchmck/vim-coffee-script'
Plugin 'moll/vim-node'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'elzr/vim-json'
Plugin 'StanAngeloff/php.vim'
" And the colorscheme
Plugin 'altercation/vim-colors-solarized'

call vundle#end()
" End vundle config

filetype plugin indent on

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

" configure neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" dictionary
let g:neocomplete#sources#dictionary#dictionaries = {
      \ 'default' : ''
      \ }
" completion with TAB, S-TAB can unindent if no popup menu
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-D>"
" select with return key, cancel with backspace (<CR>, <BS>)
inoremap <expr><CR> pumvisible() ? neocomplete#close_popup() : "\<CR>"
inoremap <expr><BS> pumvisible() ? neocomplete#undo_completion()."\<BS>" : "\<BS>"

" configure neosnippet
let g:neosnippet#disable_runtime_snippets = {'_': 1}
" keymap to select and expand the snippet in neocomplete menu
imap <C-k>  <Plug>(neosnippet_expand_or_jump)
smap <C-k>  <Plug>(neosnippet_expand_or_jump)
xmap <C-k>  <Plug>(neosnippet_expand_target)
let g:neosnippet#snippets_directory = '~/.vim/snippets'

" my own options
" display line number
set number

" detect indent plugin
let g:detectindent_preferred_expandtab = 1
let g:detectindent_preferred_indent = 4

" fold method to indent
set foldmethod=indent foldlevel=3 foldcolumn=3 foldminlines=80 foldnestmax=5
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

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Some colors
syntax on
colorscheme solarized
set background=dark
" Also switch on highlighting the last used search pattern.
set hlsearch
" Highlight line number
set cursorline
hi clear CursorLine

if has("gui_running")
  set guifont=Droid\ Sans\ Mono\ 10
  set lines=999 columns=999 " maybe the ugliest way to maximize a window
endif " gui running

" Syntastic config
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  augroup general
    autocmd!

    " templates as html
    au BufNewFile,BufRead *.tpl set ft=html
    au BufNewFile,BufRead *.html.twig set ft=html
    au BufNewFile,BufRead *.hbs set ft=html

    " Delete white space at end of line when save
    autocmd BufWritePre * :%s/\s\+$//e

    autocmd BufReadPost * :DetectIndent
    " 2 spaces indent for some files
    autocmd FileType vim,html,markdown setlocal tabstop=2 shiftwidth=2
    " line limit for some files
    autocmd FileType text,markdown setlocal textwidth=80

    " enable omnifunc and put it to neocomplete
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType css,scss,sass,less setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif

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
else " what do you really need ?
  set autoindent
  set omnifunc=syntaxcomplete#Complete
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
