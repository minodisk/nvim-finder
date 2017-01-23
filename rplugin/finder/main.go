package main

import (
	"fmt"

	cnvim "github.com/neovim/go-client/nvim"
	cplugin "github.com/neovim/go-client/nvim/plugin"
)

const (
	// Updating process status
	CommandSwitch  = "switch"
	CommandCreate  = "create"
	CommandQuit    = "quit"
	CommandQuitAll = "quit_all"
	// Updating current directory
	CommandRoot = "root"
	CommandHome = "home"
	CommandUp   = "up"
	CommandDown = "down"
	CommandCD   = "cd"
	// Updating object status
	CommandSelect          = "select"
	CommandReverseSelected = "reverse_selected"
	CommandToggle          = "toggle"
	CommandToggleRec       = "toggle_rec"
	// Executing system call
	CommandCreateDir         = "create_dir"
	CommandCreateFile        = "create_file"
	CommandRename            = "rename"
	CommandMove              = "move"
	CommandRemove            = "remove"
	CommandOpenExternally    = "open_externally"
	CommandOpenDirExternally = "open_dir_externally"
	// Copy and paste
	CommandCopy       = "copy"
	CommandCopiedList = "copied_list"
	CommandPaste      = "paste"
	// Clipboard
	CommandYank = "yank"
)

var (
	Commands = []string{
		CommandSwitch,
		CommandCreate,
		CommandQuit,
		CommandQuitAll,
		CommandRoot,
		CommandHome,
		CommandUp,
		CommandDown,
		CommandCD,
		CommandSelect,
		CommandReverseSelected,
		CommandToggle,
		CommandToggleRec,
		CommandCreateDir,
		CommandCreateFile,
		CommandRename,
		CommandMove,
		CommandRemove,
		CommandOpenExternally,
		CommandOpenDirExternally,
		CommandCopy,
		CommandCopiedList,
		CommandPaste,
		CommandYank,
	}

	// Functions = map[string]func(*cnvim.Nvim) error{
	// 	"FinderSwitch":            Switch,
	// 	"FinderCreate":            Create,
	// 	"FinderQuit":              Quit,
	// 	"FinderQuitAll":           QuitAll,
	// 	"FinderRoot":              Root,
	// 	"FinderHome":              Home,
	// 	"FinderUp":                Up,
	// 	"FinderDown":              Down,
	// 	"FinderCD":                CD,
	// 	"FinderSelect":            Select,
	// 	"FinderSelectAll":         SelectAll,
	// 	"FinderToggle":            Toggle,
	// 	"FinderToggleRec":         ToggleRec,
	// 	"FinderCreateDir":         CreateDir,
	// 	"FinderCreateFile":        CreateFile,
	// 	"FinderRename":            Rename,
	// 	"FinderMove":              Move,
	// 	"FinderRemove":            Remove,
	// 	"FinderOpenExternally":    OpenExternally,
	// 	"FinderOpenDirExternally": OpenDirExternally,
	// 	"FinderCopy":              Copy,
	// 	"FinderCopiedList":        CopiedList,
	// 	"FinderPaste":             Paste,
	// 	"FinderYank":              Yank,
	// }
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

	// for n, f := range Functions {
	// 	p.HandleFunction(&cplugin.FunctionOptions{
	// 		Name: n,
	// 	}, f)
	// }

	return nil
}

func FinderCommands(v *cnvim.Nvim, args []string) ([]string, error) {
	return Commands, nil
}

func CallFinder(v *cnvim.Nvim, args []string) error {
	var cmd string
	if len(args) == 0 {
		cmd = CommandSwitch
	} else {
		cmd = args[0]
	}

	switch cmd {
	case CommandSwitch:
		return Switch(v)
	case CommandCreate:
		return Create(v)
	case CommandQuit:
		return Quit(v)
	case CommandQuitAll:
		return QuitAll(v)

	case CommandCD:
		return CD(v)
	case CommandRoot:
		return Root(v)
	case CommandHome:
		return Home(v)
	case CommandUp:
		return Up(v)
	case CommandDown:
		return Down(v)

	case CommandSelect:
		return Select(v)
	case CommandReverseSelected:
		return ReverseSelected(v)
	case CommandToggle:
		return Toggle(v)
	case CommandToggleRec:
		return ToggleRec(v)

	case CommandCreateDir:
		return CreateDir(v)
	case CommandCreateFile:
		return CreateFile(v)
	case CommandRename:
		return Rename(v)
	case CommandMove:
		return Move(v)
	case CommandRemove:
		return Remove(v)
	case CommandOpenExternally:
		return OpenExternally(v)
	case CommandOpenDirExternally:
		return OpenDirExternally(v)

	case CommandCopy:
		return Copy(v)
	case CommandCopiedList:
		return CopiedList(v)
	case CommandPaste:
		return Paste(v)

	case CommandYank:
		return Yank(v)

	default:
		return fmt.Errorf("undefined command '%s'", cmd)
	}
}
