package main

import (
	"fmt"

	"github.com/minodisk/go-nvim/nvim"
	cnvim "github.com/neovim/go-client/nvim"
	cplugin "github.com/neovim/go-client/nvim/plugin"
)

const (
	// Updating process status
	CommandInit = "init"
	CommandQuit = "quit"
	// Updating current directory
	CommandRoot = "root"
	CommandHome = "home"
	CommandUp   = "up"
	CommandDown = "down"
	CommandCD   = "cd"
	// Updating object status
	CommandSelect    = "select"
	CommandSelectAll = "select_all"
	CommandToggle    = "toggle"
	CommandToggleRec = "toggle_rec"
	// Executing system call
	CommandCreateDir         = "create_dir"
	CommandCreateFile        = "create_file"
	CommandRename            = "rename"
	CommandMove              = "move"
	CommandRemove            = "remove"
	CommandOpenExternally    = "open_externally"
	CommandOpenDirExternally = "open_dir_externally"
	// Copy and paste
	CommandCopy  = "copy"
	CommandPaste = "paste"
	// Clipboard
	CommandYank = "yank"
)

var (
	Commands = []string{
		CommandInit,
		CommandQuit,
		CommandRoot,
		CommandHome,
		CommandUp,
		CommandDown,
		CommandCD,
		CommandSelect,
		CommandSelectAll,
		CommandToggle,
		CommandToggleRec,
		CommandCreateDir,
		CommandCreateFile,
		CommandRename,
		CommandMove,
		CommandRemove,
		CommandOpenExternally,
		CommandOpenDirExternally,
	}
	finder *Finder
)

func main() {
	cplugin.Main(plug)
}

func plug(p *cplugin.Plugin) error {
	p.HandleFunction(&cplugin.FunctionOptions{
		Name: "FinderCommands",
	}, FinderCommands)
	p.HandleCommand(&cplugin.CommandOptions{
		Name:     "Finder",
		NArgs:    "?",
		Complete: "customlist,FinderCommands",
	}, CallFinder)
	return nil
}

func FinderCommands(v *cnvim.Nvim, args []string) ([]string, error) {
	return Commands, nil
}

func CallFinder(v *cnvim.Nvim, args []string) error {
	var cmd string
	if len(args) == 0 {
		cmd = CommandInit
	} else {
		cmd = args[0]
	}
	switch cmd {
	case CommandInit:
		return Init(v)
	case CommandQuit:
		return Quit(v)

	case CommandCD:
		return finder.CD()
	case CommandRoot:
		return finder.Root()
	case CommandHome:
		return finder.Home()
	case CommandUp:
		return finder.Up()
	case CommandDown:
		return finder.Down()

	case CommandSelect:
		return finder.Select()
	case CommandSelectAll:
		return finder.SelectAll()
	case CommandToggle:
		return finder.Toggle()
	case CommandToggleRec:
		return finder.ToggleRec()

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
	case CommandOpenExternally:
		return finder.OpenExternally()
	case CommandOpenDirExternally:
		return finder.OpenDirExternally()

	case CommandCopy:
		return finder.Copy()
	case CommandPaste:
		return finder.Paste()

	case CommandYank:
		return finder.Yank()

	default:
		return fmt.Errorf("undefined command '%s'", cmd)
	}
}

func Init(v *cnvim.Nvim) error {
	if finder != nil && !finder.Closed() {
		return Quit(v)
	}
	var err error
	finder, err = New(nvim.New(v))
	return err
}

func Quit(v *cnvim.Nvim) error {
	defer func() {
		finder = nil
	}()
	if finder == nil {
		return nil
	}
	return finder.Close()
}
