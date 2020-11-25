set nocompatible

" vim-plug {{{
" Install vim-plug if not found
if empty(glob($HOME . '/.vim/autoload/plug.vim'))
  silent !curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin($HOME . '/.vim/plugged')

Plug 'aklt/plantuml-syntax'
Plug 'bpearson/vim-phpcs'
Plug 'davidhalter/jedi-vim'
"Plug 'fatih/vim-go'
Plug 'file://' . $HOME . '/usr/local/src/ijaas'
Plug 'gregsexton/gitv'
"Plug 'hallettj/jslint.vim'
"Plug 'jodosha/vim-godebug'
"Plug 'joonty/vdebug'
"Plug 'm2mdas/phpcomplete-extended'
"Plug 'm2mdas/phpcomplete-extended-laravel'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'ngmy/vim-rubocop'
Plug 'posva/vim-vue'
"Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/vimproc.vim'
"Plug 'soramugi/auto-ctags.vim'
Plug 'StanAngeloff/php.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/errormarker.vim'
Plug 'vim-scripts/PDV--phpDocumentor-for-Vim'
Plug 'vim-scripts/phpfolding.vim'
"Plug 'violetyk/neocomplete-php.vim'
Plug 'xwsoul/vim-zephir'

" Initialize plugin system
call plug#end()
" }}}

" coc.nvim {{{
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has('patch-8.1.1564')
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim', 'help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
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

" Cursor in terminal
"
" https://github.com/microsoft/terminal/issues/4335
" https://vim.fandom.com/wiki/Configuring_the_cursor
"
" 1 -> Blinking block
" 2 -> Solid block
" 3 -> Blinking underscore
" 4 -> Solid underscore
"
" Recent versions of xterm (282 or above) also support:
"
" 5 -> Blinking vertical bar
" 6 -> Solid vertical bar
if &term =~ '^xterm'
  " When enter Vim (IOW, when enter normal mode)
  autocmd VimEnter * silent !echo -en "\e[1 q"
  " HACK: Work around the problem that an escape sequence is output at startup.
  "       https://vi.stackexchange.com/questions/19748
  autocmd VimEnter * normal :startinsert
  " When enter insert mode
  autocmd InsertEnter * silent !echo -en "\e[5 q"
  " When leave insert mode (IOW, when enter normal mode)
  autocmd InsertLeave * silent !echo -en "\e[1 q"
  " When enter command line
  autocmd CmdlineEnter * silent !echo -en "\e[5 q"
  " When leave command line (IOW, when enter normal mode)
  autocmd CmdlineLeave * silent !echo -en "\e[1 q"
  " When leave Vim
  autocmd VimLeave * silent !echo -en "\e[5 q"
  " When suspend Vim, and when resume Vim (IOW, when enter normal mode)
  nnoremap <silent> <C-z> :execute 'silent !echo -en "\e[5 q"'<CR>:suspend<Bar>:execute 'silent !echo -en "\e[1 q"'<CR>
endif
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

" plantuml {{{
let g:plantuml_executable_script = $HOME . '/.vim/bin/plantuml'
" }}}

" vim-fugitive {{{
" Display git branch name to status line
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
" }}}

" Vdebug {{{
" Use the brew python install
let s:python_path = system('/usr/local/bin/python -', 'import sys;sys.stdout.write(",".join(sys.path))')

"python <<EOM
"import sys
"import vim
"
"python_paths = vim.eval('s:python_path').split(',')
"for path in python_paths:
"    if not path in sys.path:
"        sys.path.insert(0, path)
"EOM

" options
let g:vdebug_options = {
\    'port' : 9000,
\    'server' : '127.0.0.1',
\    'path_maps' : { '/path/to/remote/project': $HOME . '/path/to/local/project' },
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

" vim: set et ts=2 sts=2 sw=2 tw=0 fdm=marker fdc=3 :
