" nvim-finder

if exists('g:finder_loaded')
    finish
endif
let g:finder_loaded = 1

let s:dir_plugin = expand('<sfile>:p:h') . '/finder'

function! s:jobstart(host) abort
  call finder#autoload()
  return jobstart(['nvim-finder'], {'rpc': v:true})
endfunction
call remote#host#Register('finder', 'x', function('s:jobstart'))

exec 'source ' . s:dir_plugin . '/manifest.vim'
