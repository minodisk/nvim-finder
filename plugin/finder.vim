" nvim-finder

if exists('g:finder_loaded')
    finish
endif
let g:finder_loaded = 1

let s:dir_plugin = expand('<sfile>:p:h') . '/finder'
let s:dir_rplugin = expand('<sfile>:p:h:h') . '/rplugin/finder'

function! s:jobstart(host) abort
    try
        let name = finder#binary()
    catch
        echomsg v:exception
        return
    endtry

    let bin = s:dir_rplugin . '/bin/' . name
    return jobstart([bin], {'rpc': v:true})
endfunction

call remote#host#Register('finder', 'x', function('s:jobstart'))
exec 'source ' . s:dir_plugin . '/manifest.vim'

" vim:ts=4:sw=4:et
