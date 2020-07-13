" vim:fdm=marker

" Vundle {{{
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

Plugin 'VundleVim/Vundle.vim'

" My Plugins
Plugin 'aklt/plantuml-syntax'
Plugin 'bpearson/vim-phpcs'
Plugin 'davidhalter/jedi-vim'
"Plugin 'fatih/vim-go'
Plugin 'file://'.$HOME.'/usr/local/src/ijaas'
Plugin 'gregsexton/gitv'
"Plugin 'hallettj/jslint.vim'
"Plugin 'jodosha/vim-godebug'
"Plugin 'joonty/vdebug'
"Plugin 'm2mdas/phpcomplete-extended'
"Plugin 'm2mdas/phpcomplete-extended-laravel'
"Plugin 'ngmy/vim-rubocop'
Plugin 'posva/vim-vue'
Plugin 'Shougo/neocomplete.vim'
Plugin 'Shougo/vimproc.vim'
"Plugin 'soramugi/auto-ctags.vim'
Plugin 'StanAngeloff/php.vim'
Plugin 'thinca/vim-ref'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-ruby/vim-ruby'
Plugin 'vim-scripts/errormarker.vim'
Plugin 'vim-scripts/PDV--phpDocumentor-for-Vim'
Plugin 'vim-scripts/phpfolding.vim'
"Plugin 'violetyk/neocomplete-php.vim'
Plugin 'xwsoul/vim-zephir'

filetype plugin indent on
" }}}

" Editor {{{
" Enable syntax highlighting
syntax on

" Syntax highlighting until specified characters
set synmaxcol=256 " If a large number, Vim slows down with long lines

" Display line numbers
set number

" Disable ward wrapping
set nowrap

" Enable incremental search
set incsearch

" Highlighting search results
set hlsearch

" Highlighting cursor line
"set cursorline " If enabled, Vim slows down with long lines
"set cursorcolumn "If enabled, Vim slows down with long lines

" Highlighting more than specified characters
if exists('&colorcolumn')
  set colorcolumn=120
endif

" Display status line
set laststatus=2

" Disable omnifunc preview window
set completeopt=menuone
" }}}

" Text editing defualts {{{
" Display multi-byte characters correctly
if exists('&ambiwidth')
  set ambiwidth=double
endif

" Highlighting tabs and unwanted spaces
set list
set listchars=tab:>>,extends:<,trail:-
highlight SpecialKey ctermfg=lightblue ctermbg=blue guifg=lightblue guifg=blue

" Highlighting zenkaku-spaces
highlight ZenkakuSpace cterm=underline ctermfg=lightblue ctermbg=blue gui=underline guifg=blue guibg=blue
match ZenkakuSpace /　/

" Erasing previously entered characters in insert mode
set backspace=indent,eol,start
" }}}

" Xdebug {{{
" Listener port
let g:debuggerPort=10000
" }}}

" neocomplete {{{
"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
\    'default' : '',
\    'vimshell' : $HOME.'/.vimshell_hist',
\    'scheme' : $HOME.'/.gosh_completions'
\}

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting./
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

inoremap <expr><C-p> neocomplete#start_manual_complete()
" }}}

" plantuml {{{
let g:plantuml_executable_script = $HOME.'/.vim/bin/plantuml'
" }}}

" vim-fugitive {{{
" Display git branch name to status line
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
" }}}

" Vdebug {{{
" Use the brew python install
let s:python_path = system('/usr/local/bin/python -', 'import sys;sys.stdout.write(",".join(sys.path))')

python <<EOM
import sys
import vim

python_paths = vim.eval('s:python_path').split(',')
for path in python_paths:
    if not path in sys.path:
        sys.path.insert(0, path)
EOM

" options
let g:vdebug_options = {
\    "port" : 9000,
\    "server" : '127.0.0.1',
\    "path_maps" : { '/path/to/remote/project': $HOME.'/path/to/local/project' },
\}
" }}}

" phpfolding {{{
let g:DisableAutoPHPFolding = 1
" }}}

" vim-phpcs {{{
" Phpcs executable
let Vimphpcs_Phpcscmd = 'phpcs'
" }}}

" php.vim {{{
function! PhpSyntaxOverride()
  " Put snippet overrides in this function.
  hi! link phpDocTags phpDefine
  hi! link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END
" }}}
