package finder

import (
	"errors"
	"fmt"
	"path/filepath"
	"runtime"

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
}

func New(v *nvim.Nvim) (*Finder, error) {
	f := &Finder{nvim: v}

	cw, err := v.CurrentBufferName()
	if err == nil {
		cw = filepath.Dir(cw)
	} else {
		cw, err = homeDir()
		if err != nil {
			cw = "/"
		}
	}

	{
		var err error
		f.tree, err = tree.New(cw, tree.ConfigDefault)
		if err != nil {
			return f, err
		}
		f.tree.HandleOpenFile(f.OpenFile)
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

	if err := f.tree.Open(); err != nil {
		return f, err
	}
	if err := f.Render(); err != nil {
		return f, err
	}

	return f, nil
}

// func (f *Finder) OnChanged(o tree.Operator) {
// 	f.Render()
// }

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

func (f *Finder) Close() error {
	return f.window.Close()
}

func (f *Finder) Render() error {
	// if err := f.tree.Scan(); err != nil {
	// 	return err
	// }
	var mem runtime.MemStats
	runtime.ReadMemStats(&mem)
	f.nvim.Printf("rendered (%droutines, %dbytes, %dallocs, %dtallocs)\n", runtime.NumGoroutine(), mem.HeapAlloc, mem.Alloc, mem.TotalAlloc)
	return f.buffer.Write(f.tree.Lines())
}

func (f *Finder) Up() error {
	p, err := f.buffer.CurrentCursor()
	if err != nil {
		return err
	}
	if err := f.tree.UpAt(p.X); err != nil {
		return err
	}
	return f.Render()
}

func (f *Finder) Down() error {
	p, err := f.buffer.CurrentCursor()
	if err != nil {
		return err
	}
	if err := f.tree.DownAt(p.X); err != nil {
		return err
	}
	return f.Render()
}

func (f *Finder) OpenFile(name string) error {
	var (
		w   *window.Window
		err error
	)
	w, err = f.Window()
	if err == nil {
		err = w.Open(name)
	} else {
		w, err = f.nvim.CreateWindowRight(0, name)
	}
	if err != nil {
		return err
	}
	if err := w.Focus(); err != nil {
		return err
	}
	return f.window.ResizeToDefaultWidth()
}

func (f *Finder) Toggle() error {
	p, err := f.buffer.CurrentCursor()
	if err != nil {
		return err
	}
	if err := f.tree.ToggleAt(p.X); err != nil {
		return err
	}
	return f.Render()
}

func (f *Finder) ToggleRec() error {
	p, err := f.buffer.CurrentCursor()
	if err != nil {
		return err
	}
	if err := f.tree.ToggleRecAt(p.X); err != nil {
		return err
	}
	return f.Render()
}

func (f *Finder) CreateDir() error {
	p, err := f.buffer.CurrentCursor()
	if err != nil {
		return err
	}
	names, err := f.nvim.InputStrings("Enter the directory names to create")
	if err != nil {
		return err
	}
	if err := f.tree.CreateDirAt(p.X, names...); err != nil {
		return err
	}
	return f.Render()
}

func (f *Finder) CreateFile() error {
	names, err := f.nvim.InputStrings("Enter the directory names to create")
	if err != nil {
		return err
	}
	p, err := f.buffer.CurrentCursor()
	if err != nil {
		return err
	}
	if err := f.tree.CreateFileAt(p.X, names...); err != nil {
		return err
	}
	return f.Render()
}

func (f *Finder) Rename() error {
	p, err := f.buffer.CurrentCursor()
	if err != nil {
		return err
	}
	o, ok := f.tree.IndexOf(p.X)
	if !ok {
		//
	}

	old := o.Name()
	new, err := f.nvim.Input(fmt.Sprintf("Rename the %s '%s' to", o.Type(), old), old)
	if err != nil {
		return err
	}
	if err := o.Rename(new); err != nil {
		return err
	}

	return f.Render()
}

func (f *Finder) Select() error {
	p, err := f.buffer.CurrentCursor()
	if err != nil {
		return err
	}
	if err := f.tree.ToggleSelectedAt(p.X); err != nil {
		return err
	}
	return f.Render()
}

func (f *Finder) Move() error {
	if f.tree.HasSelected() {
		path, err := f.nvim.InputString("Enter the destination to move the selected files")
		if err != nil {
			return err
		}
		if err := f.tree.MoveSelected(path); err != nil {
			return err
		}
		return f.Render()
	}

	p, err := f.buffer.CurrentCursor()
	if err != nil {
		return err
	}
	o, ok := f.tree.IndexOf(p.X)
	if !ok {
		//
	}
	path, err := f.nvim.InputString(fmt.Sprintf("Enter the destination to move the %s '%s'", o.Type(), o.Name()))
	if err != nil {
		return err
	}
	if err := f.tree.MoveAt(p.X, path); err != nil {
		return err
	}
	return f.Render()
}

func (f *Finder) Remove() error {
	if f.tree.HasSelected() {
		ok, err := f.nvim.InputBool("Are you sure you want to permanently remove the selected files?")
		if err != nil {
			return err
		}
		if !ok {
			// Do nothing.
			return nil
		}
		if err := f.tree.RemoveSelected(); err != nil {
			return err
		}
		return f.Render()
	}

	p, err := f.buffer.CurrentCursor()
	if err != nil {
		return err
	}
	o, ok := f.tree.IndexOf(p.X)
	if !ok {
		//
	}
	ok, err = f.nvim.InputBool(fmt.Sprintf("Are you sure you want to permanently remove the %s '%s'?", o.Type(), o.Name()))
	if err != nil {
		return err
	}
	if !ok {
		// Do nothing.
		return nil
	}
	if err := o.Remove(); err != nil {
		return err
	}
	return f.Render()
}
