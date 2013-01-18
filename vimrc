set nocompatible

runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

syn on
filetype plugin indent on

set t_Co=256

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
inoremap <silent> <C-w> <C-o>:wincmd k<cr>
inoremap <silent> <C-a> <C-o>:wincmd h<cr>
inoremap <silent> <C-s> <C-o>:wincmd j<cr>
inoremap <silent> <C-d> <C-o>:wincmd l<cr>

noremap <silent> <C-/> :nohlsearch<cr>
inoremap <silent> <C-/> <C-o>:nohlsearch<cr>

vnoremap <silent> <C-x> "+x
vnoremap <silent> <C-c> "+y
noremap <silent> <C-v> "+gP
inoremap <silent> <C-v> <C-o>"+gP

noremap <silent> <C-z> u
inoremap <silent> <C-z> <C-o>u

au VimEnter * RainbowParenthesesToggleAll
au FileType c,cpp,h :Rooter

"au FileType c,cpp let g:syntastic_c_include_dirs=split(system("find . -print0 -iname \*.h | xargs -0 -r -n 1 dirname | grep -v \.git | sort -u"), '\n')
"au FileType c,cpp let g:clang_user_options="-I" . system("find . -print0 -iname \*.h | xargs -0 -r -n 1 dirname | grep -v \.git | sort -u | sed ':a;N;$!ba;s/\\n/ -I/g'")

let g:tagbar_autofocus=1
let g:tagbar_compact=1
let g:tagbar_autoclose=1
let g:SuperTabDefaultCompletionType="<c-x><c-u>"
"let g:SuperTabContextTextOmniPrecedence=['ClangComplete']
"let g:SuperTabContextDiscoveryDiscovery=["ClangComplete:<c-x><c-u>"]
"let g:SuperTabCompletionContexts=['s:ContextText', 's:ContextDiscover']
let g:syntastic_enable_signs=1
let g:syntastic_check_on_open=1
let g:syntastic_auto_loc_list=1
au FileType c,cpp,h let g:syntastic_auto_loc_list=2
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
let g:easytags_by_filetype="~/.vim/tags/"

noremap <silent> <C-q> :CtrlPBuffer<cr>
noremap <silent> <C-e> :CtrlP<cr>
noremap <silent> <C-r> :GundoToggle<cr>
noremap <silent> <C-t> :TagbarToggle<cr>

inoremap <silent> <C-q> <C-o>:CtrlPBuffer<cr>
inoremap <silent> <C-e> <C-o>:CtrlP<cr>
inoremap <silent> <C-t> <C-o>:GundoToggle<cr>
inoremap <silent> <C-t> <C-o>:TagbarToggle<cr>

if has("gui_running")
  set guifont=Fixed\ 11
  set go-=T
  set t_md=
endif

