set number relativenumber
set clipboard+=unnamedplus
set mouse=a
set termguicolors

set autoindent smartindent expandtab tabstop=4 softtabstop=4 shiftwidth=4
set wrap

set hidden
set noswapfile
set undofile

set completeopt=menu,menuone,noselect,preview

let mapleader = "\<Space>"

" If in fish, use sh instead
if &shell =~# 'fish$'
    set shell=sh
endif

" Set alt buffer when loading multiple files
au VimEnter * if !bufname(2)->empty() | balt #2 | endif

" Normalize direct buffer selection
map <silent> <C-tab> :e #<CR>
map <silent> <C-1> :b1<CR>
map <silent> <C-2> :b2<CR>
map <silent> <C-3> :b3<CR>
map <silent> <C-4> :b4<CR>
map <silent> <C-5> :b5<CR>
map <silent> <C-6> :b6<CR>
map <silent> <C-7> :b7<CR>
map <silent> <C-8> :b8<CR>
map <silent> <C-9> :b9<CR>
map <silent> <C-0> :b10<CR>

lua require('config')
