# enable japanese support and correct line drawing of tree
alias tree='tree --charset=C -N'

# HACK: workaround for garbled japanese characters
alias clip.exe='{ printf "\xff\xfe"; iconv -t UTF-16LE; } | clip.exe'
