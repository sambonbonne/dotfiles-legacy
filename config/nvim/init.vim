if &compatible
  set nocompatible
endif

if has("nvim")
  let $NVIMHOME = fnamemodify($MYVIMRC, ':p:h')
else
  let $NVIMHOME = fnamemodify($MYVIMRC, ':p:h') . "/.config/nvim"
endif " has("nvim")

let mapleader = "\<Space>" " better than backslash

let s:plugin_manager_directory = $HOME . '/.cache/vim-plugins'
exec "set runtimepath+=" . s:plugin_manager_directory . '/repos/github.com/Shougo/dein.vim'

" plugin manager config
call dein#begin(expand(s:plugin_manager_directory))

call dein#add(s:plugin_manager_directory . '/repos/github.com/Shougo/dein.vim')
let g:dein#enable_notification = 1
let g:dein#notification_time = 3
call dein#add('haya14busa/dein-command.vim', { 'on_cmd': 'Dein', 'depends': 'dein.vim' })

call dein#add('Shougo/vimproc.vim', { 'build': 'make' })
call dein#add('tpope/vim-dispatch')

" Indentation
set expandtab    " use space instead of tab
set tabstop=2    " size of hard tab stop
set shiftwidth=2 " size of an indent
call dein#add('Yggdroot/indentLine') " indent can be visible
let g:indentLine_enabled = 1
let g:indentLine_fileTypeExclude = [ 'startify', 'netrw' ]
let g:indentLine_bufNameExclude = [ 'startify' ]
let g:indentLine_color_term = 239
let g:indentLine_char = '¦'
" indent with tab (normal/visual mode)
nnoremap <TAB> >>
nnoremap <S-TAB> <<
vnoremap <TAB> >gv
vnoremap <S-TAB> <gv
" re-indent file
function! IndentFile()
  echo "Identing the file..."
  let l:current_view=preserve#save()
  normal gg=Gg``
  call preserve#restore(l:current_view)
  echo "Indented."
endfunction " IndentAllFile()
nnoremap g= :call IndentFile()<Return>

" For multiusers projects
call dein#add('editorconfig/editorconfig-vim', { 'if': filereadable('.editorconfig') })
let g:EditorConfig_exclude_patterns = [ 'fugitive://.*', 'scp://.*' ]

" Please, don't cry to me if save dir doesn't exists
call dein#add('duggiefresh/vim-easydir', { 'on_event': [ 'BufWritePre', 'FileWritePre' ] })
" And maybe we can save quickly
nnoremap <Leader>w :w<CR>
nnoremap <Leader><Leader> :w<CR>

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
      \ [ '(>°^°)>        You are working on it' ],
      \ 'sessions',
      \ [ '(♥_♥)          It seems you love this places' ],
      \ 'bookmarks',
      \ [ '(⌐■_■)         You edited this here' ],
      \ 'dir',
      \ [ '(╯°□°)╯︵┻━┻   Did you ragequit this files?' ],
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

" Plugin repeating
call dein#add('tpope/vim-repeat')

" More informations on the command line
call dein#add('Shougo/echodoc.vim')
let g:echodoc_enabled_at_startup = 1

" Terminal integration
call dein#add('wincent/terminus')

" Clipboard and pasting
set clipboard=unnamedplus

" number switch to relative or not
call dein#add('jeffkreeftmeijer/vim-numbertoggle')
set number
set scrolloff=8 sidescrolloff=4

" All tags
let g:auto_generate_tags = 1
call dein#add('fntlnz/atags.vim', { 'if': has('nvim') })
call dein#add('xolox/vim-misc', { 'if': !has('nvim') })
call dein#add('xolox/vim-easytags', { 'if': !has('nvim'), 'depends': 'vim-misc' })
if has("nvim")
  let g:atags_build_commands_list = [
        \ "ctags -R -f 2>/dev/null | awk 'length($0) < 400' > tags"
        \ ]
  let g:atags_quiet = 1

  let g:atags_is_building = 0

  function! TagsBuilded() " need a global function ...
    let g:atags_is_building = 0
  endfunction " s:TagBuilded

  let g:atags_on_generate_exit = 'TagsBuilded'

  function! s:BuildTags()
    if !g:auto_generate_tags
      return 0
    endif " !g:auto_generate_tags

    if g:atags_is_building
      return 0
    endif " g:atags_is_building

    if isdirectory(getcwd() . '/.git/')
      let g:atags_is_building = 1
      call atags#generate()
    endif " isdirectory(getcwd() . '/.git/')

    return 1
  endfunction " s:BuildTags

  autocmd VimEnter * call atags#setup()
  autocmd BufWritePost * call s:BuildTags() " Neovim always as autocmd
else
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
endif " has("nvim")
call dein#add('majutsushi/tagbar', { 'on_cmd': 'TagbarToggle' })
nnoremap <Leader>t :TagbarToggle<CR>

" Lot of things with Unite/Denite (depending on Vim/Neovim)
call dein#add('Shougo/unite.vim', {
      \ 'if': !has('nvim')
      \ })
call dein#add('Shougo/denite.nvim', {
      \ 'if': has('nvim'),
      \ 'hook_post_source': join([
      \   "call denite#custom#var('file_rec', 'command', [ 'scantree.py' ])"
      \ ], '\n')
      \ })
call dein#add('Shougo/neoyank.vim')
if !has('nvim')
  " buffers list
  nnoremap <Leader>b :Unite -quick-match buffer<CR>
  command! Buffers :Unite buffer
  " registers and yank history
  let g:unite_source_history_yank_enable = 1
  nnoremap <Leader>y :Unite -quick-match history/yank<CR>
  nnoremap <Leader>r :Unite register<CR>
  " File/content search
  nnoremap <Leader>f :Unite file_rec/async<CR>
  command! Search :Unite grep
  " Jumps list
  nnoremap <Leader>j :Unite -quick-match jump

  " On split, open file search
  nnoremap _ :split<CR>:Unite file_rec/async<CR>
  nnoremap <Bar> :vsplit<CR>:Unite file_rec/async<CR>
else
  " buffers list
  nnoremap <Leader>b :Denite buffer<CR>
  command! Buffers :Denite buffer

  " current buffer lines
  nnoremap <Leader>/ :Denite buffer "forward"<CR>
  nnoremap <Leader>? :Denite buffer "backward"<CR>

  " registers and yank history
  let g:unite_source_history_yank_enable = 1
  nnoremap <Leader>y :Denite neoyank<CR>
  nnoremap <Leader>r :Denite register<CR>
  nnoremap <Leader>c :Denite change<CR>

  " File/content search
  nnoremap <Leader>f :Denite file_rec<CR>
  nnoremap <Leader><Return> :Denite file_rec<CR>
  "command! Search :Denite grep<CR>

  " Jumps list
  nnoremap <Leader>j :Denite jump<CR>

  " On split, open file search
  nnoremap _ :split<CR>:Denite file_rec<CR>
  nnoremap <Bar> :vsplit<CR>:Denite file_rec<CR>
endif

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
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'

" First, auto-close brackets, quotes ... Second, auto-close tags, third change surrounds
call dein#add('jiangmiao/auto-pairs')
call dein#add('alvan/vim-closetag', { 'on_ft': [ 'xml', 'html' ] })
let g:closetag_filenames = "*.xml,*.html,*.tpl,*.hbs,*.blade.php"
call dein#add('tpope/vim-surround') " cs like Change Surround, ds like Delete Surround

" search improvements
set incsearch " do incremental searching
call dein#add('haya14busa/incsearch.vim', { 'on_map': [ '<Plug>(incsearch-stay)', '<Plug>(incsearch-forward)', '<Plug>(incsearch-backward)' ] })
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
" please, the default n/N behavior is ugly
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]

" undo/redo improve
call dein#add('mbbill/undotree', { 'on_cmd': [ 'UndotreeToggle', 'UndotreeShow', 'UndotreeFocus' ] })
nnoremap <Leader>u :UndotreeToggle<CR>
if has("persistent_undo")
  set undolevels=2048 undodir=~/.undodir/
  set undofile
endif

" Better splits management
call dein#add('zhaocai/GoldenView.Vim') " @TODO replace with golden-ratio?
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
if has("nvim") " issue https://github.com/neovim/neovim/issues/2048 (fixed in 0.2)
  tnoremap <C-H> <C-\><C-N><C-W>h
  tnoremap <C-J> <C-\><C-N><C-W>j
  tnoremap <C-K> <C-\><C-N><C-W>k
  tnoremap <C-L> <C-\><C-N><C-W>l
endif " has("nvim")

" Faster editing
set foldmethod=indent
set foldcolumn=3 foldnestmax=8 foldminlines=8 foldlevelstart=2
set foldopen+=jump
call dein#add('Konfekt/FastFold')
nmap <SID>(DisableFastFoldUpdate) <Plug>(FastFoldUpdate)

" Advanced moves
call dein#add('Lokaltog/vim-easymotion', { 'on_map': '<Plug>(easymotion-prefix)' })
let g:EasyMotion_do_mapping = 1
let g:EasyMotion_smartcase = 1
nmap <Return> <Plug>(easymotion-prefix)
vmap <Return> <Plug>(easymotion-prefix)
nmap <Leader>m <Plug>(easymotion-prefix)
vmap <Leader>m <Plug>(easymotion-prefix)
call dein#add('wellle/targets.vim')

" Syntax checking
call dein#add('neomake/neomake')
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
"let g:neomake_javascript_enabled_makers = [ 'eslint' ]
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

" Syntax and language detection
call dein#add('sheerun/vim-polyglot') " There is a grate quantity of languages in this
let g:javascript_plugin_jsdoc = 1
call dein#add('othree/javascript-libraries-syntax.vim', { 'on_ft': 'javascript' })

" Completion
source $NVIMHOME/completion.vim

" Others languages/technos utils
call dein#add('chrisbra/csv.vim', { 'on_ft': 'csv' })
call dein#add('timonv/vim-cargo', { 'on_ft': 'rust' })
call dein#add('lervag/vimtex', { 'on_ft': [ 'tex', 'latex', 'plaintex' ] })
call dein#add('alcesleo/vim-uppercase-sql', { 'on_ft': 'sql' })

" Some Unix commands directly inside the editor
call dein#add('tpope/vim-eunuch')

" Mispelling is so common ...
call dein#add('reedes/vim-litecorrect', { 'on_func': 'litecorrect#init()' })

" Some colors
call dein#add('NLKNguyen/papercolor-theme')
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

call dein#end()
" End plugins config

if dein#check_install()
  call dein#install() | call dein#recache_runtimepath()
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
if has("termguicolors")
  set termguicolors
elseif has('patch-7.4.1778')
  set guicolors
elseif has("nvim")
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
else
  set t_Co=256
endif
set background=dark
if &diff
  colorscheme wellsokai
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

" command completion
set wildmenu wildmode=list:longest,full wildignore=*~,*.swp,*.o,*.pdf

" conceal
set conceallevel=0
set concealcursor="nc"

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
if has("nvim")
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
endif " has("nvim")

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
set colorcolumn=80,100

" more natural split opening
set splitbelow splitright

" yes, I'm really lazy
nnoremap ; :

" remap comma and invert with <C->
nnoremap , ;
nnoremap <C-,> ,

" toggle hlsearch
nnoremap // :nohlsearch<CR>

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
inoremap <C-C> <Esc>:w<CR>

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

" better terminal support
function! OpenSpecificTerminal()
  let l:ft = tolower(&ft)

  if l:ft =~ 'javascript' || l:ft =~ 'js'
    vsplit term://node
  elseif l:ft =~ 'py'
    vsplit term://python
  else
    vsplit term://bash
  endif " l:ft

  startinsert
endfunction " OpenSpecificTerminal()
if has('nvim')
  command! Terminal call OpenSpecificTerminal()
  command! T Terminal
  command! Shell vsplit term://bash
endif " has(':terminal')

" What if I have custom commands ?
command! FilePath echo @%
command! ConfReload source $MYVIMRC

" Abbreviations
source $NVIMHOME/abbreviations.vim

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

    " Display max column only on focus
    autocmd WinLeave * set colorcolumn=
    autocmd WinEnter * set colorcolumn=80,100

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
" TabLine config
source $HOME/dev/dotfiles/config/nvim/tabline.vim
command! SourceNewTabline source $HOME/dev/dotfiles/config/nvim/tabline.vim
