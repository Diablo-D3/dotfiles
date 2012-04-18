set nocompatible

runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

syn on
filetype plugin indent on
colorscheme molokai

set sw=2
set ts=2
set hidden
set ignorecase
set smartcase
set history=1000
set undofile
set undolevels=1000
set undoreload=10000
set backup
set backupdir=~/.vim/backup//
set directory=~/.vim/tmp//
set undofile
set undodir=~/.vim/undo//
set foldenable
set wildmenu
set wildmode=longest,full
set completeopt=menu,menuone,longest
set nomodeline
set mouse=a
set t_Co=256
set laststatus=2
set encoding=utf-8
set autochdir

au VimEnter * RainbowParenthesesToggleAll

let g:tagbar_autofocus=1
let g:tagbar_compact=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeDirArrows=1
let g:SuperTabDefaultCompletionType="context"
let g:syntastic_enable_signs=1
let g:syntastic_enable_balloons=1
let g:syntastic_check_on_open=1
let g:syntastic_auto_loc_list=1
let g:syntastic_c_auto_refresh_includes=1
let b:syntastic_c_cflags=' -I. -I.. -I../.. -I../../.. -I../../../..'
let g:clang_use_library=1
let g:clang_complete_auto=0
let g:clang_complete_macros=1
let g:clang_complete_patterns=1
let g:clang_complete_copen=1
let g:clang_periodic_quickfix=1
let g:clang_user_options=' -I. -I.. -I../.. -I../../.. -I../../../..'
let g:Powerline_symbols='unicode'
let g:easytags_file="~/.vim/tags"

noremap <silent> <F10> :GundoToggle<CR>
noremap <silent> <F11> :NERDTreeToggle<CR>
noremap <silent> <F12> :TagbarToggle<CR>

if has("gui_running")
  set guifont=Fixed\ 11
  set go-=T
  set t_md=
endif

