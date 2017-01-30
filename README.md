# nvim-finder

File manager for NeoVim.

## Installation

### dein

dein.toml:

```toml
[[plugins]]
repo = 'minodisk/nvim-finder'
hook_post_update = '''
echomsg system('wget -q -O /path/to/executable/nvim-finder https://github.com/minodisk/go-nvim-finder/releases/download/v0.0.1/finder_linux_amd64 && chmod a+x /path/to/executable/nvim-finder')
```
