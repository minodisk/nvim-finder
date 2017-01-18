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
	CommandInit       = "init"
	CommandUp         = "up"
	CommandDown       = "down"
	CommandToggle     = "toggle"
	CommandToggleRec  = "toggle_rec"
	CommandCreateDir  = "create_dir"
	CommandCreateFile = "create_file"
	CommandRename     = "rename"
	CommandMove       = "move"
	CommandRemove     = "remove"
	CommandSelect     = "select"
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
		return _init(v)
	case CommandUp:
		return up(v)
	case CommandDown:
		return down(v)
	case CommandToggle:
		return toggle(v)
	case CommandToggleRec:
		return toggleRec(v)
	case CommandCreateDir:
		return createDir(v)
	case CommandCreateFile:
		return createFile(v)
	case CommandRename:
		return rename(v)
	case CommandMove:
		return move(v)
	case CommandRemove:
		return remove(v)
	case CommandSelect:
		return _select(v)
	default:
		return undefined(v)
	}
}

func _init(v *cnvim.Nvim) error {
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
}

func up(v *cnvim.Nvim) error {
	return finder.Up()
}

func down(v *cnvim.Nvim) error {
	return finder.Down()
}

func toggle(v *cnvim.Nvim) error {
	return finder.Toggle()
}

func toggleRec(v *cnvim.Nvim) error {
	return finder.ToggleRec()
}

func createDir(v *cnvim.Nvim) error {
	return finder.CreateDir()
}

func createFile(v *cnvim.Nvim) error {
	return finder.CreateFile()
}

func rename(v *cnvim.Nvim) error {
	return finder.Rename()
}

func move(v *cnvim.Nvim) error {
	return finder.Move()
}

func remove(v *cnvim.Nvim) error {
	return finder.Remove()
}

func _select(v *cnvim.Nvim) error {
	return finder.Select()
}

func undefined(v *cnvim.Nvim) error {
	return errors.New("undefined Finder command")
}
