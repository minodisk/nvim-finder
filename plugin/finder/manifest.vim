call remote#host#RegisterPlugin('finder', '0', [
\ {'type': 'command', 'name': 'Finder', 'sync': 1, 'opts': {'complete': 'customlist,FinderCommands', 'nargs': '?'}},
\ {'type': 'function', 'name': 'FinderCommands', 'sync': 1, 'opts': {}},
\ ])
