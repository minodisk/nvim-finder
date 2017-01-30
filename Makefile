tag := $(shell git describe --tags --abbrev=0)
url := https://github.com/minodisk/go-nvim-finder/releases/download/$(tag)/finder_linux_amd64
path := ~/bin/nvim-finder

all:
	wget -q -O $(path) $(url)
	chmod a+x $(path)
