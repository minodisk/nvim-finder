" finder
" Version: 0.1

if exists('g:loaded_finder')
  finish
endif
let g:finder_finder = 1

function! s:Requirefinder(host) abort
  return jobstart(['./rplugin/finder/bin/finder'], {'rpc': v:true})
endfunction

call remote#host#Register('finder', 'x', function('s:Requirefinder'))
call remote#host#RegisterPlugin('finder', '0', [
    \ {'type': 'command', 'name': 'Finder', 'sync': 1, 'opts': {'nargs': '?'}},
    \ ])

autocmd FileType finder nnoremap <buffer> q         :<C-u>Finder quit<CR>
autocmd FileType finder nnoremap <buffer> h         :<C-u>Finder up<CR>
autocmd FileType finder nnoremap <buffer> e         :<C-u>Finder down<CR>
autocmd FileType finder nnoremap <buffer> l         :<C-u>Finder down<CR>
autocmd FileType finder nnoremap <buffer> <CR>      :<C-u>Finder down<CR>
autocmd FileType finder nnoremap <buffer> t         :<C-u>Finder toggle<CR>
autocmd FileType finder nnoremap <buffer> T         :<C-u>Finder toggle_rec<CR>
autocmd FileType finder nnoremap <buffer> N         :<C-u>Finder create_file<CR>
autocmd FileType finder nnoremap <buffer> K         :<C-u>Finder create_dir<CR>
autocmd FileType finder nnoremap <buffer> r         :<C-u>Finder rename<CR>
autocmd FileType finder nnoremap <buffer> d         :<C-u>Finder remove<CR>
autocmd FileType finder nnoremap <buffer> m         :<C-u>Finder move<CR>
autocmd FileType finder nnoremap <buffer> <Space>   :<C-u>Finder select<CR>

" vim:ts=4:sw=4:et
