local g = vim.g
local o = vim.o
local bo = vim.bo
local wo = vim.wo
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
wo.number = true
wo.relativenumber = true
wo.numberwidth = 1

-- tabs
o.smarttab = true
bo.expandtab = false
bo.shiftwidth = 4
bo.softtabstop = 4
bo.tabstop = 8
bo.autoindent = true

