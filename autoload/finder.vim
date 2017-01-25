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

source ./autoload/finder/keymap.vim

" vim:ts=4:sw=4:et
