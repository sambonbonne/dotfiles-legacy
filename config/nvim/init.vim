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

" To add .lvimrc for each project you want
Plug 'embear/vim-localvimrc'
let g:localvimrc_ask=0

" Let's start nice
Plug 'mhinz/vim-startify'
function! s:startify_center_header(lines) abort " this function will center your header !
let longest_line   = max(map(copy(a:lines), 'len(v:val)'))
  let centered_lines = map(copy(a:lines),
        \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
  return centered_lines
endfunction
let g:startify_custom_header = s:startify_center_header([
      \ "o          `O        o                                                 ",
      \ "O           o       O                                                  ",
      \ "o           O       o                                     {            ",
      \ "O           O       O                                 {   }            ",
      \ "o     o     o .oOo. o  .oOo  .oOo. `oOOoOO. .oOo.      }_{ __{         ",
      \ "O     O     O OooO' O  O     O   o  O  o  o OooO'   .-{   }   }-.      ",
      \ "`o   O o   O' O     o  o     o   O  o  O  O O      (   }     {   )     ",
      \ " `OoO' `OoO'  `OoO' Oo `OoO' `OoO'  O  o  o `OoO'  |`-.._____..-'|     ",
      \ "                                                   |             ;--.  ",
      \ "                                                   |            (__  \ ",
      \ "                        .oOOOo.                    |             | )  )",
      \ "                        o     o                    |             |/  / ",
      \ "                        O.                         |             /  /  ",
      \ "                         `OOoo.                    |            (  /   ",
      \ "                              `O .oOoO' `oOOoOO.   \\             y    ",
      \ "                               o O   o   O  o  o    `-.._____..-'      ",
      \ "                        O.    .O o   O   o  O  O                       ",
      \ "                         `oooO'  `OoO'o  O  o  o                       ",
      \ "",
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
let g:startify_session_dir = '~/.vim/sessions'
let g:startify_session_autoload = 0
let g:startify_session_persistence = 0
let g:startify_files_number = 5
let g:startify_bookmarks = [
      \ '~/dev/www/catalisio/v1',
      \ '~/dev/www/catalisio/common/',
      \ '~/dev/www/catalisio/tools/'
      \ ]
let g:startify_change_to_dir = 1
let g:startify_change_to_vcs_root = 1

" Clipboard and pasting
Plug 'ConradIrwin/vim-bracketed-paste'

" number switch to relative or not
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" NERDTree, with Git flags
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } | Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
noremap <Leader>n :NERDTreeToggle<CR>

" All tags
Plug 'xolox/vim-misc' | Plug 'xolox/vim-easytags'
let g:easytags_async = 1
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
nnoremap <Leader>t :TagbarToggle<CR>

" Lot of things with Unite
Plug 'Shougo/unite.vim' | Plug 'Shougo/neoyank.vim'
" buffers list
nnoremap <Leader>b :Unite -quick-match buffer<cr>
" yank history
let g:unite_source_history_yank_enable = 1
nnoremap <Leader>y :Unite -quick-match history/yank<cr>
" File search
nnoremap <Leader>f :Unite file_rec<cr>

" Detect indentation and set defaults
Plug 'vim-scripts/yaifa.vim'
set tabstop=4    " size of hard tab stop
set shiftwidth=4 " size of an "indent"
set expandtab    " use space instead of tab

" Highlight whitespace
Plug 'bronson/vim-trailing-whitespace'

" Easy align
Plug 'junegunn/vim-easy-align', { 'on': '<Plug>(EasyAlign)' }
vmap <Enter> <Plug>(EasyAlign)

" Comment better
Plug 'scrooloose/nerdcommenter'

" Completion
set completeopt=longest,preview,menu,noselect
Plug 'Shougo/deoplete.nvim' | Plug 'Shougo/neoinclude.vim'
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources = {}
let g:deoplete#sources._ = ['member', 'tag', 'omni', 'neosnippet', 'buffer', 'file']
"let g:deoplete#omni_patterns = {}
"let g:deoplete#omni_patterns.javascript = '[^. \t]\.\h\w*'
"let g:deoplete#omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-D>"

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
Plug 'tpope/vim-abolish', { 'on': ['Abolish', 'Subvert'] } " :Abolish{despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}, :Subvert/pattern/subtitute/g
Plug 'mbbill/undotree', { 'on': ['UndotreeToggle', 'UndotreeShow', 'UndotreeFocus'] }
nnoremap <Leader>u :UndotreeToggle<CR>
"nmap <Leader>u :UndotreeToggle<CR>
if has("persistent_undo")
  set undodir=~/.undodir/
  set undofile
endif

" Advanced moves
Plug 'Lokaltog/vim-easymotion', { 'on': '<Plug>(easymotion-prefix)' }
let g:EasyMotion_do_mapping=1
let g:EasyMotion_smartcase=1
nmap <Leader>m <Plug>(easymotion-prefix)
vmap <Leader>m <Plug>(easymotion-prefix)

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
Plug 'ternjs/tern_for_vim', { 'for': 'javascript', 'do': 'npm install' }
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
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
Plug 'pekepeke/titanium-vim'

" Others languages/technos utils
Plug 'timonv/vim-cargo', { 'for': 'rust' }

" Launch test in Vim
Plug 'janko-m/vim-test'
let test#strategy = "neovim"

" Some colors
Plug 'NLKNguyen/papercolor-theme'
Plug 'jdkanani/vim-material-theme'
Plug 'jscappini/material.vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug '29decibel/codeschool-vim-theme'
Plug 'joshdick/onedark.vim'
Plug 'wellsjo/wellsokai.vim'
Plug 'altercation/vim-colors-solarized'
let g:solarized_termcolors=256
"Plug 'mattsacks/vim-eddie'

" Highlight hex colors
Plug 'vim-scripts/colorizer'
let g:colorizer_nomap = 1

" Indent can be visible
Plug 'Yggdroot/indentLine'
let g:indentLine_enabled = 1
let g:indentLine_color_term = 239
let g:indentLine_char = '¦'

call plug#end()
" End vundle config

filetype plugin indent on
syntax on
set wildignore=*~,*.swp,*.orig

" encoding
set encoding=utf-8
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
set history=100	" keep 100 lines of command line history
set showcmd     " display incomplete commands
set incsearch   " do incremental searching

" display line number
set number

" fold method to indent, fold config
set foldmethod=indent
set foldcolumn=3 foldnestmax=4 foldminlines=8 foldlevelstart=2

" press space to insert a single char before cursor
nmap <Space> i_<Esc>r

" completion when you search a file (with :edit for exemaple)
set wildmode=list:longest,full
set wildmenu

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

" search what you visually selected
vnoremap // y/<C-R>"<CR>

" spell, that's something great
set spelllang=fr,en
nnoremap <silent> <Leader>s :set spell!<CR>

if !exists('g:loaded_matchit')
  runtime macros/matchit.vim
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  augroup neovim_config
    autocmd!

    autocmd BufWritePost $MYVIMRC source $MYVIMRC
    autocmd FileType vim setlocal tabstop=2 shiftwidth=2
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
    au BufNewFile,BufRead *.tpl set syntax=underscore_template
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

  augroup general
    autocmd!

    " Delete white space at end of line when save
    autocmd BufWritePre * :FixWhitespace

    " Run Neomake on write
    autocmd! BufWritePost * Neomake

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
set statusline=%6(%L%)\ %6(%l%),%-6(%c%)
set statusline+=\ %<%f\ %Y,%{&fenc==\"\"?&enc:&fenc}\ %{strftime(\"%H:%M\",getftime(expand(\"%%\")))}
set statusline+=%=%m%r%{fugitive#statusline()}
set statusline+=\ %(%#ErrorMsg#%{neomake#statusline#LoclistStatus()}%*%)
