" nvim-finder

function! finder#trim(str) abort
    return substitute(a:str, '^[\s\r\n]*\(.\{-}\)[\s\r\n]*$', '\1', '')
endfunction

function! finder#uname() abort
    return finder#trim(system('uname'))
endfunction

function! finder#os() abort
    let uname = finder#uname()
    if uname[0:5] == 'Darwin'
        return 'darwin'
    endif
    if uname[0:4] == 'Linux'
        return 'linux'
    endif
    if uname[0:9] == 'MINGW32_NT'
        return 'windows'
    endif
    return ''
endfunction

function! finder#binary(os) abort
    let postfix = ''
    if a:os == 'windows'
        let postfix = '.exe'
    endif
    return 'finder_' . a:os . '_amd64' . postfix
endfunction

function! finder#jobstart(host) abort
    let os = finder#os()
    if os == ''
        echoerr "Finder doesn't support your OS."
        return
    endif
    return jobstart(['./rplugin/finder/bin/' . finder#binary(os)], {'rpc': v:true})
endfunction

" Process
autocmd FileType finder nnoremap <buffer> q         :<C-u>Finder quit<CR>
autocmd FileType finder nnoremap <buffer> Q         :<C-u>Finder quit_all<CR>
" Updating current directory
autocmd FileType finder nnoremap <buffer> J         :<C-u>Finder cd<CR>
autocmd FileType finder nnoremap <buffer> \         :<C-u>Finder root<CR>
autocmd FileType finder nnoremap <buffer> ~         :<C-u>Finder home<CR>
autocmd FileType finder nnoremap <buffer> $         :<C-u>Finder trash<CR>
autocmd FileType finder nnoremap <buffer> .         :<C-u>Finder project<CR>
autocmd FileType finder nnoremap <buffer> h         :<C-u>Finder up<CR>
autocmd FileType finder nnoremap <buffer> e         :<C-u>Finder down<CR>
autocmd FileType finder nnoremap <buffer> l         :<C-u>Finder down<CR>
autocmd FileType finder nnoremap <buffer> <CR>      :<C-u>Finder down<CR>
" Updating object status
autocmd FileType finder nnoremap <buffer> <Space>   :<C-u>Finder select<CR>
autocmd FileType finder nnoremap <buffer> *         :<C-u>Finder reverse_selected<CR>
autocmd FileType finder nnoremap <buffer> t         :<C-u>Finder toggle<CR>
autocmd FileType finder nnoremap <buffer> T         :<C-u>Finder toggle_rec<CR>
" Manipulating with OS
autocmd FileType finder nnoremap <buffer> N         :<C-u>Finder create_file<CR>
autocmd FileType finder nnoremap <buffer> K         :<C-u>Finder create_dir<CR>
autocmd FileType finder nnoremap <buffer> r         :<C-u>Finder rename<CR>
autocmd FileType finder nnoremap <buffer> m         :<C-u>Finder move<CR>
autocmd FileType finder nnoremap <buffer> x         :<C-u>Finder open_externally<CR>
autocmd FileType finder nnoremap <buffer> X         :<C-u>Finder open_dir_externally<CR>
autocmd FileType finder nnoremap <buffer> E         :<C-u>Finder open_dir_externally<CR>
" Remove and restore
autocmd FileType finder nnoremap <buffer> D         :<C-u>Finder remove_permanently<CR>
autocmd FileType finder nnoremap <buffer> d         :<C-u>Finder remove<CR>
autocmd FileType finder nnoremap <buffer> R         :<C-u>Finder restore<CR>
" Copy and paste
autocmd FileType finder nnoremap <buffer> c         :<C-u>Finder copy<CR>
autocmd FileType finder nnoremap <buffer> C         :<C-u>Finder copied_list<CR>
autocmd FileType finder nnoremap <buffer> p         :<C-u>Finder paste<CR>
" Clipboard
autocmd FileType finder nnoremap <buffer> y         :<C-u>Finder yank<CR>

" vim:ts=4:sw=4:et
