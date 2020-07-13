" vim:fdm=marker

" Syntax highlighting in strings {{{
" SQL
let php_sql_query=1

" HTML
let php_htmlInStrings=1
" }}}

" vim-phpcs {{{
" Coding standard to use
let Vimphpcs_Standard = 'PSR12'
" }}}

" phpDocumentor {{{
inoremap <C-O> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-O> :call PhpDocSingle()<CR>
vnoremap <C-O> :call PhpDocRange()<CR>
let g:pdv_cfg_Package = ''
let g:pdv_cfg_Version = ''
let g:pdv_cfg_Author = ''
let g:pdv_cfg_Copyright = ''
let g:pdv_cfg_License = ''
" }}}

" Flymake {{{
setlocal makeprg=$HOME/.vim/bin/vimparse.php\ -c\ %\ $*
augroup php_vimparse
  autocmd!
  autocmd php_vimparse BufWritePost *.php silent make
  autocmd php_vimparse QuickfixCmdPost make redraw!
  autocmd php_vimparse QuickfixCmdPost make if len(getqflist()) != 0 | copen | endif
  autocmd php_vimparse QuickfixCmdPost make if len(getqflist()) == 0 | cclose | endif
augroup END
" }}}

" phpcomplete-extended {{{
" Composer command name.
let g:phpcomplete_index_composer_command = 'composer'
" PHP omni completion.
"autocmd FileType php setlocal omnifunc=phpcomplete_extended#CompletePHP
" }}}

" Omni completion {{{
set omnifunc=syntaxcomplete#Complete
" }}}

" Ctags {{{
set tags+=php.tags
" }}}

" vim-ref {{{
let g:ref_phpmanual_path = $HOME.'/.vim/ref/php-chunked-xhtml'
" }}}

" phpfolding {{{
let g:DisableAutoPHPFolding = 0
source $HOME/.vim/bundle/phpfolding.vim/plugin/phpfolding.vim
" }}}
