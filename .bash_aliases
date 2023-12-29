# enable japanese support and correct line drawing of tree
alias tree='tree --charset=C -N'

# HACK: workaround for garbled japanese characters
alias clip.exe='iconv -t utf16 | clip.exe'
