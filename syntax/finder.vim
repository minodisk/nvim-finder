" nvim-finder

syntax match finderDir /.*\/$/
syntax match finderPrefix /^\s*[|+-]/
syntax match finderSelected /^\s*\*.*$/

highlight link finderDir            Identifier
highlight link finderPrefix         Delimiter
highlight link finderSelected       Type
