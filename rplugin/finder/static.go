package main

import (
	"github.com/minodisk/go-nvim/nvim"
	tree "github.com/minodisk/go-tree"
	cnvim "github.com/neovim/go-client/nvim"
)

var (
	finders = []*Finder{}
	context = &tree.Context{}
)

func CurrentFinder() *Finder {
	for _, f := range finders {
		_, err := f.Buffer()
		if err != nil {
			continue
		}
		return f
	}
	return nil
}

func Closed() bool {
	if len(finders) == 0 {
		return true
	}

	closed := true
	for _, f := range finders {
		c := f.Closed()
		if !c {
			return false
		}
		closed = closed && c
	}
	return closed
}

func Switch(cv *cnvim.Nvim) error {
	if Closed() {
		finders = []*Finder{}
		return Create(cv)
	}

	for _, f := range finders {
		if err := f.Close(); err != nil {
			return err
		}
	}
	finders = []*Finder{}
	return nil
}

func Create(cv *cnvim.Nvim) error {
	v := nvim.New(cv)
	f, err := New(v, len(finders), context)
	if err != nil {
		return err
	}
	finders = append(finders, f)
	return nil
}

func Quit(cv *cnvim.Nvim) error {
	f := CurrentFinder()
	if f == nil {
		return nil
	}

	if err := f.Close(); err != nil {
		return err
	}

	fs := []*Finder{}
	for _, finder := range finders {
		if finder == f {
			continue
		}
		fs = append(fs, finder)
	}
	finders = fs

	return nil
}

func QuitAll(cv *cnvim.Nvim) error {
	for _, finder := range finders {
		if err := finder.Close(); err != nil {
			return err
		}
	}
	finders = []*Finder{}
	return nil
}

func CD(cv *cnvim.Nvim) error {
	f := CurrentFinder()
	if f == nil || f.Closed() {
		return nil
	}
	return f.CD()
}

func Root(cv *cnvim.Nvim) error {
	f := CurrentFinder()
	if f == nil || f.Closed() {
		return nil
	}
	return f.Root()
}

func Home(cv *cnvim.Nvim) error {
	f := CurrentFinder()
	if f == nil || f.Closed() {
		return nil
	}
	return f.Home()
}

func Trash(cv *cnvim.Nvim) error {
	f := CurrentFinder()
	if f == nil || f.Closed() {
		return nil
	}
	return f.Trash()
}

func Project(cv *cnvim.Nvim) error {
	f := CurrentFinder()
	if f == nil || f.Closed() {
		return nil
	}
	return f.Project()
}

func Up(cv *cnvim.Nvim) error {
	f := CurrentFinder()
	if f == nil || f.Closed() {
		return nil
	}
	return f.Up()
}

func Down(cv *cnvim.Nvim) error {
	f := CurrentFinder()
	if f == nil || f.Closed() {
		return nil
	}
	return f.Down()
}

func Select(cv *cnvim.Nvim) error {
	f := CurrentFinder()
	if f == nil || f.Closed() {
		return nil
	}
	return f.Select()
}

func ReverseSelected(cv *cnvim.Nvim) error {
	f := CurrentFinder()
	if f == nil || f.Closed() {
		return nil
	}
	return f.ReverseSelected()
}

func Toggle(cv *cnvim.Nvim) error {
	f := CurrentFinder()
	if f == nil || f.Closed() {
		return nil
	}
	return f.Toggle()
}

func ToggleRec(cv *cnvim.Nvim) error {
	f := CurrentFinder()
	if f == nil || f.Closed() {
		return nil
	}
	return f.ToggleRec()
}

func CreateDir(cv *cnvim.Nvim) error {
	f := CurrentFinder()
	if f == nil || f.Closed() {
		return nil
	}
	return f.CreateDir()
}

func CreateFile(cv *cnvim.Nvim) error {
	f := CurrentFinder()
	if f == nil || f.Closed() {
		return nil
	}
	return f.CreateFile()
}

func Rename(cv *cnvim.Nvim) error {
	f := CurrentFinder()
	if f == nil || f.Closed() {
		return nil
	}
	return f.Rename()
}

func Move(cv *cnvim.Nvim) error {
	f := CurrentFinder()
	if f == nil || f.Closed() {
		return nil
	}
	return f.Move()
}

func OpenExternally(cv *cnvim.Nvim) error {
	f := CurrentFinder()
	if f == nil || f.Closed() {
		return nil
	}
	return f.OpenExternally()
}

func OpenDirExternally(cv *cnvim.Nvim) error {
	f := CurrentFinder()
	if f == nil || f.Closed() {
		return nil
	}
	return f.OpenDirExternally()
}

func Remove(cv *cnvim.Nvim) error {
	f := CurrentFinder()
	if f == nil || f.Closed() {
		return nil
	}
	return f.Remove()
}

func RemovePermanently(cv *cnvim.Nvim) error {
	f := CurrentFinder()
	if f == nil || f.Closed() {
		return nil
	}
	return f.RemovePermanently()
}

func Restore(cv *cnvim.Nvim) error {
	f := CurrentFinder()
	if f == nil || f.Closed() {
		return nil
	}
	return f.Restore()
}

func Copy(cv *cnvim.Nvim) error {
	f := CurrentFinder()
	if f == nil || f.Closed() {
		return nil
	}
	return f.Copy()
}

func CopiedList(cv *cnvim.Nvim) error {
	f := CurrentFinder()
	if f == nil || f.Closed() {
		return nil
	}
	return f.CopiedList()
}

func Paste(cv *cnvim.Nvim) error {
	f := CurrentFinder()
	if f == nil || f.Closed() {
		return nil
	}
	return f.Paste()
}

func Yank(cv *cnvim.Nvim) error {
	f := CurrentFinder()
	if f == nil || f.Closed() {
		return nil
	}
	return f.Yank()
}
