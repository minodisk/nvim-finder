" finder
" Version: 0.1

if exists('g:loaded_finder')
  finish
endif
let g:finder_finder = 1

function! s:trim(str)
    return substitute(a:str, '^[\s\r\n]*\(.\{-}\)[\s\r\n]*$', '\1', '')
endfunction

function! s:uname()
    return s:trim(system('uname'))
endfunction

function! s:os()
    let l:uname = s:uname()
    if l:uname[0:5] == 'Darwin'
        return 'darwin'
    endif
    if l:uname[0:4] == 'Linux'
        return 'linux'
    endif
    if l:uname[0:9] == 'MINGW32_NT'
        return 'windows'
    endif
    return ''
endfunction

function! s:binary(os)
    let l:postfix = ''
    if a:os == 'windows'
        let l:postfix = '.exe'
    endif
    return 'finder_' . a:os . '_amd64' . l:postfix
endfunction

function! s:Requirefinder(host) abort
    let l:os = s:os()
    if l:os == ''
        echoerr "Finder doesn't support your OS."
        return
    endif
    return jobstart(['./rplugin/finder/bin/' . s:binary(l:os)], {'rpc': v:true})
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
