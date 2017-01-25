augroup finder
  autocmd!
  autocmd FileType finder nnoremap <buffer> q :<C-u>call FinderClosePane()<CR>
  autocmd FileType finder nnoremap <buffer> Q :<C-u>call FinderCloseAllPanes()<CR>
  autocmd FileType finder nnoremap <buffer> \ :<C-u>call FinderGoToRoot()<CR>
  autocmd FileType finder nnoremap <buffer> ~ :<C-u>call FinderGoToHome()<CR>
  autocmd FileType finder nnoremap <buffer> $ :<C-u>call FinderGoToTrash()<CR>
  autocmd FileType finder nnoremap <buffer> ^ :<C-u>call FinderGoToProject()<CR>
  autocmd FileType finder nnoremap <buffer> h :<C-u>call FinderGoToUpper()<CR>
  autocmd FileType finder nnoremap <buffer> l :<C-u>call FinderGoToLowerOrOpen()<CR>
  autocmd FileType finder nnoremap <buffer> e :<C-u>call FinderGoToLowerOrOpen()<CR>
  autocmd FileType finder nnoremap <buffer> <CR> :<C-u>call FinderGoToLowerOrOpen()<CR>
  autocmd FileType finder nnoremap <buffer> > :<C-u>call FinderGoTo()<CR>
  autocmd FileType finder nnoremap <buffer> <Space> :<C-u>call FinderSelect()<CR>
  autocmd FileType finder nnoremap <buffer> * :<C-u>call FinderReverseSelected()<CR>
  autocmd FileType finder nnoremap <buffer> t :<C-u>call FinderToggle()<CR>
  autocmd FileType finder nnoremap <buffer> T :<C-u>call FinderToggleRecursively()<CR>
  autocmd FileType finder nnoremap <buffer> K :<C-u>call FinderCreateDir()<CR>
  autocmd FileType finder nnoremap <buffer> N :<C-u>call FinderCreateFile()<CR>
  autocmd FileType finder nnoremap <buffer> r :<C-u>call FinderRename()<CR>
  autocmd FileType finder nnoremap <buffer> m :<C-u>call FinderMove()<CR>
  autocmd FileType finder nnoremap <buffer> x :<C-u>call FinderOpenExternally()<CR>
  autocmd FileType finder nnoremap <buffer> X :<C-u>call FinderOpenDirExternally()<CR>
  autocmd FileType finder nnoremap <buffer> D :<C-u>call FinderRemovePermanently()<CR>
  autocmd FileType finder nnoremap <buffer> d :<C-u>call FinderRemove()<CR>
  autocmd FileType finder nnoremap <buffer> R :<C-u>call FinderRestore()<CR>
  autocmd FileType finder nnoremap <buffer> C :<C-u>call FinderShowCopiedList()<CR>
  autocmd FileType finder nnoremap <buffer> c :<C-u>call FinderCopy()<CR>
  autocmd FileType finder nnoremap <buffer> p :<C-u>call FinderPaste()<CR>
  autocmd FileType finder nnoremap <buffer> y :<C-u>call FinderYank()<CR>
augroup END
