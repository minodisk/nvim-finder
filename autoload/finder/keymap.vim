noremap <Plug>(finder-toggle-pane) :<C-u>call FinderTogglePane()<CR>
noremap <Plug>(finder-open-pane) :<C-u>call FinderOpenPane()<CR>
noremap <Plug>(finder-close-pane) :<C-u>call FinderClosePane()<CR>
noremap <Plug>(finder-close-all-panes) :<C-u>call FinderCloseAllPanes()<CR>
noremap <Plug>(finder-go-to-root) :<C-u>call FinderGoToRoot()<CR>
noremap <Plug>(finder-go-to-home) :<C-u>call FinderGoToHome()<CR>
noremap <Plug>(finder-go-to-trash) :<C-u>call FinderGoToTrash()<CR>
noremap <Plug>(finder-go-to-project) :<C-u>call FinderGoToProject()<CR>
noremap <Plug>(finder-go-to-upper) :<C-u>call FinderGoToUpper()<CR>
noremap <Plug>(finder-go-to-lower-or-open) :<C-u>call FinderGoToLowerOrOpen()<CR>
noremap <Plug>(finder-go-to) :<C-u>call FinderGoTo()<CR>
noremap <Plug>(finder-select) :<C-u>call FinderSelect()<CR>
noremap <Plug>(finder-reverse-selected) :<C-u>call FinderReverseSelected()<CR>
noremap <Plug>(finder-toggle) :<C-u>call FinderToggle()<CR>
noremap <Plug>(finder-toggle-recursively) :<C-u>call FinderToggleRecursively()<CR>
noremap <Plug>(finder-create-dir) :<C-u>call FinderCreateDir()<CR>
noremap <Plug>(finder-create-file) :<C-u>call FinderCreateFile()<CR>
noremap <Plug>(finder-rename) :<C-u>call FinderRename()<CR>
noremap <Plug>(finder-move) :<C-u>call FinderMove()<CR>
noremap <Plug>(finder-open-externally) :<C-u>call FinderOpenExternally()<CR>
noremap <Plug>(finder-open-dir-externally) :<C-u>call FinderOpenDirExternally()<CR>
noremap <Plug>(finder-remove-permanently) :<C-u>call FinderRemovePermanently()<CR>
noremap <Plug>(finder-remove) :<C-u>call FinderRemove()<CR>
noremap <Plug>(finder-restore) :<C-u>call FinderRestore()<CR>
noremap <Plug>(finder-show-copied-list) :<C-u>call FinderShowCopiedList()<CR>
noremap <Plug>(finder-copy) :<C-u>call FinderCopy()<CR>
noremap <Plug>(finder-paste) :<C-u>call FinderPaste()<CR>
noremap <Plug>(finder-yank) :<C-u>call FinderYank()<CR>

augroup finder
  autocmd!
  autocmd FileType finder nnoremap <buffer> q <Plug>(finder-close-pane)<CR>
  autocmd FileType finder nnoremap <buffer> Q <Plug>(finder-close-all-panes)<CR>
  autocmd FileType finder nnoremap <buffer> \ <Plug>(finder-go-to-root)<CR>
  autocmd FileType finder nnoremap <buffer> ~ <Plug>(finder-go-to-home)<CR>
  autocmd FileType finder nnoremap <buffer> $ <Plug>(finder-go-to-trash)<CR>
  autocmd FileType finder nnoremap <buffer> ^ <Plug>(finder-go-to-project)<CR>
  autocmd FileType finder nnoremap <buffer> h <Plug>(finder-go-to-upper)<CR>
  autocmd FileType finder nnoremap <buffer> l <Plug>(finder-go-to-lower-or-open)<CR>
  autocmd FileType finder nnoremap <buffer> e <Plug>(finder-go-to-lower-or-open)<CR>
  autocmd FileType finder nnoremap <buffer> <CR> <Plug>(finder-go-to-lower-or-open)<CR>
  autocmd FileType finder nnoremap <buffer> > <Plug>(finder-go-to)<CR>
  autocmd FileType finder nnoremap <buffer> <Space> <Plug>(finder-select)<CR>
  autocmd FileType finder nnoremap <buffer> * <Plug>(finder-reverse-selected)<CR>
  autocmd FileType finder nnoremap <buffer> t <Plug>(finder-toggle)<CR>
  autocmd FileType finder nnoremap <buffer> T <Plug>(finder-toggle-recursively)<CR>
  autocmd FileType finder nnoremap <buffer> K <Plug>(finder-create-dir)<CR>
  autocmd FileType finder nnoremap <buffer> N <Plug>(finder-create-file)<CR>
  autocmd FileType finder nnoremap <buffer> r <Plug>(finder-rename)<CR>
  autocmd FileType finder nnoremap <buffer> m <Plug>(finder-move)<CR>
  autocmd FileType finder nnoremap <buffer> x <Plug>(finder-open-externally)<CR>
  autocmd FileType finder nnoremap <buffer> X <Plug>(finder-open-dir-externally)<CR>
  autocmd FileType finder nnoremap <buffer> D <Plug>(finder-remove-permanently)<CR>
  autocmd FileType finder nnoremap <buffer> d <Plug>(finder-remove)<CR>
  autocmd FileType finder nnoremap <buffer> R <Plug>(finder-restore)<CR>
  autocmd FileType finder nnoremap <buffer> C <Plug>(finder-show-copied-list)<CR>
  autocmd FileType finder nnoremap <buffer> c <Plug>(finder-copy)<CR>
  autocmd FileType finder nnoremap <buffer> p <Plug>(finder-paste)<CR>
  autocmd FileType finder nnoremap <buffer> y <Plug>(finder-yank)<CR>
augroup END
