local g = vim.g
local o = vim.o
local cmd = vim.cmd

-- generic
o.autoread = true
o.backspace = [[indent,eol,start]]
o.clipboard = [[unnamed,unnamedplus]]
o.display = 'lastline'
o.encoding = 'utf-8'
o.hidden = true
o.laststatus = 2
o.ruler = true
o.scrolloff = 10
o.sidescrolloff = 10
o.termguicolors = true

-- number line
o.number = true
o.relativenumber = true
o.numberwidth = 1

-- tabs
o.autoindent = true
o.expandtab = false
o.shiftwidth = 4
o.smarttab = true
o.softtabstop = 4
o.tabstop = 8

