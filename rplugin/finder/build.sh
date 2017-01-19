#!/bin/bash

gox -arch="amd64" -os="darwin linux windows" -output="./rplugin/finder/bin/{{.Dir}}_{{.OS}}_{{.Arch}}" ./rplugin/finder
