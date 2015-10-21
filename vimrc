" My personnal vimrc file
" Based on the vimtutor example

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" vim-plug no installed ? We can do it for you
if empty(glob("~/.vim/autoload/plug.vim"))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
              \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  if has("autocmd")
      autocmd VimEnter * PlugInstall | source $MYVIMRC
  endif
endif

call plug#begin('~/.vim/plugged')

" Vimproc, not bad
Plug 'Shougo/vimproc.vim'

" To add .lvimrc for each project you want
Plug 'embear/vim-localvimrc'
let g:localvimrc_ask=0

" NERDTree, with Git flags
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } | Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
noremap <Leader>n :NERDTreeToggle<CR>

" All tags
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
nnoremap <Leader>t :TagbarToggle<CR>

" Buffers list
Plug 'bling/vim-bufferline' " in a line
Plug 'jeetsukumaran/vim-buffergator', { 'on': ['BuffergatorOpen', 'BuffergatorToggle'] } " quick switch
let g:buffergator_viewport_split_policy='B'
let g:buffergator_hsplit_size=8
let g:buffergator_sort_regime='mru'
let g:buffergator_suppress_keymaps=1
nnoremap <Leader>b :BuffergatorOpen<CR>

" Detect indentation and set defaults
Plug 'vim-scripts/yaifa.vim'
set tabstop=4    " size of hard tab stop
set shiftwidth=4 " size of an "indent"
set expandtab    " use space instead of tab

" Easy align
Plug 'junegunn/vim-easy-align', { 'on': '<Plug>(EasyAlign)' }
vmap <Enter> <Plug>(EasyAlign)

" Completion
if has("lua")
  Plug 'Shougo/context_filetype.vim'
  Plug 'Shougo/neoinclude.vim'
  Plug 'Shougo/neco-syntax'
  let g:necosyntax#min_keyword_length = 3
  Plug 'Shougo/neocomplete.vim'
  let g:neocomplete#enable_at_startup = 1
  set completeopt=longest,preview,menu,noselect
  let g:neocomplete#use_vimproc = 1
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#enable_camel_case = 1
  let g:neocomplete#auto_completion_start_length = 3
  let g:neocomplete#min_keyword_length = 3
  let g:neocomplete#same_filetypes = {'_': '_'}
  let g:neocomplete#enable_auto_delimiter = 1

  let g:neocomplete#sources = {}
  let g:neocomplete#sources._ = ['member', 'buffer', 'tag', 'omni']
  let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : ''
        \ }

  let g:neocomplete#max_list = 10
  let g:neocomplete#max_keyword_width = 25
  let g:neocomplete#enable_auto_close_preview = 1
else
  Plug 'ervandew/supertab'
  let g:SuperTabDefaultCompletionType="context"
  let g:SuperTabContextDefaultCompletionType="<c-n>"
endif
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-D>"
inoremap <expr><C-TAB> neocomplete#complete_common_string()
inoremap <expr><CR> pumvisible() ? neocomplete#smart_close_popup() : "\<CR>"
inoremap <expr><BS> pumvisible() ? neocomplete#undo_completion()."\<BS>" : "\<BS>"

" First, auto-close brackets, quotes ... Second, auto-close tags
Plug 'Raimondi/delimitMate'
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
"Plug 'alvan/vim-closetag'
"let g:closetag_filenames = "*.html,*.erb,*.xml"
"Plug 'docunext/closetag.vim'

" Snippets
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
imap <C-k>  <Plug>(neosnippet_expand_or_jump)
smap <C-k>  <Plug>(neosnippet_expand_or_jump)
xmap <C-k>  <Plug>(neosnippet_expand_target)

" Replace and undo/redo improve
Plug 'tpope/vim-abolish', { 'on': ['Abolish', 'Subvert'] } " :Abolish{despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}, :Subvert/pattern/subtitute/g
Plug 'mbbill/undotree', { 'on': ['UndotreeToggle', 'UndotreeShow', 'UndotreeFocus'] }
nmap <Leader>u :UndotreeToggle<CR>
if has("persistent_undo")
  set undodir='~/.vim/undodir/'
  set undofile
endif

" Files search and advanced moves
Plug 'kien/ctrlp.vim'
let g:ctrlp_map = '<Leader>p'
Plug 'Lokaltog/vim-easymotion', { 'on': '<Plug>(easymotion-prefix)' }
nmap <Leader>m <Plug>(easymotion-prefix)
vmap <Leader>m <Plug>(easymotion-prefix)

" Syntax checking
Plug 'scrooloose/syntastic'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 4
let g:syntastic_check_on_open = 1
let g:syntastic_aggregate_errors = 1

" Git wrapping and symbols
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Man pages on the editor
Plug 'bruno-/vim-man',  { 'on': ['Man', 'Mangrep'] }

" Some technos/languages
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
Plug 'mattn/jscomplete-vim', { 'for': 'javascript' }
Plug 'myhere/vim-nodejs-complete', { 'for': 'javascript' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'mustache/vim-mustache-handlebars'
Plug 'aaronj1335/underscore-templates.vim'
Plug 'digitaltoad/vim-jade'
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'css3'] }
Plug 'wavded/vim-stylus'
Plug 'pekepeke/titanium-vim'
let g:nodejs_complete_config = {
            \  'js_compl_fn': 'jscomplete#CompleteJS',
            \  'max_node_compl_len': 15
            \ }

Plug 'StanAngeloff/php.vim', { 'for': 'php' }

Plug 'hdima/python-syntax', { 'for': 'python' }

Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'timonv/vim-cargo'

Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'cespare/vim-toml', { 'for': 'toml' }

Plug 'docker/docker', { 'rtp': '/contrib/syntax/vim/' }
Plug 'nginx/nginx', { 'rtp': '/contrib/vim/' }

Plug 'vim-scripts/bash-support.vim', { 'for': ['shell', 'sh', 'bash'] }

Plug 'PotatoesMaster/i3-vim-syntax'

" Some colors
Plug 'NLKNguyen/papercolor-theme'
Plug 'jdkanani/vim-material-theme'
Plug 'jscappini/material.vim'
Plug 'kristijanhusak/vim-hybrid-material'
" For hex colors
Plug 'vim-scripts/colorizer'
let g:colorizer_nomap = 1

call plug#end()
" End vundle config

filetype plugin indent on
syntax on
set wildignore=*~,*.swp,*.orig

" disable the old Ex mode
nnoremap Q <nop>

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Some colors configuration
set t_Co=256
set background=dark
colorscheme hybrid_material
if (has("gui_running"))
  colorscheme material-theme
endif

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
set foldcolumn=3 foldnestmax=4 foldminlines=8 foldlevelstart=3

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
" Also switch on highlighting the last used search pattern.
set hlsearch

" auto-write files
set autowriteall

if has("gui_running")
  set guifont=Fira\ Mono\ 10
  set lines=999 columns=999 " maybe the ugliest way to maximize a window
endif " gui running

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  augroup vim_config
    autocmd!

    autocmd BufWritePost $MYVIMRC source $MYVIMRC
    autocmd FileType vim setlocal tabstop=2 shiftwidth=2
  augroup END

  "augroup x_config
  "    autocmd!
  "    autocmd BufWritePost ~/.Xresources sh xrdb ~/.Xresources
  "augroup END

  augroup html
    autocmd!

    au BufNewFile,BufRead *.tpl set ft=html
    au BufNewFile,BufRead *.tpl set syntax=underscore_template
    au BufNewFile,BufRead *.html.twig set ft=html

    autocmd FileType html,jade setlocal tabstop=2 shiftwidth=2
    autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
  augroup END

  augroup javascript
    autocmd!

    autocmd FileType coffee,coffeescript setlocal tabstop=2 shiftwidth=2
    autocmd FileType javascript,coffee,coffeescript,typescript setlocal omnifunc=nodejscomplete#CompleteJS

    autocmd FileType javascript let b:syntastic_checkers = findfile('.jscsrc', '.;') != '' ? ['jscs', 'jshint'] : ['jshint']
  augroup END

  augroup json
      autocmd!

    autocmd BufEnter .js*rc,.sailsrc setfiletype json
  augroup END

  augroup css
      autocmd!

    autocmd FileType css,stylus,scss,sass,less setlocal tabstop=2 shiftwidth=2
    autocmd FileType css,stylus,scss,sass,less setlocal omnifunc=csscomplete#CompleteCSS
  augroup END

  augroup markdown
      autocmd!

    autocmd FileType markdown setlocal tabstop=2 shiftwidth=2
    autocmd FileType markdown setlocal omnifunc=htmlcomplete#CompleteTags

    "autocmd FileType text,markdown setlocal textwidth=80
  augroup END

  augroup php
    autocmd!

    autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
  augroup END

  augroup haskell
      autocmd!

      autocmd BufEnter *.hs compiler ghc
      let g:haskellmode_completion_ghc = 0
      autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
  augroup END

  augroup general
    autocmd!

    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif

    " Delete white space at end of line when save
    autocmd BufWritePre * :%s/\s\+$//e

    " auto save/load folding
    "autocmd BufWinLeave * mkview
    "autocmd BufWinEnter * silent loadview

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default position when opening a file.
    autocmd BufReadPost *
          \ if line("'\"") > 1 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif

    " Close NERDTree if this is the last buffer
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

  augroup END
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
set laststatus=2
set statusline=%6(%L%)\ \ %-3(%c%)
set statusline+=\ %<%f\ %Y,%{&fenc==\"\"?&enc:&fenc}\ %{strftime(\"%H:%M\",getftime(expand(\"%%\")))}
set statusline+=%=%m%r%{fugitive#statusline()}
set statusline+=\ %(%#warningmsg#%{SyntasticStatuslineFlag()}%*%)
