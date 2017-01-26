" nvim-finder

function! finder#trim(str) abort
    return substitute(a:str, '^[\s\r\n]*\(.\{-}\)[\s\r\n]*$', '\1', '')
endfunction

function! finder#system(str) abort
    return finder#trim(system(a:str))
endfunction

function! finder#os() abort
    let uname = finder#system('uname')
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

function! finder#is_64bit() abort
    let arch = finder#system('arch')
    return arch == 'x86_64' || arch == 'amd64'
endfunction

function! finder#binary() abort
    if has('win64')
        return 'finder_windows_amd64.exe'
    endif
    if has('mac') && finder#is_64bit()
        return 'finder_darwin_amd64'
    endif
    if has('unix') && finder#os() == 'linux' && finder#is_64bit()
        return 'finder_linux_amd64'
    endif
    throw "[finder] your OS/Arch isn't supported"
endfunction

exec 'source ' . expand('<sfile>:p:h') . '/finder/keymap.vim'

" vim:ts=4:sw=4:et
