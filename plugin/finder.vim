" nvim-finder

if exists('g:finder_loaded')
    finish
endif
let g:finder_loaded = 1

function! s:jobstart(host) abort
    let bin = expand('<sfile>:p:h') . '/rplugin/finder/bin/' . finder#binary(finder#os())
    return jobstart([bin], {'rpc': v:true})
endfunction

call remote#host#Register('finder', 'x', function('s:jobstart'))
exec 'source ' . expand('<sfile>:p:h') . '/finder/manifest.vim'

" vim:ts=4:sw=4:et
