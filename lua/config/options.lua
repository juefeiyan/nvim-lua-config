vim.g.mapleader = " "
vim.o.tabstop = 2 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 2 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 2 -- Number of spaces inserted when indenting
vim.o.shiftround = true -- Round indent

vim.o.relativenumber = true
vim.o.number = true

vim.o.termguicolors = true
vim.o.background = "dark" -- colorschemes that can be light or dark will be made dark
vim.o.signcolumn = "yes" -- show sign column so that text doesn't shift
vim.o.cursorline = true -- Enable highlighting of the current line
vim.o.confirm = true -- Confirm to save changes before exiting modified buffer
vim.o.list = true -- Show some invisible characters (tabs...
vim.o.pumblend = 10 -- Popup blend
vim.o.pumheight = 10 -- Maximum number of entries in a popup
vim.o.showmode = false -- Dont show mode since we have a statusline
vim.o.undofile = true
vim.o.undolevels = 10000
vim.o.wrap = false
vim.o.wildmenu = true
vim.o.wildmode = "longest:full,full"
