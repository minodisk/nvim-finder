package main

import (
	"errors"
	"fmt"
	"path/filepath"

	"github.com/minodisk/go-nvim/buffer"
	"github.com/minodisk/go-nvim/nvim"
	"github.com/minodisk/go-nvim/window"
	tree "github.com/minodisk/go-tree"
)

const (
	ConfigBufferName = "finder_buffer_name"
	ConfigWidth      = "finder_width"

	DefaultBufferName = ".finder"
	DefaultWidth      = 30
)

var (
	staticFinder *Finder
)

type Finder struct {
	nvim   *nvim.Nvim
	tree   *tree.Tree
	window *window.Window
	buffer *buffer.Buffer
	closed bool
}

func New(v *nvim.Nvim) (*Finder, error) {
	f := &Finder{nvim: v}

	cw := v.NearestDirectory()

	{
		var err error
		f.tree, err = tree.New(cw, tree.ConfigDefault)
		if err != nil {
			return f, err
		}
	}

	width, err := v.VarInt(ConfigWidth)
	if err != nil || width == 0 {
		width = DefaultWidth
	}
	bufferName, err := v.VarString(ConfigBufferName)
	if err != nil || bufferName == "" {
		bufferName = DefaultBufferName
	}
	name := filepath.Join(cw, bufferName)
	{
		var err error
		f.window, err = v.CreateWindowLeft(width, name)
		if err != nil {
			return f, err
		}
	}
	if err := f.window.Focus(); err != nil {
		return f, err
	}
	if err := f.window.SetOption(window.Option{
		FoldColumn:  0,
		FoldEnable:  false,
		List:        false,
		Spell:       false,
		WinFixWidth: true,
		Wrap:        false,
	}); err != nil {
		return f, err
	}

	{
		var err error
		f.buffer, err = f.window.Buffer()
		if err != nil {
			return f, err
		}
		if err := f.buffer.SetOption(buffer.Option{
			BufHidden:  "hide",
			BufListed:  false,
			BufType:    "nofile",
			ReadOnly:   false,
			SwapFile:   false,
			Modifiable: false,
			Modified:   false,
		}); err != nil {
			return f, err
		}
		if err := f.buffer.SetFileType("finder"); err != nil {
			return f, err
		}
	}

	if err := f.tree.Open(f.Render); err != nil {
		return f, err
	}
	return f, nil
}

func (f *Finder) Valid() bool {
	bv, err := f.buffer.Valid()
	if err != nil {
		return false
	}
	wv, err := f.window.Valid()
	if err != nil {
		return false
	}
	return bv && wv
}

func (f *Finder) Cursor() (int, error) {
	p, err := f.buffer.CurrentCursor()
	if err != nil {
		return 0, err
	}
	return p.Y(), nil
}

func (f *Finder) SetCursor(at int) error {
	p, err := f.buffer.CurrentCursor()
	if err != nil {
		return err
	}
	p.SetY(at)
	return f.buffer.SetCurrentCursor(p)
}

func (f *Finder) Window() (*window.Window, error) {
	ws, err := f.nvim.Windows()
	if err != nil {
		return nil, err
	}

	for _, w := range ws {
		b, err := w.Buffer()
		if err != nil {
			continue
		}
		t, err := b.FileType()
		if err != nil {
			continue
		}
		if t == "finder" {
			continue
		}
		return w, nil
	}

	return nil, errors.New("window not found")
}

func (f *Finder) Render(lines [][]byte) error {
	// var mem runtime.MemStats
	// runtime.ReadMemStats(&mem)
	// f.nvim.Printf("rendered (%droutines, %dbytes, %dallocs, %dtallocs)\n", runtime.NumGoroutine(), mem.HeapAlloc, mem.Alloc, mem.TotalAlloc)
	return f.buffer.Write(lines)
}

func (f *Finder) OpenFile(file *tree.File) error {
	var (
		w   *window.Window
		err error
	)
	w, err = f.Window()
	if err == nil {
		err = w.Open(file.Path())
	} else {
		w, err = f.nvim.CreateWindowRight(0, file.Path())
	}
	if err != nil {
		return err
	}
	if err := w.Focus(); err != nil {
		return err
	}
	return f.window.ResizeToDefaultWidth()
}

// Commands

func (f *Finder) Closed() bool {
	return f.closed || !f.Valid()
}

func (f *Finder) Close() error {
	f.closed = true
	return f.window.Close()
}

func (f *Finder) CD() error {
	return f.tree.CD(func() (string, error) {
		dir, err := f.nvim.InputString("Enter the destination directory", "", nvim.CompletionDir)
		if err != nil {
			return "", err
		}
		// if filepath.IsAbs(p) {
		// 	return p, nil
		// }
		// cd, err := f.nvim.CurrentDirectory()
		// if err != nil {
		// 	return "", err
		// }
		if err := f.nvim.SetCurrentDirectory(dir); err != nil {
			return "", err
		}
		dir, err = f.nvim.CurrentDirectory()
		if err != nil {
			return "", err
		}
		return dir, nil
	}, f.Render)
}

func (f *Finder) Root() error {
	return f.tree.CD(func() (string, error) {
		return "/", nil
	}, f.Render)
}

func (f *Finder) Home() error {
	return f.tree.CD(func() (string, error) {
		return "~", nil
	}, f.Render)
}

func (f *Finder) Up() error {
	return f.tree.Up(f.Cursor, f.Render)
}

func (f *Finder) Down() error {
	return f.tree.Down(f.Cursor, f.OpenFile, f.Render)
}

func (f *Finder) Select() error {
	return f.tree.Select(f.Cursor, f.SetCursor, f.Render)
}

func (f *Finder) SelectAll() error {
	return f.tree.SelectAll(f.Render)
}

func (f *Finder) Toggle() error {
	return f.tree.Toggle(f.Cursor, f.Render)
}

func (f *Finder) ToggleRec() error {
	return f.tree.ToggleRec(f.Cursor, f.Render)
}

func (f *Finder) CreateDir() error {
	return f.tree.CreateDir(f.Cursor, func() ([]string, error) {
		return f.nvim.InputStrings("Enter the directory names to create", nil, nvim.CompletionNone)
	}, f.Render)
}

func (f *Finder) CreateFile() error {
	return f.tree.CreateFile(f.Cursor, func() ([]string, error) {
		return f.nvim.InputStrings("Enter the file names to create", nil, nvim.CompletionNone)
	}, f.Render)
}

func (f *Finder) Rename() error {
	return f.tree.Rename(f.Cursor, func(o tree.Operator) (string, error) {
		return f.nvim.Input(fmt.Sprintf("Rename the %s '%s' to", o.Type(), o.Name()), o.Name(), nvim.CompletionNone)
	}, func(os ...tree.Operator) ([]string, error) {
		names := make([]string, len(os))
		for i, o := range os {
			names[i] = o.Name()
		}
		return f.nvim.InputStrings("Rename the objects to", names, nvim.CompletionNone)
	}, func() error {
		return f.nvim.Printf("Renaming has been canceled.\n")
	}, f.Render)
}

func (f *Finder) Move() error {
	return f.tree.Move(f.Cursor, func(os ...tree.Operator) (string, error) {
		if len(os) == 1 {
			o := os[0]
			return f.nvim.InputString(fmt.Sprintf("Enter the destination to move the %s '%s'", o.Type(), o.Name()), "", nvim.CompletionDir)
		}
		return f.nvim.InputString("Enter the destination to move the selected files", "", nvim.CompletionDir)
	}, func() error {
		return f.nvim.Printf("Moving has been canceled.\n")
	}, f.Render)
}

func (f *Finder) Remove() error {
	return f.tree.Remove(f.Cursor, func(os ...tree.Operator) (bool, error) {
		if len(os) == 1 {
			o := os[0]
			return f.nvim.InputBool(fmt.Sprintf("Are you sure you want to permanently remove the %s '%s'?", o.Type(), o.Name()))
		}
		return f.nvim.InputBool("Are you sure you want to permanently remove the selected objects?")
	}, func() error {
		return f.nvim.Printf("Remove has been canceled.\n")
	}, f.Render)
}

func (f *Finder) OpenExternally() error {
	return f.tree.OpenExternally(f.Cursor, f.Render)
}

func (f *Finder) OpenDirExternally() error {
	return f.tree.OpenDirExternally(f.Cursor, f.Render)
}
