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
  autocmd FileType finder map <buffer> q <Plug>(finder-close-pane)
  autocmd FileType finder map <buffer> Q <Plug>(finder-close-all-panes)
  autocmd FileType finder map <buffer> \ <Plug>(finder-go-to-root)
  autocmd FileType finder map <buffer> ~ <Plug>(finder-go-to-home)
  autocmd FileType finder map <buffer> $ <Plug>(finder-go-to-trash)
  autocmd FileType finder map <buffer> ^ <Plug>(finder-go-to-project)
  autocmd FileType finder map <buffer> h <Plug>(finder-go-to-upper)
  autocmd FileType finder map <buffer> l <Plug>(finder-go-to-lower-or-open)
  autocmd FileType finder map <buffer> e <Plug>(finder-go-to-lower-or-open)
  autocmd FileType finder map <buffer> <CR> <Plug>(finder-go-to-lower-or-open)
  autocmd FileType finder map <buffer> > <Plug>(finder-go-to)
  autocmd FileType finder map <buffer> <Space> <Plug>(finder-select)
  autocmd FileType finder map <buffer> * <Plug>(finder-reverse-selected)
  autocmd FileType finder map <buffer> t <Plug>(finder-toggle)
  autocmd FileType finder map <buffer> T <Plug>(finder-toggle-recursively)
  autocmd FileType finder map <buffer> K <Plug>(finder-create-dir)
  autocmd FileType finder map <buffer> N <Plug>(finder-create-file)
  autocmd FileType finder map <buffer> r <Plug>(finder-rename)
  autocmd FileType finder map <buffer> m <Plug>(finder-move)
  autocmd FileType finder map <buffer> x <Plug>(finder-open-externally)
  autocmd FileType finder map <buffer> X <Plug>(finder-open-dir-externally)
  autocmd FileType finder map <buffer> D <Plug>(finder-remove-permanently)
  autocmd FileType finder map <buffer> d <Plug>(finder-remove)
  autocmd FileType finder map <buffer> R <Plug>(finder-restore)
  autocmd FileType finder map <buffer> C <Plug>(finder-show-copied-list)
  autocmd FileType finder map <buffer> c <Plug>(finder-copy)
  autocmd FileType finder map <buffer> p <Plug>(finder-paste)
  autocmd FileType finder map <buffer> y <Plug>(finder-yank)
augroup END
