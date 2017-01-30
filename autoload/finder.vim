" nvim-finder

function! finder#system(str) abort
    return finder#trim(system(a:str))
endfunction

function! finder#trim(str) abort
    return substitute(a:str, '^[\s\r\n]*\(.\{-}\)[\s\r\n]*$', '\1', '')
endfunction

function! finder#uname() abort
    return finder#system('uname -a')
endfunction

function! finder#is_64bit(uname) abort
    return a:uname =~ 'x86_64' || a:uname =~ 'amd64'
endfunction

function! finder#os(uname) abort
    if a:uname =~ 'Darwin'
        return 'darwin'
    endif
    if a:uname =~ 'FreeBSD'
        return 'freebsd'
    endif
    if a:uname =~ 'Linux'
        return 'linux'
    endif
    if a:uname =~ 'NetBSD'
        return 'netbsd'
    endif
    if a:uname =~ 'OpenBSD'
        return 'openbsd'
    endif
    if a:uname=~ 'Windows' || a:uname =~ 'MINGW32_NT'
        return 'windows'
    endif
    return ''
endfunction

function! finder#binary(name) abort
    let uname = finder#uname()
    if !finder#is_64bit(uname)
        throw "[finder] only supports 64bit CPU"
        return
    endif
    let os = finder#os(uname)
    if os == ''
        throw "[finder] only supports Darwin, FreeBSD, Linux, NetBSD, OpenBSD and Windows"
    endif
    let ext = ''
    if os == 'windows'
        ext = '.exe'
    endif
    return a:name . '_' . os . '_amd64' . ext
endfunction

function! finder#download(path) abort
    let bin = finder#binary('finder')
    let tag = finder#system('git describe --tags --abbrev=0')
    call system('wget -O ' . a:path . ' https://github.com/minodisk/go-nvim-finder/releases/download/' . tag . '/' . bin)
    call system('chmod a+x ' . a:path)
endfunction

exec 'source ' . expand('<sfile>:p:h') . '/finder/keymap.vim'

" vim:ts=4:sw=4:et
