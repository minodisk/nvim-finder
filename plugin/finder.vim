" nvim-finder

if exists('g:finder_loaded')
    finish
endif
let g:finder_loaded = 1

let s:dir_rplugin = expand('<sfile>:p:h:h') . '/rplugin/finder'
let s:dir_plugin = expand('<sfile>:p:h') . '/finder'
let s:rplugin = s:dir_rplugin . '/bin/nvim-finder'

echo s:rplugin

function! s:jobstart(host) abort
  return jobstart([s:rplugin], {'rpc': v:true})
endfunction
call remote#host#Register('finder', 'x', function('s:jobstart'))

command! FinderInstallBinary :call finder#download(s:rplugin)

exec 'source ' . s:dir_plugin . '/manifest.vim'
