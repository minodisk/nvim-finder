" nvim-finder

if exists('g:finder_manifest_loaded')
    finish
endif
let g:finder_manifest_loaded = 1

call remote#host#RegisterPlugin('finder', '0', [
\ {'type': 'command', 'name': 'Finder', 'sync': 1, 'opts': {'nargs': '0'}},
\ {'type': 'function', 'name': 'FinderCloseAllPanes', 'sync': 1, 'opts': {}},
\ {'type': 'function', 'name': 'FinderClosePane', 'sync': 1, 'opts': {}},
\ {'type': 'function', 'name': 'FinderCopy', 'sync': 1, 'opts': {}},
\ {'type': 'function', 'name': 'FinderCreateDir', 'sync': 1, 'opts': {}},
\ {'type': 'function', 'name': 'FinderCreateFile', 'sync': 1, 'opts': {}},
\ {'type': 'function', 'name': 'FinderGoTo', 'sync': 1, 'opts': {}},
\ {'type': 'function', 'name': 'FinderGoToHome', 'sync': 1, 'opts': {}},
\ {'type': 'function', 'name': 'FinderGoToLowerOrOpen', 'sync': 1, 'opts': {}},
\ {'type': 'function', 'name': 'FinderGoToProject', 'sync': 1, 'opts': {}},
\ {'type': 'function', 'name': 'FinderGoToRoot', 'sync': 1, 'opts': {}},
\ {'type': 'function', 'name': 'FinderGoToTrash', 'sync': 1, 'opts': {}},
\ {'type': 'function', 'name': 'FinderGoToUpper', 'sync': 1, 'opts': {}},
\ {'type': 'function', 'name': 'FinderMove', 'sync': 1, 'opts': {}},
\ {'type': 'function', 'name': 'FinderOpenDirExternally', 'sync': 1, 'opts': {}},
\ {'type': 'function', 'name': 'FinderOpenExternally', 'sync': 1, 'opts': {}},
\ {'type': 'function', 'name': 'FinderOpenPane', 'sync': 1, 'opts': {}},
\ {'type': 'function', 'name': 'FinderPaste', 'sync': 1, 'opts': {}},
\ {'type': 'function', 'name': 'FinderRemove', 'sync': 1, 'opts': {}},
\ {'type': 'function', 'name': 'FinderRemovePermanently', 'sync': 1, 'opts': {}},
\ {'type': 'function', 'name': 'FinderRename', 'sync': 1, 'opts': {}},
\ {'type': 'function', 'name': 'FinderRestore', 'sync': 1, 'opts': {}},
\ {'type': 'function', 'name': 'FinderReverseSelected', 'sync': 1, 'opts': {}},
\ {'type': 'function', 'name': 'FinderSelect', 'sync': 1, 'opts': {}},
\ {'type': 'function', 'name': 'FinderShowCopiedList', 'sync': 1, 'opts': {}},
\ {'type': 'function', 'name': 'FinderToggle', 'sync': 1, 'opts': {}},
\ {'type': 'function', 'name': 'FinderTogglePane', 'sync': 1, 'opts': {}},
\ {'type': 'function', 'name': 'FinderToggleRecursively', 'sync': 1, 'opts': {}},
\ {'type': 'function', 'name': 'FinderYank', 'sync': 1, 'opts': {}},
\ ])
