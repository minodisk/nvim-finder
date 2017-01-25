#!/bin/bash

gox -arch="amd64" -os="darwin linux windows" -output="./rplugin/finder/bin/{{.Dir}}_{{.OS}}_{{.Arch}}" ./rplugin/finder &&
./rplugin/finder/bin/finder_linux_amd64 -manifest=finder > ./plugin/finder/manifest.vim &&
./rplugin/finder/bin/finder_linux_amd64 -keymap          > ./autoload/finder/keymap.vim
