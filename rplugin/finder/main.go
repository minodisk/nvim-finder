package main

import (
	"errors"

	"github.com/minodisk/go-nvim/nvim"
	cnvim "github.com/neovim/go-client/nvim"
	cplugin "github.com/neovim/go-client/nvim/plugin"
)

var (
	finder *Finder
)

func main() {
	cplugin.Main(plug)
}

func plug(p *cplugin.Plugin) error {
	p.HandleCommand(&cplugin.CommandOptions{
		Name:  "Finder",
		NArgs: "?",
	}, handle)
	return nil
}

const (
	CommandInit      = "init"
	CommandUp        = "up"
	CommandDown      = "down"
	CommandToggle    = "toggle"
	CommandToggleRec = "toggle_rec"
	CommandSelect    = "select"

	CommandCreateDir  = "create_dir"
	CommandCreateFile = "create_file"
	CommandRename     = "rename"
	CommandMove       = "move"
	CommandRemove     = "remove"
	CommandOpenWithOS = "open_with_os"
)

func handle(v *cnvim.Nvim, args []string) error {
	var c string
	if len(args) == 0 {
		c = CommandInit
	} else {
		c = args[0]
	}
	switch c {
	case CommandInit:
		if finder != nil && finder.Valid() {
			if err := finder.Close(); err != nil {
				return err
			}
			finder = nil
			return nil
		}
		var err error
		finder, err = New(nvim.New(v))
		if err != nil {
			return err
		}
		return nil
	case CommandUp:
		return finder.Up()
	case CommandDown:
		return finder.Down()
	case CommandToggle:
		return finder.Toggle()
	case CommandToggleRec:
		return finder.ToggleRec()
	case CommandSelect:
		return finder.Select()

	case CommandCreateDir:
		return finder.CreateDir()
	case CommandCreateFile:
		return finder.CreateFile()
	case CommandRename:
		return finder.Rename()
	case CommandMove:
		return finder.Move()
	case CommandRemove:
		return finder.Remove()
	case CommandOpenWithOS:
		return finder.OpenWithOS()
	default:
		return errors.New("undefined Finder command")
	}
}
