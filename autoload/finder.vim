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
    let cmd = finder#download('https://github.com/minodisk/go-nvim-finder/releases/download/v0.0.1/' . bin, a:path)
    echomsg cmd
    system(cmd)
endfunction

" Stolen from https://github.com/Shougo/dein.vim/blob/a825907ccc9d8be149bd6b2ea4fde014fbd6ca27/autoload/dein/util.vim#L638-L658
function! finder#_download(uri, outpath) abort
  if !exists('g:dein#download_command')
    let g:dein#download_command =
          \ executable('curl') ?
          \   'curl --silent --location --output' :
          \ executable('wget') ?
          \   'wget -q -O' : ''
  endif
  if g:dein#download_command !=# ''
    return printf('%s "%s" "%s"',
          \ g:dein#download_command, a:outpath, a:uri)
  elseif dein#util#_is_windows()
    " Use powershell
    " Todo: Proxy support
    let pscmd = printf("(New-Object Net.WebClient).DownloadFile('%s', '%s')",
          \ a:uri, a:outpath)
    return printf('powershell -Command "%s"', pscmd)
  else
    return 'E: curl or wget command is not available!'
  endif
endfunction

exec 'source ' . expand('<sfile>:p:h') . '/finder/keymap.vim'

" vim:ts=4:sw=4:et
