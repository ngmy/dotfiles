set nocompatible

" vim-plug {{{
" Install vim-plug if not found
if empty(glob($HOME . '/.vim/autoload/plug.vim'))
  silent !curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin($HOME . '/.vim/plugged')

Plug '2072/PHP-Indenting-for-VIm'
Plug 'aklt/plantuml-syntax'
Plug 'bpearson/vim-phpcs'
Plug 'cespare/vim-toml'
Plug 'chr4/nginx.vim'
Plug 'davidhalter/jedi-vim'
Plug 'evidens/vim-twig'
"Plug 'fatih/vim-go'
"Plug 'file://' . $HOME . '/usr/local/src/ijaas'
Plug 'github/copilot.vim'
Plug 'gregsexton/gitv'
"Plug 'hallettj/jslint.vim'
"Plug 'jodosha/vim-godebug'
"Plug 'joonty/vdebug'
"Plug 'm2mdas/phpcomplete-extended'
"Plug 'm2mdas/phpcomplete-extended-laravel'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'ngmy/vim-rubocop'
Plug 'posva/vim-vue'
Plug 'rbtnn/vim-ambiwidth'
"Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/vimproc.vim'
Plug 'soramugi/auto-ctags.vim'
Plug 'biinari/php.vim'
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

" coc.nvim recommended configuration {{{
" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" }}}

" coc.nvim {{{
" Change the floating window color
hi CocFloating ctermbg=237 guibg=#13354A
" }}}

" copilot.vim {{{
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

let g:copilot_filetypes = {
  \ 'gitcommit': v:true,
  \ 'markdown': v:true,
  \ 'yaml': v:true,
  \ }
" }}}

" Editor {{{
" Use default colorscheme
colorscheme default

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

" Display a vertical line in the specified column
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
  " FIXME: When enter command line
  "autocmd CmdlineEnter * silent !echo -en "\e[5 q"
  " FIXME: When leave command line (IOW, when enter normal mode)
  "autocmd CmdlineLeave * silent !echo -en "\e[1 q"
  " When leave Vim
  autocmd VimLeave * silent !echo -en "\e[5 q"
  " When suspend Vim, and when resume Vim (IOW, when enter normal mode)
  nnoremap <silent> <C-z> :execute 'silent !echo -en "\e[5 q"'<CR>:suspend<Bar>:execute 'silent !echo -en "\e[1 q"'<CR>
endif
" }}}

" Text editing defualts {{{
" Highlighting tabs and unwanted spaces
set list
set listchars=tab:>>,extends:<,trail:-
highlight SpecialKey ctermfg=lightblue ctermbg=blue guifg=lightblue guifg=blue

" Highlighting zenkaku-spaces
highlight ZenkakuSpace cterm=underline ctermfg=lightblue ctermbg=blue gui=underline guifg=blue guibg=blue
match ZenkakuSpace /　/

" Highlighting TODO, FIXME, etc. for all file types
autocmd Syntax * call matchadd('Todo', '\W\zs\(TODO\|FIXME\|HACK\|XXX\|REVIEW\|OPTIMIZE\|CHANGED\|NOTE\|WARNING\)\ze\W')

" Erasing previously entered characters in insert mode
set backspace=indent,eol,start
" }}}

" Set the filetype {{{
autocmd BufNewFile,BufRead *.json.dist set filetype=json
autocmd BufNewFile,BufRead *.ts,*.tsx set filetype=javascript
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

" coc-css {{{
autocmd FileType scss setl iskeyword+=@-@
" }}}

" PHP-Indenting-for-VIm {{{
let g:PHP_noArrowMatching = 1
" }}}

" vim: set et ts=2 sts=2 sw=2 tw=0 fdm=marker fdc=3 :
