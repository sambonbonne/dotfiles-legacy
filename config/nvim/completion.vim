set completeopt=longest,menuone,noselect

let g:python_host_skip_check = 1

let s:completion_choice = {
      \ 'deoplete':    has("nvim") && has("python3"),
      \ 'neocomplete': !has("nvim") && has("lua"),
      \ }
let s:completion_choice.supertab = !s:completion_choice.deoplete && !s:completion_choice.neocomplete

let s:completion_mapping = join([
      \ 'inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"',
      \ 'inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-D>"',
      \ ], "\n")


" Neovim with python uses Deoplete
call dein#add('Shougo/deoplete.nvim', {
      \ 'on_event': 'InsertEnter',
      \ 'if': s:completion_choice.deoplete,
      \ 'hook_source': join([
      \   s:completion_mapping,
      \   'echo "Use Deoplete completion"',
      \   'autocmd InsertLeave * call deoplete#refresh()'
      \ ], "\n"),
      \ })
let g:deoplete#enable_at_startup = s:completion_choice.deoplete
let g:deoplete#enable_refresh_always = 1
let g:deoplete#auto_refresh_delay = 100
let g:deoplete#max_list = 20
let g:deoplete#max_menu_width = 80
let g:deoplete#sources = {}
let g:deoplete#sources._ = [ 'member', 'tag', 'omni', 'buffer', 'file' ]
let g:deoplete#sources.javascript = [ 'tern', 'buffer' ]
let g:deoplete#sources['javascript.jsx'] = [ 'tern', 'buffer' ]
let g:deoplete#sources#ternjs#filetypes = [ 'javascript', 'javascript.jsx', 'vue' ]
let g:deoplete#sources.python     = [ 'jedi' ]
let g:deoplete#sources.php        = [ 'omni', 'member', 'tag', 'buffer', 'file' ]
let g:deoplete#sources.vim        = [ 'vim', 'buffer' ]
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.tex =
      \ '\v\\%('
      \ . '\a*cite\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
      \ . '|\a*ref%(\s*\{[^}]*|range\s*\{[^,}]*%(}\{)?)'
      \ . '|hyperref\s*\[[^]]*'
      \ . '|includegraphics\*?%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
      \ . '|%(include%(only)?|input)\s*\{[^}]*'
      \ . '|\a*(gls|Gls|GLS)(pl)?\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
      \ . '|includepdf%(\s*\[[^]]*\])?\s*\{[^}]*'
      \ . '|includestandalone%(\s*\[[^]]*\])?\s*\{[^}]*'
      \ . ')\m'


" Vim with Lua uses Neocomplete
call dein#add('Shougo/neocomplete.vim', {
      \ 'on_event': 'InsertEnter',
      \ 'if': s:completion_choice.neocomplete,
      \ 'hook_source': join([
      \   s:completion_mapping,
      \   'inoremap <expr><C-TAB> neocomplete#complete_common_string()',
      \   '"inoremap <expr><CR> pumvisible() ? neocomplete#smart_close_popup() : "\<CR>"',
      \   'inoremap <expr><BS> pumvisible() ? neocomplete#undo_completion()."\<BS>" : "\<BS>"',
      \   'echo "Use Neocomplete completion"',
      \ ], "\n"),
      \ })
let g:necosyntax#min_keyword_length = 3
let g:neocomplete#enable_at_startup = s:completion_choice.neocomplete
let g:neocomplete#use_vimproc = 1
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


" Neovim without Python or Vim without Lua use SuperTab
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


call dein#add('Shougo/neoinclude.vim', { 'on_source': [ 'deoplete.nvim', 'neocomplete.vim' ] })
call dein#add('Shougo/neco-syntax',    { 'on_source': [ 'deoplete.nvim', 'neocomplete.vim' ] })

" Complete from adjacent Tmux panes
call dein#add('wellle/tmux-complete.vim') " used for Unite and deoplete/neocomplete
let g:tmuxcomplete#trigger = ''


" Completion engines

" Vim itself
call dein#add('Shougo/neco-vim', { 'on_source': [ 'deoplete.nvim', 'neocomplete.vim' ], 'on_ft': 'vim' })

" JavaScript
call dein#add('ternjs/tern_for_vim', {
      \ 'on_ft': [ 'javascript', 'javascript.jsx' ],
      \ 'build': 'npm install'
      \ })
call dein#add('carlitux/deoplete-ternjs', {
      \ 'if': s:completion_choice.deoplete,
      \ 'depends': 'deoplete.nvim',
      \ 'on_ft': [ 'javascript', 'jsx', 'javascript.jsx', 'typescript' ],
      \ 'build': 'npm install -g tern'
      \ })
let g:deoplete#sources#ternjs#tern_bin = '/home/samuel/.npm/bin/tern'
let g:tern#command = [ "tern" ]
let g:tern#arguments = [ "--persistent" ]

" Python
call dein#add('davidhalter/jedi-vim', { 'on_ft': 'python', 'build': 'pip3 install --user --upgrade jedi' })
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
