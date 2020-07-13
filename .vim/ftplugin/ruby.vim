" vim:fdm=marker

" Flymake {{{
compiler ruby
autocmd BufWritePost <buffer> silent make %
autocmd QuickfixCmdPost make redraw!
autocmd QuickfixCmdPost make if len(getqflist()) != 0 | copen | endif
autocmd QuickfixCmdPost make if len(getqflist()) == 0 | cclose | endif
" }}}
