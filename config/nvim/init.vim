" vim-plug no installed ? We can do it for you
if empty(glob("~/.config/nvim/autoload/plug.vim"))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
              \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  if has("autocmd")
      autocmd VimEnter * PlugInstall | source $MYVIMRC
  endif
endif

" vim-plug config
call plug#begin()
Plug 'Shougo/vimproc.vim'

" To add .lvimrc for each project you want
Plug 'embear/vim-localvimrc'
let g:localvimrc_ask=0

" Let's start nice and manage sessions
Plug 'mhinz/vim-startify'
function! s:startify_center_header(lines) abort " this function will center your header !
let longest_line   = max(map(copy(a:lines), 'len(v:val)'))
  let centered_lines = map(copy(a:lines),
        \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
  return centered_lines
endfunction
let g:startify_custom_header = s:startify_center_header([
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
      \ ])
let g:startify_custom_footer = s:startify_center_header([
      \ "You reached the end of this screen, what will you do?"
      \ ])
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
let g:startify_session_dir = '~/.vim/sessions'
let g:startify_session_autoload = 0
let g:startify_session_persistence = 1
let g:startify_files_number = 5
let g:startify_bookmarks = [
      \ '~/dev/www/catalisio/v1',
      \ '~/dev/www/catalisio/common/',
      \ '~/dev/www/catalisio/tools/'
      \ ]
let g:startify_change_to_dir = 1
let g:startify_change_to_vcs_root = 0

" And auto save and restore views
Plug 'kopischke/vim-stay'
set viewoptions=cursor,folds,slash,unix

" Perfect tabline
Plug 'mkitt/tabline.vim'
set showtabline=2

" Clipboard and pasting
Plug 'ConradIrwin/vim-bracketed-paste'

" number switch to relative or not
Plug 'jeffkreeftmeijer/vim-numbertoggle'
set scrolloff=8 sidescrolloff=4

" All tags
Plug 'xolox/vim-misc' | Plug 'xolox/vim-easytags'
let g:easytags_async = 1
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
nnoremap <Leader>t :TagbarToggle<CR>

" Lot of things with Unite
Plug 'Shougo/unite.vim' | Plug 'Shougo/neoyank.vim'
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

" A better file manager
Plug 'Shougo/vimfiler.vim', { 'on': ['Explore', 'VimFilerExplorer'] }
let g:vimfiler_as_default_explorer = 1
nnoremap <Leader>e :VimFilerExplorer -toggle -buffer-name='vimfiler_tree'<CR>

" Detect indentation and set defaults
Plug 'vim-scripts/yaifa.vim'
set expandtab    " use space instead of tab
set tabstop=4    " size of hard tab stop
set shiftwidth=4 " size of an "indent"

" Highlight whitespace
Plug 'bronson/vim-trailing-whitespace'

" Easy align
Plug 'junegunn/vim-easy-align', { 'on': '<Plug>(EasyAlign)' }
vmap <Enter> <Plug>(EasyAlign)

" Comment better
Plug 'scrooloose/nerdcommenter'

" First, auto-close brackets, quotes ... Second, auto-close tags, third change surrounds
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag' " don't put 'for', it won't work at all
let g:closetag_filenames = "*.xml,*.html,*.tpl,*.hbs,*.blade.php"
Plug 'tpope/vim-surround' " cs like Change Surround, ds like Delete Surround

" Snippets
Plug 'Shougo/neosnippet' | Plug 'Shougo/neosnippet-snippets'
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" Replace and undo/redo improve
Plug 'osyo-manga/vim-over' " highlight while writing a regex
Plug 'tpope/vim-abolish', { 'on': ['Abolish', 'Subvert'] } " :Abolish{despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}, :Subvert/pattern/subtitute/g
Plug 'mbbill/undotree', { 'on': ['UndotreeToggle', 'UndotreeShow', 'UndotreeFocus'] }
nnoremap <Leader>u :UndotreeToggle<CR>
"nmap <Leader>u :UndotreeToggle<CR>
if has("persistent_undo")
  set undolevels=2048 undodir=~/.undodir/
  set undofile
endif

" Better splits management
Plug 'AndrewRadev/undoquit.vim'
Plug 'zhaocai/GoldenView.Vim'
let g:goldenview__enable_default_mapping = 0
nnoremap <C-H> <C-W>h
vnoremap <C-H> <C-W>h
tnoremap <C-H> <C-\><C-N><C-W>h
nnoremap <C-J> <C-W>j
vnoremap <C-J> <C-W>j
tnoremap <C-J> <C-\><C-N><C-W>j
nnoremap <C-K> <C-W>k
vnoremap <C-K> <C-W>k
tnoremap <C-K> <C-\><C-N><C-W>k
nnoremap <C-L> <C-W>l
vnoremap <C-L> <C-W>l
tnoremap <C-L> <C-\><C-N><C-W>l

" Faster editing
Plug 'Konfekt/FastFold'

" Advanced moves
Plug 'Lokaltog/vim-easymotion', { 'on': '<Plug>(easymotion-prefix)' }
let g:EasyMotion_do_mapping=1
let g:EasyMotion_smartcase=1
nmap <Leader>m <Plug>(easymotion-prefix)
vmap <Leader>m <Plug>(easymotion-prefix)
Plug 'bkad/CamelCaseMotion'

" Better selection expanding
Plug 'terryma/vim-expand-region'

" Syntax checking
Plug 'benekastah/neomake'
let g:neomake_error_sign = {
            \ 'text': '!',
            \ 'texthl': 'ErrorMsg',
            \ }
let g:neomake_warning_sign = {
            \ 'text': '?',
            \ 'texthl': 'WarningMsg',
            \ }
let g:neomake_open_list = 2
let g:neomake_list_height = 4
function! NeomakeOpenList()
  if (g:neomake_open_list > 0)
    let g:neomake_open_list = 0
  else
    let g:neomake_open_list = 2
  endif
endfunction
command! NeomakeListToggleAuto call NeomakeOpenList()

" Git wrapping and symbols
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Man pages on the editor
Plug 'bruno-/vim-man', { 'on': ['Man', 'Mangrep'] }

" Edit markdown can be fun
function! BuildMarkdownComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    !cargo build --release
    UpdateRemotePlugins
  endif
endfunction
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildMarkdownComposer') }

" We want to build
Plug 'KabbAmine/gulp-vim', { 'on': ['Gulp', 'GulpExt', 'GulpFile', 'GulpTasks'] }
Plug 'mklabs/grunt.vim', { 'on': ['Grunt', 'Gtask', 'Gtest', 'Glint', 'Gdoc'] }

" Syntax and language detection
Plug 'sheerun/vim-polyglot' " There is a grate quantity of languages in this
Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
Plug 'aaronj1335/underscore-templates.vim'
Plug 'hhvm/vim-hack', { 'for': ['hh', 'hack', 'php'] }
Plug 'vim-scripts/bash-support.vim', { 'for': ['shell', 'sh', 'bash'] }
Plug 'PotatoesMaster/i3-vim-syntax'

" Completion
set completeopt=longest,menuone,noselect
Plug 'Shougo/deoplete.nvim' | Plug 'Shougo/neoinclude.vim'
let g:deoplete#enable_at_startup = 1
let g:deoplete#max_list = 20
let g:deoplete#max_menu_width = 80
let g:deoplete#sources = {}
let g:deoplete#sources._ = ['member', 'tag', 'omni', 'neosnippet', 'buffer', 'file']
let g:deoplete#sources.javascript = ['ternjs', 'buffer', 'neosnippet']
let g:deoplete#sources.python     = ['jedi', 'neosnippet']
let g:deoplete#sources.php        = ['omni', 'member', 'tag', 'neosnippet', 'buffer', 'file']
let g:deoplete#sources.vim        = ['vim', 'buffer', 'neosnippet']
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-D>"

" Completion engines
"Plug 'ternjs/tern_for_vim', { 'for': 'javascript', 'do': 'npm install' } |
Plug 'carlitux/deoplete-ternjs', { 'for': 'javascript', 'do': 'npm install tern -g'}
"Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'zchee/deoplete-jedi', { 'for': 'python', 'do': 'pip3 install --user --upgrade jedi' }
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_select_first = 0
let g:jedi#goto_command = "<leader>g"
let g:jedi#goto_assignments_command = ""
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "<leader>d"
let g:jedi#usages_command = ""
let g:jedi#completions_command = ""
let g:jedi#rename_command = "<leader>r"
Plug 'shawncplus/phpcomplete.vim', { 'for': 'php' }
Plug 'Shougo/neco-vim'
Plug 'pekepeke/titanium-vim'

" Others languages/technos utils
Plug 'chrisbra/csv.vim', { 'for': 'csv' }
Plug 'timonv/vim-cargo', { 'for': 'rust' }

" Some Unix commands directly inside the editor
Plug 'tpope/vim-eunuch'

" Launch test in Vim
Plug 'janko-m/vim-test'
let test#strategy = "neovim"

" Mispelling is so common ...
Plug 'reedes/vim-litecorrect' ", { 'on': 'litecorrect#init()' }

" Some colors
Plug 'NLKNguyen/papercolor-theme'
Plug 'jdkanani/vim-material-theme'
Plug 'jscappini/material.vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'joshdick/onedark.vim'
Plug 'wellsjo/wellsokai.vim'

" Highlight hex colors
Plug 'vim-scripts/colorizer'
let g:colorizer_nomap = 1

" Less distraction
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
let g:limelight_conceal_ctermfg = 240
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_paragraph_span = 3

" Indent can be visible
Plug 'Yggdroot/indentLine'
let g:indentLine_enabled = 1
let g:indentLine_color_term = 239
let g:indentLine_char = '¦'

call plug#end()
" End vundle config

filetype plugin indent on
syntax on
set synmaxcol=500
set wildignore=*~,*.swp,*.orig

" encoding
if !has('nvim')
  set encoding="utf-8"
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
  colorscheme onedark
endif

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=64 " keep some lines of command line history
set showcmd   " display incomplete commands
set incsearch " do incremental searching

" display line number
set number

" fold method to indent, fold config
set foldmethod=indent
set foldcolumn=3 foldnestmax=4 foldminlines=8 foldlevelstart=2
set foldopen+=jump

" completion when you search a file (with :edit for exemaple)
set wildmode=list:longest,full
set wildmenu

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" highlight line, light line number
set cursorline
command! CursorColumn set cursorcolumn!
" Also switch on highlighting the last used search pattern.
set hlsearch

" auto-write files
set autowriteall

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

" toggle hlsearch
nnoremap <Leader>hl :nohlsearch<CR>

" press space to insert a single char before cursor
nmap <Space> i_<Esc>r

" sometimes I forget to use sudo
cnoremap w!! w !sudo tee % >/dev/null

" better tabs usage
nnoremap <S-T> :tabnew<CR>:Explore<CR>
nnoremap <S-H> gT
nnoremap <S-L> gt

" quickfix really quick
nnoremap <S-J> :cnext<CR>
nnoremap <S-K> :cprev<CR>

" visual (or not) indent with tab
nnoremap <TAB> >>
nnoremap <S-TAB> <<
vnoremap <TAB> >gv
vnoremap <S-TAB> <gv

" <C-C> doesn't trigger InsertLeave ...
inoremap <C-C> <Esc>

" Neovim terminal is good but going out of it is a pain in the ass
tnoremap <C-T> <C-\><C-N>

if !exists('g:loaded_matchit')
  runtime macros/matchit.vim
endif

" What if I have custom commands ?
command! FilePath echo @%
command! ConfReload source $MYVIMRC

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  augroup neovim_config
    autocmd!

    autocmd FileType vim setlocal expandtab tabstop=2 shiftwidth=2
  augroup END

  augroup startify
	  autocmd!

	  autocmd FileType startify setlocal nofoldenable
  augroup END

  "augroup x_config
  "    autocmd!
  "    autocmd BufWritePost ~/.Xresources sh xrdb ~/.Xresources
  "augroup END

  augroup html
    autocmd!

    au BufNewFile,BufRead *.tpl set ft=html
    au BufNewFile,BufRead *.html.twig set ft=html

    autocmd FileType html,jade,blade setlocal tabstop=2 shiftwidth=2 spell
    autocmd FileType html,blade setlocal omnifunc=htmlcomplete#CompleteTags
  augroup END

  augroup javascript
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

  augroup markdown
      autocmd!

    autocmd FileType markdown setlocal tabstop=2 shiftwidth=2 spell
    autocmd FileType markdown setlocal omnifunc=htmlcomplete#CompleteTags

    "autocmd FileType text,markdown setlocal textwidth=80
  augroup END

  augroup php
    autocmd!

    autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
  augroup END

  augroup haskell
    autocmd!

    autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
  augroup END

  augroup python
    autocmd!

    autocmd FileType python setlocal omnifunc=jedi#completions
  augroup END

  augroup statusline
    autocmd!

    function! InsertStatuslineColor(mode)
      if a:mode == 'i'
        highlight statusline ctermbg=52 guibg=red
      else
        highlight statusline ctermbg=130 guibg=yellow
      endif
    endfunction

    autocmd InsertEnter  * call InsertStatuslineColor(v:insertmode)
    autocmd InsertChange * call InsertStatuslineColor(v:insertmode)
    autocmd InsertLeave  * highlight StatusLine ctermbg=23 guibg=green
  augroup END

  augroup distraction
    autocmd!

    autocmd InsertEnter  * set nocursorline nocursorcolumn | Limelight
    autocmd InsertChange * set nocursorline nocursorcolumn | Limelight
    autocmd InsertLeave  * set cursorline | Limelight!
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
  command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

" Statusline config
set laststatus=2
set statusline=%6(%L%)\ %6(%l%),%-6(%c%)                                 " max line, current line and current column
set statusline+=\ %f
set statusline+=\ %Y,%{&fenc==\"\"?&enc:&fenc}                           " encoding
set statusline+=\ %{strftime(\"%H:%M\",getftime(expand(\"%%\")))}        " filename and last write
set statusline+=%=%<                                                     " got to the right and eventually truncate
set statusline+=%m%r%{fugitive#statusline()}                             " Git infos (if useing git)
set statusline+=\ %(%#ErrorMsg#%{neomake#statusline#LoclistStatus()}%*%) " lint/compile warnings/errors
