" nvim-finder

if exists('g:finder_loaded')
    finish
endif
let g:finder_loaded = 1

function! s:jobstart(host) abort
  let path = finder#rplugin()
  echomsg path
  return jobstart([path], {'rpc': v:true})
endfunction

call remote#host#Register('finder', 'x', function('s:jobstart'))

function! FinderDownloadBinary() abort
  call finder#download()
endfunction
command! FinderInstallBinary :call finder#download()

let s:dir_plugin = expand('<sfile>:p:h') . '/finder'
exec 'source ' . s:dir_plugin . '/manifest.vim'
exec 'source ' . s:dir_plugin . '/version.vim'
