set nocompatible

runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

syn on
filetype plugin indent on

set t_Co=256

colorscheme molokai

set sw=2
set ts=2
set hidden
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
set history=10000
set undofile
set undolevels=10000
set undoreload=10000
set noswapfile
set nobackup
set undofile
set undodir=~/.vim/undo//
set foldenable
set wildmenu
set wildmode=longest,full
set completeopt=menu,menuone,longest
set nomodeline
set mouse=a
set laststatus=2
set encoding=utf-8
set colorcolumn=79
set title

noremap ; :

nnoremap Q <nop>

noremap <silent> <C-w> :wincmd k<cr>
noremap <silent> <C-a> :wincmd h<cr>
noremap <silent> <C-s> :wincmd j<cr>
noremap <silent> <C-d> :wincmd l<cr>
noremap <silent> <A-w> :wincmd K<cr>
noremap <silent> <A-a> :wincmd H<cr>
noremap <silent> <A-s> :wincmd J<cr>
noremap <silent> <A-d> :wincmd L<cr>
inoremap <silent> <C-w> <C-o>:wincmd k<cr>
inoremap <silent> <C-a> <C-o>:wincmd h<cr>
inoremap <silent> <C-s> <C-o>:wincmd j<cr>
inoremap <silent> <C-d> <C-o>:wincmd l<cr>
inoremap <silent> <A-w> <C-o>:wincmd K<cr>
inoremap <silent> <A-a> <C-o>:wincmd H<cr>
inoremap <silent> <A-s> <C-o>:wincmd J<cr>
inoremap <silent> <A-d> <C-o>:wincmd L<cr>

noremap <silent> <C-r> <C-w>v<cr>
inoremap <silent> <C-r> <C-o><C-w>v<cr>

noremap <silent> <C-/> :nohlsearch<cr>
inoremap <silent> <C-/> <C-o>:nohlsearch<cr>

vnoremap <silent> <C-x> "+x
vnoremap <silent> <C-c> "+y
noremap <silent> <C-v> "+gP
inoremap <silent> <C-v> <C-o>"+gP

noremap <silent> <C-z> u
inoremap <silent> <C-z> <C-o>u

au VimEnter * RainbowParenthesesToggleAll
au FileType c,cpp :Rooter

let g:tagbar_autofocus=1
let g:tagbar_compact=1
let g:tagbar_autoclose=1
let g:syntastic_enable_signs=1
let g:syntastic_check_on_open=1
let g:syntastic_auto_loc_list=1
let g:syntastic_c_auto_refresh_includes=1
let g:syntastic_c_check_header=1
let g:syntastic_c_compiler_options='-Wall -Wextra -Wno-unused-parameter -pedantic -std=gnu99'
let g:syntastic_c_include_dirs=split(system("find src -print0 -iname \*.h | xargs -0 -r -n 1 dirname | sort -u"), '\n')
let g:syntastic_error_symbol='E'
let g:syntastic_warning_symbol='W'
let g:Powerline_symbols='unicode'
let g:easytags_by_filetype="~/.vim/tags/"

noremap <silent> <C-q> :CtrlPBuffer<cr>
noremap <silent> <C-e> :CtrlP<cr>
noremap <silent> <C-g> :GundoToggle<cr>
noremap <silent> <C-f> :TagbarToggle<cr>

inoremap <silent> <C-q> <C-o>:CtrlPBuffer<cr>
inoremap <silent> <C-e> <C-o>:CtrlP<cr>
inoremap <silent> <C-g> <C-o>:GundoToggle<cr>
inoremap <silent> <C-f> <C-o>:TagbarToggle<cr>

if has("gui_running")
  set guifont=Fixed\ 11
  set go-=T
  set go-=m
  set t_md=
endif

