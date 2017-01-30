" nvim-finder

if exists('g:finder_loaded')
    finish
endif
let g:finder_loaded = 1

let s:dir_plugin = expand('<sfile>:p:h') . '/finder'

function! s:jobstart(host) abort
  let path = finder#rplugin()
  echomsg path
  return jobstart([path], {'rpc': v:true})
endfunction

call remote#host#Register('finder', 'x', function('s:jobstart'))

function! FinderDownloadBinary() abort
  finder#download()
endfunction

exec 'source ' . s:dir_plugin . '/manifest.vim'
