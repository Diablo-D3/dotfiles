set nocompatible

runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

syn on
filetype plugin indent on

colorscheme molokai

hi Comment guifg=#5C7073

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
set t_Co=256
set laststatus=2
set encoding=utf-8
set colorcolumn=79
set title

noremap ; :

noremap <silent> <leader>w :wincmd k<cr>
noremap <silent> <leader>a :wincmd h<cr>
noremap <silent> <leader>s :wincmd j<cr>
noremap <silent> <leader>d :wincmd l<cr>

nmap <C-W> <Plug>DWMNew
nmap <C-A> <Plug>DWMRotateCounterclockwise
nmap <C-S> <Plug>DWMClose
nmap <C-D> <Plug>DWMRotateClockwise

inoremap <leader><leader> <ESC>

au VimEnter * RainbowParenthesesToggleAll
au FileType c,cpp :Rooter
au FileType c,cpp let g:syntastic_c_include_dirs=split(system("find . -print0 -iname \*.h | xargs -0 -r -n 1 dirname | grep -v \.git | sort -u"), '\n')
au FileType c,cpp let g:clang_user_options="-I" . system("find . -print0 -iname \*.h | xargs -0 -r -n 1 dirname | grep -v \.git | sort -u | sed ':a;N;$!ba;s/\\n/ -I/g'")

let g:tagbar_autofocus=1
let g:tagbar_compact=1
let g:SuperTabDefaultCompletionType="context"
let g:syntastic_enable_signs=1
let g:syntastic_check_on_open=1
let g:syntastic_auto_loc_list=1
let g:syntastic_c_auto_refresh_includes=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:clang_use_library=1
let g:clang_complete_copen=1
let g:clang_hl_errors=1
let g:clang_complete_auto=0
let g:clang_complete_macros=1
let g:clang_complete_patterns=1
let g:clang_periodic_quickfix=1
let g:clang_snippets=1
let g:clang_snippets_engine='ultisnips'
let g:Powerline_symbols='unicode'
let g:easytags_file="~/.vim/tags"

noremap <silent> <leader>e :GundoToggle<CR>
noremap <silent> <leader>r :TagbarToggle<CR>

if has("gui_running")
  set guifont=Fixed\ 11
  set go-=T
  set t_md=
endif

