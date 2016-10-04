if &compatible
  set nocompatible
endif

if has("nvim")
  let $NVIMHOME = fnamemodify($MYVIMRC, ':p:h')
else
  let $NVIMHOME = fnamemodify($MYVIMRC, ':p:h') . "/.config/nvim"
endif " has("nvim")

let mapleader = "\<Space>" " better than backslash

let s:plugin_manager_directory = $NVIMHOME . '/plugins'
exec "set runtimepath+=" . s:plugin_manager_directory . "/repos/github.com/Shougo/dein.vim"

" vim-plug config
call dein#begin(expand(s:plugin_manager_directory))

call dein#add('Shougo/dein.vim')
call dein#add('haya14busa/dein-command.vim', { 'on_cmd': 'Dein', 'depends': 'dein.vim' })

call dein#add('Shougo/vimproc.vim', { 'build': 'make' })
call dein#add('tpope/vim-dispatch')

" Indentation
"call dein#add('vim-scripts/yaifa.vim') " detect indent
set expandtab    " use space instead of tab
set tabstop=2    " size of hard tab stop
set shiftwidth=2 " size of an indent
call dein#add('Yggdroot/indentLine') " indent can be visible
let g:indentLine_enabled = 1
let g:indentLine_color_term = 239
let g:indentLine_char = '¦'
" indent with tab (normal/visual mode)
nnoremap <TAB> >>
nnoremap <S-TAB> <<
vnoremap <TAB> >gv
vnoremap <S-TAB> <gv
" re-indent file
function IndentFile()
  echo "Identing the file..."
  let l:current_view=preserve#save()
  normal gg=Gg``
  call preserve#restore(l:current_view)
  echo "Indented."
endfunction " IndentAllFile()
nnoremap g= :call IndentFile()<Return>

" To add .lvimrc for each project you want
call dein#add('embear/vim-localvimrc')
let g:localvimrc_ask=0
" For multiusers projects
call dein#add('editorconfig/editorconfig-vim')
let g:EditorConfig_exclude_patterns = [ 'fugitive://.*', 'scp://.*' ]

" Please, don't cry to me if save dir doesn't exists
call dein#add('duggiefresh/vim-easydir', { 'on_event': [ 'BufWritePre', 'FileWritePre' ] })
" And maybe we can save quickly
nnoremap <Leader>w :w<CR>

" Let's start nice and manage sessions
call dein#add('mhinz/vim-startify')
let g:startify_custom_header = [
      \ "                                                          {",
      \ "                                                       {   }",
      \ "o      O                 .oOOOo.                        }_{ __{",
      \ "O      o                 o     o                     .-{   }   }-.",
      \ "o      O                 O.                         (   }     {   )",
      \ "OoOooOOo                  `OOoo.                    |`-.._____..-’|",
      \ "o      O .oOo. O   o           `O .oOoO' `oOOoOO.   |             ;--.",
      \ "O      o OooO' o   O            o O   o   O  o  o   |            (__  \\",
      \ "o      o O     O   o     O.    .O o   O   o  O  O   |             | )  )",
      \ "o      O `OoO' `OoOO      `oooO'  `OoO'o  O  o  o   |             |/  /",
      \ "                   o                                |             /  /",
      \ "                OoO'                                |            (  /",
      \ "                                                    \\             y’",
      \ "                                                     `-.._____..-'",
      \ ]
let g:startify_custom_footer = [
      \ "You reached the end of this screen, what will you do?"
      \ ]
let g:startify_list_order = [
      \ [ '(>°^°)>         You are working on it' ],
      \ 'sessions',
      \ [ '(♥_♥)           It seems you love this places' ],
      \ 'bookmarks',
      \ [ '(⌐■_■)          You edited this here' ],
      \ 'dir',
      \ [ '(╯°□°)╯︵┻━┻    Did you ragequit this files?' ],
      \ 'files'
      \ ]
set sessionoptions=blank,curdir,folds,help,options,localoptions,tabpages,winsize
let g:startify_session_dir = $NVIMHOME . '/sessions'
let g:startify_session_autoload = 0
let g:startify_session_persistence = 1
let g:startify_files_number = 5
let g:startify_bookmarks = [
      \ '~/dev',
      \ '~/dev/dotfiles',
      \ '~/dev/www',
      \ $MYVIMRC
      \ ]
let g:startify_change_to_dir = 1
let g:startify_change_to_vcs_root = 0

" And auto save and restore views
call dein#add('kopischke/vim-stay')
set viewoptions=cursor,folds,slash,unix

" Edit macros
call dein#add('dohsimpson/vim-macroeditor', { 'on_cmd': 'MacroEdit' })

" Plugin repeating
call dein#add('tpope/vim-repeat')

" More informations on the command line
call dein#add('Shougo/echodoc.vim')
let g:echodoc_enabled_at_startup = 1

" Perfect tabline
call dein#add('mkitt/tabline.vim')
set showtabline=2

" Clipboard and pasting
call dein#add('ConradIrwin/vim-bracketed-paste')

" number switch to relative or not
call dein#add('jeffkreeftmeijer/vim-numbertoggle')
set number
set scrolloff=8 sidescrolloff=4

" All tags
call dein#add('xolox/vim-misc')
call dein#add('xolox/vim-easytags', { 'depends': 'vim-misc' })
let g:easytags_async = 1
let g:easytags_auto_highlight = 0
let g:easytags_on_cursorhold = 0
"set cpoptions+=d
"let g:easytags_dynamic_files = 2
let g:easytags_languages = {
      \   'php' : {
      \     'args': [ '--fields=+aimlS', '--languages=php' ],
      \   }
      \ }
call dein#add('majutsushi/tagbar', { 'on_cmd': 'TagbarToggle' })
nnoremap <Leader>t :TagbarToggle<CR>

" Lot of things with Unite
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/neoyank.vim', { 'depends': 'unite.vim' })
" buffers list
nnoremap <Leader>b :Unite -quick-match buffer<cr>
command! Buffers :Unite buffer
" registers and yank history
let g:unite_source_history_yank_enable = 1
nnoremap <Leader>y :Unite -quick-match history/yank<cr>
nnoremap <Leader>r :Unite register<cr>
" File/content search
nnoremap <Leader>f :Unite file_rec/async<cr>
command! Search :Unite grep
" Jumps list
nnoremap <Leader>j :Unite -quick-match jump

" How about a stack yanking ?
call dein#add('bfredl/nvim-miniyank', {
      \ 'on_if': has("nvim"),
      \ 'hook_source': join([
      \   'let g:miniyank_filename = "' . $NVIMHOME . '/.miniyank.mpack"',
      \   'nmap p <Plug>(miniyank-autoput)',
      \   'nmap P <Plug>(miniyank-autoPut)',
      \   'nmap <Leader>n <Plug>(miniyank-cycle)',
      \ ], "\n")
      \ })

" Same as Unite but for Neovim, in development
call dein#add('Shougo/denite.nvim', { 'on_if': has("nvim") })

" A better file manager
call dein#add('Shougo/vimfiler.vim')
let g:vimfiler_as_default_explorer = 1
nnoremap <Leader>e :VimFilerExplorer -toggle -buffer-name='vimfiler_tree'<CR>

" Highlight whitespace
call dein#add('bronson/vim-trailing-whitespace')

" Easy align
call dein#add('junegunn/vim-easy-align', { 'on_map': '<Plug>(EasyAlign)' })
vmap a <Plug>(EasyAlign)

" Comment better
call dein#add('scrooloose/nerdcommenter')

" First, auto-close brackets, quotes ... Second, auto-close tags, third change surrounds
call dein#add('jiangmiao/auto-pairs')
call dein#add('alvan/vim-closetag') " don't put 'for', it won't work at all
let g:closetag_filenames = "*.xml,*.html,*.tpl,*.hbs,*.blade.php"
call dein#add('tpope/vim-surround') " cs like Change Surround, ds like Delete Surround

" Snippets
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets', { 'depends': 'neosnippet' })
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" search improvements
set incsearch " do incremental searching
call dein#add('haya14busa/incsearch.vim', { 'on_map': [ '<Plug>(incsearch-stay)', '<Plug>(incsearch-forward)', '<Plug>(incsearch-backward)' ] })
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
" please, the default n/N behavior is ugly
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]

" Replace and undo/redo improve
call dein#add('tpope/vim-abolish', { 'on_cmd': [ 'Abolish', 'Subvert' ] }) " :Abolish{despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}, :Subvert/pattern/subtitute/g
call dein#add('mbbill/undotree', { 'on_cmd': [ 'UndotreeToggle', 'UndotreeShow', 'UndotreeFocus' ] })
nnoremap <Leader>u :UndotreeToggle<CR>
if has("persistent_undo")
  set undolevels=2048 undodir=~/.undodir/
  set undofile
endif

" Better splits management
call dein#add('AndrewRadev/undoquit.vim')
call dein#add('zhaocai/GoldenView.Vim')
let g:goldenview__enable_default_mapping = 0
nnoremap <C-H> <C-W>h
vnoremap <C-H> <C-W>h
nnoremap <BS> <C-W>h " tmp fix for neovim/neovim#2048
vnoremap <BS> <C-W>h " tmp fix for neovim/neovim#2048
nnoremap <C-J> <C-W>j
vnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
vnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
vnoremap <C-L> <C-W>l
if has("nvim")
  tnoremap <C-H> <C-\><C-N><C-W>h
  tnoremap <C-J> <C-\><C-N><C-W>j
  tnoremap <C-K> <C-\><C-N><C-W>k
  tnoremap <C-L> <C-\><C-N><C-W>l
endif " has("nvim")

" Faster editing
call dein#add('Konfekt/FastFold')

" Advanced moves
call dein#add('Lokaltog/vim-easymotion', { 'on_map': '<Plug>(easymotion-prefix)' })
let g:EasyMotion_do_mapping = 1
let g:EasyMotion_smartcase = 1
nmap <Return> <Plug>(easymotion-prefix)
vmap <Return> <Plug>(easymotion-prefix)
nmap <Leader>m <Plug>(easymotion-prefix)
vmap <Leader>m <Plug>(easymotion-prefix)
call dein#add('bkad/CamelCaseMotion')
call dein#add('wellle/targets.vim')

" Better selection expanding
call dein#add('terryma/vim-expand-region')

" Syntax checking
call dein#add('benekastah/neomake')
let g:neomake_error_sign = {
            \ 'text': '!',
            \ 'texthl': 'ErrorSign',
            \ }
let g:neomake_warning_sign = {
            \ 'text': '?',
            \ 'texthl': 'WarningSign',
            \ }
let g:neomake_open_list = 2
let g:neomake_list_height = 4
let g:neomake_javascript_enabled_makers = [ 'eslint' ]
function! NeomakeOpenList()
  if (g:neomake_open_list > 0)
    let g:neomake_open_list = 0
  else
    let g:neomake_open_list = 2
  endif
endfunction
command! NeomakeListToggleAuto call NeomakeOpenList()

call dein#add('Valloric/ListToggle')
let g:lt_location_list_toggle_map = '<Leader>l'
let g:lt_quickfix_list_toggle_map = '<Leader>q'
let g:lt_height = g:neomake_list_height

" Git wrapping and symbols
call dein#add('tpope/vim-fugitive')
call dein#add('airblade/vim-gitgutter')

" We want to build
call dein#add('KabbAmine/gulp-vim', { 'on_cmd': ['Gulp', 'GulpExt', 'GulpFile', 'GulpTasks'] })
call dein#add('mklabs/grunt.vim',   { 'on_cmd': ['Grunt', 'Gtask', 'Gtest', 'Glint', 'Gdoc'] })

" Syntax and language detection
call dein#add('sheerun/vim-polyglot') " There is a grate quantity of languages in this
call dein#add('othree/javascript-libraries-syntax.vim', { 'on_ft': 'javascript' })
call dein#add('aaronj1335/underscore-templates.vim')
call dein#add('hhvm/vim-hack', { 'on_ft': ['hh', 'hack', 'php'] })
call dein#add('vim-scripts/bash-support.vim', { 'on_ft': ['shell', 'sh', 'bash'] })
call dein#add('PotatoesMaster/i3-vim-syntax')

" Completion
source $NVIMHOME/completion.vim

" Others languages/technos utils
call dein#add('chrisbra/csv.vim', { 'on_ft': 'csv' })
call dein#add('timonv/vim-cargo', { 'on_ft': 'rust' })
call dein#add('lervag/vimtex', { 'on_ft': [ 'tex', 'latex', 'plaintex' ] })

" Some Unix commands directly inside the editor
call dein#add('tpope/vim-eunuch')

" Launch test in Vim
call dein#add('janko-m/vim-test', { 'depends': 'vim-dispatch' })
if has("nvim")
  let test#strategy = "neovim"
else
  let test#strategy = "dispatch"
endif " has("nvim")

" Mispelling is so common ...
call dein#add('reedes/vim-litecorrect') ", { 'on_func': 'litecorrect#init()' }

" Some colors
call dein#add('NLKNguyen/papercolor-theme')
call dein#add('jdkanani/vim-material-theme')
call dein#add('joshdick/onedark.vim')
call dein#add('wellsjo/wellsokai.vim')

" Highlight hex colors
call dein#add('vim-scripts/colorizer', { 'on_ft': [ 'html', 'tpl', 'markdown', 'md' ] })
let g:colorizer_nomap = 1

" Less distraction
call dein#add('junegunn/limelight.vim', { 'on_cmd': 'Limelight' })
let g:limelight_conceal_ctermfg = 240
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_paragraph_span = 3

" Maybe you want to learn something new
call dein#add('mhinz/vim-randomtag', { 'on_cmd': 'Random' })

" code with your friends
call dein#add('floobits/floobits-neovim', { 'on_if': has("nvim") })

call dein#end()
" End plugins config

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax on

" encoding
if !has('nvim')
  set encoding=utf-8
endif
setglobal fileencoding=utf-8

" disable the old Ex mode
nnoremap Q <nop>

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" end of line format
set fileformat=unix

" can hide edited buffers
set hidden

" Some colors configuration
set t_Co=256
set background=dark
if &diff
  colorscheme wellsokai
elseif has("gui_running")
  colorscheme material-theme
else
  colorscheme PaperColor
endif
set synmaxcol=500

source $NVIMHOME/highlight.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=64 " keep some lines of command line history
set showcmd   " display incomplete commands

" fold method to indent, fold config
set foldmethod=indent
set foldcolumn=3 foldnestmax=4 foldminlines=8 foldlevelstart=2
set foldopen+=jump

" command completion
set wildmenu wildmode=list:longest,full wildignore=*~,*.swp,*.o,*.pdf

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=nvc
endif

" improve rendering
if !has("nvim")
  set ttyfast " modern terminals force it but just in case ...
endif " !has("nvim")
set lazyredraw

" highlight line, light line number
set cursorline
command! CursorColumn set cursorcolumn!
" Also switch on highlighting the last used search pattern.
set hlsearch
" And change cursor type when inserting
if !has("nvim")
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
endif " !has("nvim")

if has("gui_running")
  set guifont=Fira\ Mono\ 10
  set lines=999 columns=999 " maybe the ugliest way to maximize a window
endif " gui running

" search what you visually selected
vnoremap // y/<C-R>"<CR>

" spell, that's something great
set spelllang=fr,en nospell
nnoremap <silent> <Leader>s :set spell!<CR>

" move cursor after line end
set virtualedit=onemore

" disable automatic line breaking while inserting
set textwidth=0 wrapmargin=0
set linebreak

" more natural split opening
set splitbelow splitright

" yes, I'm really lazy
nnoremap ; :

" remap comma and invert with <C->
nnoremap , ;
nnoremap <C-,> ,

" toggle hlsearch
nnoremap <Leader>/ :nohlsearch<CR>

" press space to insert a single char before cursor
nmap <Leader>i i_<Esc>r

" start/end of line in insert and command mode
inoremap <C-A> <Esc><S-I>
inoremap <C-E> <Esc><S-A>
cnoremap <C-A> <Home>
cnoremap <C-E> <End>

" move in insert mode
inoremap <M-H> <C-O>h
inoremap <M-J> <C-O>j
inoremap <M-K> <C-O>k
inoremap <M-L> <C-O>l

" better tabs usage
nnoremap <S-T> :tabnew<CR>:Explore<CR>
nnoremap <S-H> gT
nnoremap <S-L> gt

" location list really quick
nnoremap <Leader>> :lnext<CR>
nnoremap <Leader>< :lprev<CR>
nnoremap <Leader>? :lrewind<CR>

" <C-C> doesn't trigger InsertLeave ...
inoremap <C-C> <Esc>

" Neovim terminal is good but going out of it is a pain in the ass
if has("nvim")
  tnoremap <C-T> <C-\><C-N>
endif " has("nvim")

" You want to quit quickly
source $NVIMHOME/quickquit.vim
nmap <C-Q> <Plug>(QuickQuitBuffer)
nmap <S-Q> <Plug>(QuickQuitTab)
"nmap <C-S-Q> <Plug>(QuickQuitAll)
" please we all hate this fucking command window
nnoremap q: :q

" better matching with %
if !exists('g:loaded_matchit')
  runtime macros/matchit.vim
endif

" :Man command, very usefull
if !exists('g:loaded_man')
  runtime ftplugin/man.vim
endif

" What if I have custom commands ?
command! FilePath echo @%
command! ConfReload source $MYVIMRC

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  set noshowmode

  augroup startify
    autocmd!

    autocmd FileType startify setlocal nofoldenable
  augroup END

  "augroup x_config
  "    autocmd!
  "    autocmd BufWritePost ~/.Xresources sh xrdb ~/.Xresources
  "augroup END

  augroup javascript_completion
    autocmd!

    autocmd FileType coffee,coffeescript setlocal tabstop=2 shiftwidth=2
    autocmd FileType javascript,coffee,coffeescript,typescript setlocal omnifunc=tern#Complete
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

  augroup python
    autocmd!

    autocmd FileType python setlocal omnifunc=jedi#completions
  augroup END

  augroup positions_registers
    autocmd!

    let g:last_positions_registers = {
          \   'insert':  'i',
          \   'replace': 'r',
          \   'normal':  'n'
          \ }

    function! InsertPositionRegister(mode)
      if a:mode == 'i'
        exe "normal m" . g:last_positions_registers.insert
      else
        exe "normal m" . g:last_positions_registers.replace
      endif
    endfunction

    autocmd InsertEnter  * call InsertPositionRegister(v:insertmode)
    autocmd InsertChange * call InsertPositionRegister(v:insertmode)
    autocmd InsertLeave  * exe "normal m" . g:last_positions_registers.insert
  augroup END

  augroup semicolon_langages
    autocmd!

    autocmd FileType php,c,cpp,javascript,typescript inoremap ;; <C-O>A;
    autocmd FileType php,c,cpp,javascript,typescript inoremap ;<CR> <C-O>A;<CR>
    autocmd FileType php,c,cpp,javascript,typescript inoremap ;<Esc> <C-O>A;<Esc>
  augroup END

  augroup distraction
    autocmd!

    autocmd InsertEnter  * set nocursorline nocursorcolumn | Limelight
    autocmd InsertChange * set nocursorline nocursorcolumn | Limelight
    autocmd InsertLeave  * set cursorline | call preserve#execute('Limelight!', 1)

    autocmd WinEnter * setlocal cursorline foldcolumn=3
    autocmd WinLeave * setlocal nocursorline foldcolumn=0
  augroup END

  augroup compilation
    autocmd!

    " Run Neomake on write
    autocmd! BufWritePost * Neomake
  augroup END

  augroup general
    autocmd!

    " Delete white space at end of line when save
    autocmd BufWritePre * :FixWhitespace

    " Center view on cursor before winleave
    autocmd WinLeave * normal zz

    " QuickFix not in buffers list
    autocmd FileType qf set nobuflisted

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
  set cmdheight=2 " echodoc would be hidden by mode indicator
  set autoindent
  set omnifunc=syntaxcomplete#Complete
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

" Statusline config
source $NVIMHOME/statusline.vim
