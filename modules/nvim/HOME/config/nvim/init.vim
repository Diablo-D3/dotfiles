set number relativenumber
set laststatus=3
set clipboard+=unnamedplus
set mouse=a
set termguicolors

set autoindent smartindent expandtab tabstop=4 softtabstop=4 shiftwidth=4
set wrap

set hidden
set noswapfile
set undofile

set completeopt=menu,menuone,noselect,noinsert

let mapleader = "\<Space>"

" If in fish, use sh instead
if &shell =~# 'fish$'
    set shell=sh
endif

" Terminal
augroup term
    au TermOpen * setlocal listchars= nonumber norelativenumber
    au TermOpen * startinsert
    au BufEnter,BufWinEnter,WinEnter term://* startinsert
    au BufLeave term://* stopinsert
augroup END

lua require('config')
