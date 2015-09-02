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

" To add .lvimrc for each project you want
Plugin 'embear/vim-localvimrc'
let g:localvimrc_ask=0

" NERDTree, with Git flags
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
noremap <Leader>n :NERDTreeToggle<CR>

" All tags
Plugin 'majutsushi/tagbar'
nnoremap <Leader>t :TagbarToggle<CR>

" Buffers list
Plugin 'jeetsukumaran/vim-buffergator'
let g:buffergator_viewport_split_policy = 'B'
let g:buffergator_hsplit_size = 8
let g:buffergator_sort_regime = 'mru'
let g:buffergator_suppress_keymaps=1
nnoremap <Leader>b :BuffergatorOpen<CR>

" Detect indentation and set defaults
Plugin 'vim-scripts/yaifa.vim'
set tabstop=4          " size of hard tab stop
set shiftwidth=4       " size of an "indent"
set expandtab          " use space instead of tab

" Easy align
Plugin 'junegunn/vim-easy-align'
vmap <Enter> <Plug>(EasyAlign)

" Completion
Plugin 'Shougo/neocomplete.vim'
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
let g:neocomplete#sources#dictionary#dictionaries = {
      \ 'default' : ''
      \ }
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-D>"
inoremap <expr><CR> pumvisible() ? neocomplete#close_popup() : "\<CR>"
inoremap <expr><BS> pumvisible() ? neocomplete#undo_completion()."\<BS>" : "\<BS>"

" First, auto-close brackets, quotes ... Second, auto-close tags
Plugin 'Raimondi/delimitMate'
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
"Plugin 'alvan/vim-closetag'
"let g:closetag_filenames = "*.html,*.erb,*.xml"
"Plugin 'docunext/closetag.vim'

" Snippets
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
imap <C-k>  <Plug>(neosnippet_expand_or_jump)
smap <C-k>  <Plug>(neosnippet_expand_or_jump)
xmap <C-k>  <Plug>(neosnippet_expand_target)

" Replace and undo/redo improve
Plugin 'tpope/vim-abolish'
Plugin 'mbbill/undotree'
nmap <Leader>u :UndotreeToggle<CR>
if has("persistent_undo")
  set undodir='~/.vim/undodir/'
  set undofile
endif

" Files search and advanced moves
Plugin 'kien/ctrlp.vim'
Plugin 'Lokaltog/vim-easymotion'
nmap <Leader>m <Plug>(easymotion-prefix)

" Syntax checking
Plugin 'scrooloose/syntastic'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 4
let g:syntastic_check_on_open = 1
let g:syntastic_aggregate_errors = 1

" Git wrapping and symbols
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" Man pages on the editor
Plugin 'bruno-/vim-man'

" Some technos/languages
Plugin 'pangloss/vim-javascript'
Plugin 'moll/vim-node'
Plugin 'kchmck/vim-coffee-script'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'digitaltoad/vim-jade'
Plugin 'othree/html5.vim'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'wavded/vim-stylus'
Plugin 'StanAngeloff/php.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'timonv/vim-cargo'
Plugin 'pekepeke/titanium-vim'
Plugin 'elzr/vim-json'
Plugin 'cespare/vim-toml'

" Some colors
set t_Co=256
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-scripts/colorizer'
let g:colorizer_nomap = 1

call vundle#end()
" End vundle config

filetype plugin indent on
syntax on
set wildignore=*~,*.swp,*.orig

" Some colors
set background=dark
colorscheme solarized

" disable the old Ex mode
nnoremap Q <nop>

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=100	" keep 100 lines of command line history
set showcmd     " display incomplete commands
set incsearch   " do incremental searching

" display line number
set number

" fold method to indent, fold config
set foldmethod=indent
set foldcolumn=3 foldnestmax=4 foldminlines=8
highlight Folded cterm=underline ctermfg=grey ctermbg=NONE
highlight FoldColumn ctermfg=magenta

" press space to insert a single char before cursor
nmap <Space> i_<Esc>r

" completion when you search a file (with :edit for exemaple)
set wildmode=longest,full
set wildmenu

" Yeah just put the clipboard on X11, okay ?
set clipboard=unnamedplus

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" highlight line, light line number
set cursorline
highlight CursorLineNR ctermbg=black ctermfg=grey
" Also switch on highlighting the last used search pattern.
set hlsearch

" auto-write files
set autowriteall

if has("gui_running")
  set guifont=Droid\ Sans\ Mono\ 10
  set lines=999 columns=999 " maybe the ugliest way to maximize a window
endif " gui running

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
  augroup END

  augroup general
    autocmd!

    " templates as html
    au BufNewFile,BufRead *.tpl set ft=html
    au BufNewFile,BufRead *.html.twig set ft=html

    " Delete white space at end of line when save
    autocmd BufWritePre * :%s/\s\+$//e

    " 2 spaces indent for some files
    autocmd FileType vim,html,markdown setlocal tabstop=2 shiftwidth=2
    " line limit for some files
    "autocmd FileType text,markdown setlocal textwidth=80

    " enable omnifunc and put it to neocomplete
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType css,scss,sass,less setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd BufEnter .js*rc setfiletype json
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif

    " configure sytastic checkers
    autocmd FileType javascript let b:syntastic_checkers = findfile('.jscsrc', '.;') != '' ? ['jscs', 'jshint'] : ['jshint']

    " auto save/load folding
    "autocmd BufWinLeave * mkview
    "autocmd BufWinEnter * silent loadview

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
hi StatusLine ctermbg=black ctermfg=grey
hi StatusLineNC ctermbg=black ctermfg=darkgrey
set laststatus=2
set statusline=%6(%L%)\ %6(%l%),%-6(%c%)
set statusline+=\ %<%f\ %Y,%{&fenc==\"\"?&enc:&fenc}\ %{strftime(\"%H:%M\",getftime(expand(\"%%\")))}
set statusline+=%=%m%r%{fugitive#statusline()}
set statusline+=\ %(%#warningmsg#%{SyntasticStatuslineFlag()}%*%)
