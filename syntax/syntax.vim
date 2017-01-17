syntax keyword finderPrefixDirOpened "-"
syntax keyword finderPrefixDirClosed "+"
syntax keyword finderPrefixFile      "|"

syntax region finderDirOpened matchgroup=finderPrefixDirOpened start="-" end="$"
syntax region finderDirClosed matchgroup=finderPrefixDirClosed start="+" end="$"
syntax region finderFile      matchgroup=finderPrefixFile      start="|" end="$"
syntax region finderMarked                                     start="*" end="$"

highlight link finderPrefixDirOpened Delimiter
highlight link finderPrefixDirClosed Delimiter
highlight link finderPrefixFile      Delimiter
highlight link finderDirOpened       Identifier
highlight link finderDirClosed       Identifier
highlight link finderMarked          Type
