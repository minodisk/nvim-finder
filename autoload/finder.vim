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
    let cmd = finder#_download('https://github.com/minodisk/go-nvim-finder/releases/download/v0.0.1/' . bin, a:path)
    echomsg cmd
    system(cmd)
endfunction

" stolen from https://github.com/shougo/dein.vim/blob/a825907ccc9d8be149bd6b2ea4fde014fbd6ca27/autoload/dein/util.vim#l638-l658
function! finder#_download(uri, outpath) abort
  if !exists('g:dein#download_command')
    let g:dein#download_command =
          \ executable('curl') ?
          \   'curl --silent --location --output' :
          \ executable('wget') ?
          \   'wget -q -o' : ''
  endif
  if g:dein#download_command !=# ''
    return printf('%s "%s" "%s"',
          \ g:dein#download_command, a:outpath, a:uri)
  elseif dein#util#_is_windows()
    " use powershell
    " todo: proxy support
    let pscmd = printf("(new-object net.webclient).downloadfile('%s', '%s')",
          \ a:uri, a:outpath)
    return printf('powershell -command "%s"', pscmd)
  else
    return 'e: curl or wget command is not available!'
  endif
endfunction

exec 'source ' . expand('<sfile>:p:h') . '/finder/keymap.vim'

" vim:ts=4:sw=4:et
