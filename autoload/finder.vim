" nvim-finder

function! finder#autoload() abort
endfunction

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
    if a:uname =~ 'darwin'
        return 'darwin'
    endif
    if a:uname =~ 'freebsd'
        return 'freebsd'
    endif
    if a:uname =~ 'linux'
        return 'linux'
    endif
    if a:uname =~ 'netbsd'
        return 'netbsd'
    endif
    if a:uname =~ 'openbsd'
        return 'openbsd'
    endif
    if a:uname=~ 'windows' || a:uname =~ 'mingw32_nt'
        return 'windows'
    endif
    return ''
endfunction

function! finder#binary(name) abort
    let uname = finder#uname()
    if !finder#is_64bit(uname)
        throw "[finder] only supports 64bit cpu"
        return
    endif
    let os = finder#os(uname)
    if os == ''
        throw "[finder] only supports darwin, freebsd, linux, netbsd, openbsd and windows"
    endif
    let ext = ''
    if os == 'windows'
        ext = '.exe'
    endif
    return a:name . '_' . os . '_amd64' . ext
endfunction

function! finder#download(path) abort
    let bin = finder#binary('finder')
    call system('wget -O ' . a:path . ' https://github.com/minodisk/go-nvim-finder/releases/download/v0.0.1/' . bin)
endfunction

exec 'source ' . expand('<sfile>:p:h') . '/finder/keymap.vim'
