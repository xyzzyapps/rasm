package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"

	"fyne.io/fyne/v2"
	"fyne.io/fyne/v2/app"
	"fyne.io/fyne/v2/container"
	"fyne.io/fyne/v2/dialog"
	"fyne.io/fyne/v2/theme"
	"fyne.io/fyne/v2/widget"

	"rasmdis/internal/disasm"
)

type browser struct {
	win  fyne.Window
	bin  *disasm.Binary
	sec  int
	rows []disasm.Row
	view []disasm.Row
	base uint64
	mode int
	hold bool

	section *widget.Select
	modeBox *widget.RadioGroup
	baseBox *widget.Entry
	start   *widget.Entry
	filter  *widget.Entry
	table   *widget.Table
	pick    int
	detail  *widget.Label
	hex     *widget.Label
	status  *widget.Label
}

func runGUI(initial string) {
	a := app.NewWithID("com.xyzzyapps.rasmdis")
	a.Settings().SetTheme(theme.DarkTheme())
	w := a.NewWindow("rasmdis")
	w.Resize(fyne.NewSize(1180, 760))

	b := newBrowser(w)
	w.SetContent(b.layout())
	w.SetOnDropped(func(_ fyne.Position, uris []fyne.URI) {
		if len(uris) == 0 {
			return
		}
		b.openPath(uriPath(uris[0]))
	})
	if initial != "" {
		b.openPath(initial)
	}
	w.ShowAndRun()
}

func newBrowser(w fyne.Window) *browser {
	b := &browser{
		win:    w,
		mode:   64,
		pick:   -1,
		detail: widget.NewLabel("Open a Windows exe, dll, or lib, a Linux executable or .so, or a macOS executable or .dylib.\nThe table shows Readable Assembly names. Select a line to see the Intel mnemonic."),
		hex:    widget.NewLabel(""),
		status: widget.NewLabel("No file."),
	}
	b.detail.TextStyle = fyne.TextStyle{Monospace: true}
	b.detail.Wrapping = fyne.TextWrapWord
	b.hex.TextStyle = fyne.TextStyle{Monospace: true}

	b.section = widget.NewSelect(nil, func(string) {
		if b.hold || b.bin == nil {
			return
		}
		b.sec = b.section.SelectedIndex()
		if b.sec < 0 || b.sec >= len(b.bin.Sections) {
			b.sec = 0
		}
		b.hold = true
		sec := b.bin.Sections[b.sec]
		b.baseBox.SetText(fmt.Sprintf("%#x", sec.Addr))
		b.start.SetText("0")
		if sec.Mode != 0 {
			b.modeBox.SetSelected(modeLabel(sec.Mode))
		}
		b.hold = false
		b.decode()
	})
	b.modeBox = widget.NewRadioGroup([]string{"64-bit", "32-bit", "16-bit"}, func(string) {
		if b.hold {
			return
		}
		b.mode = b.modeValue()
		b.decode()
	})
	b.modeBox.Horizontal = true
	b.modeBox.SetSelected("64-bit")

	b.baseBox = widget.NewEntry()
	b.baseBox.SetPlaceHolder("0x0")
	b.baseBox.OnSubmitted = func(string) { b.decode() }
	b.start = widget.NewEntry()
	b.start.SetText("0")
	b.start.SetPlaceHolder("0")
	b.start.OnSubmitted = func(string) { b.decode() }
	b.filter = widget.NewEntry()
	b.filter.SetPlaceHolder("filter text or address")
	b.filter.OnChanged = func(string) { b.applyFilter() }

	b.table = widget.NewTableWithHeaders(
		func() (int, int) { return len(b.view), 3 },
		func() fyne.CanvasObject {
			l := widget.NewLabel("template")
			l.TextStyle = fyne.TextStyle{Monospace: true}
			l.Truncation = fyne.TextTruncateEllipsis
			return l
		},
		func(id widget.TableCellID, obj fyne.CanvasObject) {
			l := obj.(*widget.Label)
			l.TextStyle = fyne.TextStyle{Monospace: true}
			if id.Row < 0 || id.Row >= len(b.view) {
				l.SetText("")
				return
			}
			row := b.view[id.Row]
			switch id.Col {
			case 0:
				l.SetText(fmt.Sprintf("%#x", row.Addr))
			case 1:
				l.SetText(disasm.HexBytes(row.Bytes))
			default:
				l.SetText(row.Readable)
			}
		},
	)
	b.table.ShowHeaderColumn = false
	b.table.UpdateHeader = func(id widget.TableCellID, obj fyne.CanvasObject) {
		l := obj.(*widget.Label)
		l.TextStyle = fyne.TextStyle{Bold: true}
		headers := []string{"Address", "Bytes", "Readable Assembly"}
		if id.Col >= 0 && id.Col < len(headers) {
			l.SetText(headers[id.Col])
			return
		}
		l.SetText("")
	}
	b.table.SetColumnWidth(0, 140)
	b.table.SetColumnWidth(1, 200)
	b.table.SetColumnWidth(2, 760)
	b.table.OnSelected = func(id widget.TableCellID) {
		b.showRow(id.Row)
	}
	return b
}

func (b *browser) layout() fyne.CanvasObject {
	openBtn := widget.NewButton("Open", func() {
		dialog.ShowFileOpen(func(rc fyne.URIReadCloser, err error) {
			if err != nil {
				dialog.ShowError(err, b.win)
				return
			}
			if rc == nil {
				return
			}
			p := uriPath(rc.URI())
			rc.Close()
			b.openPath(p)
		}, b.win)
	})
	pasteBtn := widget.NewButton("Paste hex", func() { b.pasteHex() })
	exportBtn := widget.NewButton("Export", func() { b.export() })
	copyBtn := widget.NewButton("Copy line", func() { b.copyLine() })

	bar1 := container.NewHBox(openBtn, pasteBtn, exportBtn, copyBtn, widget.NewLabel("Section"), wide(420, b.section))
	bar2 := container.NewHBox(
		widget.NewLabel("Mode"), b.modeBox,
		widget.NewLabel("Base"), wide(140, b.baseBox),
		widget.NewLabel("Start"), wide(100, b.start),
		widget.NewLabel("Filter"), wide(220, b.filter),
	)
	top := container.NewVBox(bar1, bar2, widget.NewSeparator())
	bottom := container.NewVBox(widget.NewSeparator(), b.detail, b.hex, b.status)
	return container.NewBorder(top, bottom, nil, nil, b.table)
}

func wide(w float32, obj fyne.CanvasObject) fyne.CanvasObject {
	return container.NewGridWrap(fyne.NewSize(w, 36), obj)
}

func (b *browser) openPath(path string) {
	bin, err := disasm.LoadFile(path)
	if err != nil {
		dialog.ShowError(err, b.win)
		return
	}
	b.load(bin)
}

func (b *browser) load(bin *disasm.Binary) {
	b.bin = bin
	b.sec = disasm.DefaultSection(bin)
	labels := disasm.SectionChoices(bin)
	b.hold = true
	b.section.Options = labels
	b.section.SetSelectedIndex(b.sec)
	mode := bin.Mode
	if b.sec >= 0 && b.sec < len(bin.Sections) {
		b.baseBox.SetText(fmt.Sprintf("%#x", bin.Sections[b.sec].Addr))
		if bin.Sections[b.sec].Mode != 0 {
			mode = bin.Sections[b.sec].Mode
		}
	}
	b.mode = mode
	b.modeBox.SetSelected(modeLabel(mode))
	b.start.SetText("0")
	b.filter.SetText("")
	b.hold = false
	b.win.SetTitle("rasmdis — " + bin.Name)
	b.decode()
}

func (b *browser) decode() {
	if b.hold || b.bin == nil || len(b.bin.Sections) == 0 {
		return
	}
	if b.sec < 0 || b.sec >= len(b.bin.Sections) {
		b.sec = 0
	}
	sec := b.bin.Sections[b.sec]
	base, err := parseBase(b.baseBox.Text, sec.Addr)
	if err != nil {
		b.status.SetText("Base: " + err.Error())
		return
	}
	start, err := parseStart(b.start.Text)
	if err != nil {
		b.status.SetText("Start: " + err.Error())
		return
	}
	if start > len(sec.Data) {
		b.status.SetText("Start is past the end of the section.")
		return
	}
	b.base = base
	b.mode = b.modeValue()
	res := disasm.Disassemble(sec, disasm.Options{
		Base:  base,
		Mode:  b.mode,
		Start: start,
	})
	b.rows = res.Rows
	b.applyFilter()
	note := ""
	if res.Truncated {
		note = fmt.Sprintf("  Showing the first %d bytes.", disasm.DefaultWindow)
	}
	b.status.SetText(fmt.Sprintf("%s  %s  %s  %d bytes  %d lines%s",
		b.bin.Format, b.bin.Name, sec.Name, len(sec.Data), len(b.rows), note))
	if len(b.view) > 0 {
		b.table.Select(widget.TableCellID{Row: 0, Col: 0})
		b.showRow(0)
	} else {
		b.detail.SetText("This view has no rows.")
		b.hex.SetText("")
	}
}

func (b *browser) applyFilter() {
	q := strings.ToLower(strings.TrimSpace(b.filter.Text))
	view := make([]disasm.Row, 0, len(b.rows))
	for _, row := range b.rows {
		if q == "" {
			view = append(view, row)
			continue
		}
		blob := strings.ToLower(row.Intel + " " + row.Readable + " " + fmt.Sprintf("%#x", row.Addr))
		if strings.Contains(blob, q) {
			view = append(view, row)
		}
	}
	b.view = view
	if b.table != nil {
		b.table.Refresh()
		b.table.ScrollTo(widget.TableCellID{Row: 0, Col: 0})
	}
}

func (b *browser) showRow(index int) {
	if index < 0 || index >= len(b.view) || b.bin == nil {
		return
	}
	b.pick = index
	row := b.view[index]
	sec := b.bin.Sections[b.sec]
	if row.Kind == disasm.RowLabel {
		b.detail.SetText(fmt.Sprintf("%#x  %s", row.Addr, row.Readable))
	} else {
		b.detail.SetText(fmt.Sprintf("%#x  %d bytes  %s\nReadable Assembly:  %s\nIntel mnemonic:     %s",
			row.Addr, len(row.Bytes), disasm.HexBytes(row.Bytes), row.Readable, row.Intel))
	}
	b.hex.SetText(disasm.HexWindow(sec.Data, int(row.Offset), len(row.Bytes)))
}

func (b *browser) copyLine() {
	if len(b.view) == 0 {
		return
	}
	index := b.pick
	if index < 0 || index >= len(b.view) {
		index = 0
	}
	row := b.view[index]
	text := row.Readable
	if row.Kind == disasm.RowInsn {
		text = fmt.Sprintf("%#x  %s  %s", row.Addr, disasm.HexBytes(row.Bytes), row.Readable)
	}
	b.win.Clipboard().SetContent(text)
	b.status.SetText("Copied the line.")
}

func (b *browser) export() {
	if b.bin == nil || len(b.rows) == 0 {
		dialog.ShowInformation("Export", "Open a file first.", b.win)
		return
	}
	dialog.ShowFileSave(func(wc fyne.URIWriteCloser, err error) {
		if err != nil {
			dialog.ShowError(err, b.win)
			return
		}
		if wc == nil {
			return
		}
		defer wc.Close()
		sec := b.bin.Sections[b.sec]
		text := disasm.FormatListing(b.bin, sec, b.base, b.rows)
		if _, err := wc.Write([]byte(text)); err != nil {
			dialog.ShowError(err, b.win)
			return
		}
		b.status.SetText("Wrote " + uriPath(wc.URI()))
	}, b.win)
}

func (b *browser) pasteHex() {
	in := widget.NewMultiLineEntry()
	in.SetMinRowsVisible(8)
	in.SetPlaceHolder("48 c7 c0 2a 00 00 00")
	dialog.ShowCustomConfirm("Paste machine code", "Disassemble", "Cancel", in, func(ok bool) {
		if !ok {
			return
		}
		data, err := disasm.ParseHex(in.Text)
		if err != nil {
			dialog.ShowError(err, b.win)
			return
		}
		b.load(disasm.LoadBytes("pasted hex", data, b.modeValue()))
	}, b.win)
}

func (b *browser) modeValue() int {
	switch b.modeBox.Selected {
	case "32-bit":
		return 32
	case "16-bit":
		return 16
	default:
		return 64
	}
}

func modeLabel(mode int) string {
	switch mode {
	case 32:
		return "32-bit"
	case 16:
		return "16-bit"
	default:
		return "64-bit"
	}
}

func parseBase(text string, fallback uint64) (uint64, error) {
	text = strings.TrimSpace(text)
	if text == "" {
		return fallback, nil
	}
	return strconv.ParseUint(text, 0, 64)
}

func parseStart(text string) (int, error) {
	text = strings.TrimSpace(text)
	if text == "" {
		return 0, nil
	}
	v, err := strconv.ParseUint(text, 0, 64)
	if err != nil {
		return 0, err
	}
	if v > uint64(^uint(0)>>1) {
		return 0, fmt.Errorf("start is too large")
	}
	return int(v), nil
}

func uriPath(u fyne.URI) string {
	if u == nil {
		return ""
	}
	p := u.Path()
	if _, err := os.Stat(p); err == nil {
		return p
	}
	if len(p) >= 3 && p[0] == '/' && p[2] == ':' {
		return p[1:]
	}
	return p
}
