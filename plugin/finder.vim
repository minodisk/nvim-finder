" nvim-finder

if exists('g:loaded_finder')
    finish
endif
let g:finder_finder = 1

call remote#host#Register('finder', 'x', function('finder#jobstart'))
exec 'source ' . expand('<sfile>:p:h') . '/finder/manifest.vim'

" vim:ts=4:sw=4:et
