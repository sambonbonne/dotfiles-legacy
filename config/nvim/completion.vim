set completeopt=longest,menuone,noselect

let g:python_host_skip_check = 1

let s:completion_choice = {
      \ 'deoplete': has("python3"),
      \ 'supertab': !has("python3"),
      \ }

let s:completion_mapping = join([
      \ 'inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"',
      \ 'inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-D>"',
      \ ], "\n")


call dein#add('Shougo/deoplete.nvim', {
      \ 'on_event': 'InsertEnter',
      \ 'if': s:completion_choice.deoplete,
      \ 'hook_source': join([
      \   s:completion_mapping,
      \   'echo "Use Deoplete completion"'
      \ ], "\n"),
      \ })
if !has('nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
endif
let g:deoplete#enable_at_startup = s:completion_choice.deoplete
let g:deoplete#enable_refresh_always = 1
let g:deoplete#auto_refresh_delay = 100
let g:deoplete#max_list = 20
let g:deoplete#max_menu_width = 80
" let g:deoplete#sources = {}
" let g:deoplete#sources._ = [ 'member', 'tag', 'omni', 'buffer', 'file' ]
" let g:deoplete#sources.javascript = [ 'tern', 'buffer' ]
" let g:deoplete#sources['javascript.jsx'] = [ 'tern', 'buffer' ]
" let g:deoplete#sources#ternjs#filetypes = [ 'javascript', 'javascript.jsx', 'vue' ]
" let g:deoplete#sources.typescript = [ 'tern', 'buffer' ]
" let g:deoplete#sources.python     = [ 'jedi' ]
" let g:deoplete#sources.php        = [ 'omni', 'member', 'tag', 'buffer', 'file' ]
" let g:deoplete#sources.vim        = [ 'vim', 'buffer' ]

" If not Python, use SuperTab
function! SuperTabAddOmni(amatch)
  if a:amatch == "omnifunc"
    call SuperTabChain(&omnifunc, "<c-n>")
  endif
endfunction " SuperTabAddOmni()
call dein#add('ervandew/supertab', {
      \ 'if': s:completion_choice.supertab,
      \ 'hook_source': join([
      \   'autocmd VimEnter * if &omnifunc != "" | call SuperTabChain(&omnifunc, "<c-n>") | endif',
      \   'autocmd OptionSet * call SuperTabAddOmni(expand("<amatch>"))',
      \   'echo "Use SuperTab completion"',
      \ ], "\n")
      \ })
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"


call dein#add('Shougo/neoinclude.vim', { 'on_source': [ 'deoplete.nvim' ] })
call dein#add('Shougo/neco-syntax',    { 'on_source': [ 'deoplete.nvim' ] })

" Complete from adjacent Tmux panes
call dein#add('wellle/tmux-complete.vim') " used for Unite and deoplete
let g:tmuxcomplete#trigger = ''


" Completion engines

" Vim itself
call dein#add('Shougo/neco-vim', { 'on_source': [ 'deoplete.nvim' ], 'on_ft': 'vim' })

" JavaScript
call dein#add('ternjs/tern_for_vim', {
      \ 'on_ft': [ 'javascript', 'javascript.jsx' ],
      \ 'build': 'npm install'
      \ })
call dein#add('carlitux/deoplete-ternjs', {
      \ 'if': s:completion_choice.deoplete,
      \ 'depends': 'deoplete.nvim',
      \ 'on_ft': [ 'javascript', 'jsx', 'javascript.jsx' ],
      \ 'build': 'npm install -g tern'
      \ })
let g:deoplete#sources#ternjs#tern_bin = '/home/samuel/.npm/bin/tern'
let g:tern#command = [ "tern" ]
let g:tern#arguments = [ "--persistent" ]

" TypeScript
call dein#add('HerringtonDarkholme/yats.vim')
call dein#add('mhartington/nvim-typescript', {
      \ 'if': s:completion_choice.deoplete,
      \ 'depends': [ 'deoplete.nvim', 'yats.vim' ],
      \ 'on_ft': [ 'typescript', 'tsx' ],
      \ 'build': 'sh ./install.sh'
      \ })

" Python
" call dein#add('davidhalter/jedi-vim', { 'on_ft': 'python', 'build': 'pip3 install --user --upgrade jedi' })
call dein#add('zchee/deoplete-jedi', { 'if': s:completion_choice.deoplete, 'depends': 'deoplete.nvim', 'on_ft': 'python' })
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_select_first = 0
let g:jedi#goto_command = "<leader>g"
let g:jedi#goto_assignments_command = ""
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "<leader>d"
let g:jedi#usages_command = ""
let g:jedi#completions_command = ""
let g:jedi#rename_command = "<leader>r"
" Django of course
call dein#add('tweekmonster/django-plus.vim', { 'on_ft': 'python' })

" Haskell
call dein#add('eagletmt/neco-ghc', { 'on_ft': 'haskell' })
