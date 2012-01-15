set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'godlygeek/csapprox'
Bundle 'Raimondi/delimitMate'
Bundle 'scrooloose/nerdtree'
Bundle 'ervandew/supertab'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-fugitive'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'gregsexton/gitv'
Bundle 'Lokaltog/vim-powerline'
Bundle 'majutsushi/tagbar'
Bundle 'sjl/gundo.vim'
Bundle 'gregsexton/MatchTag'
Bundle 'ciaranm/securemodelines'

syn on
filetype plugin indent on
colorscheme molokai

set sw=2
set ts=2
set expandtab
set hidden
set ignorecase
set smartcase
set history=1000
set undofile
set undolevels=1000
set undoreload=10000
set backup
set backupdir=~/.vim/backup/
set directory=~/.vim/tmp/
set foldenable
set wildmenu
set wildmode=longest,full
set nomodeline
set mouse=a
set t_Co=256
set laststatus=2
set encoding=utf-8

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete

au VimEnter * RainbowParenthesesToggle

let g:tagbar_autofocus=1
let g:tagbar_compact=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeDirArrows=1
let g:syntastic_enable_signs=1
let g:syntastic_enable_balloons=1
let g:Powerline_symbols='unicode'

noremap <silent> <F10> :GundoToggle<CR>
noremap <silent> <F11> :NERDTreeToggle<CR>
noremap <silent> <F12> :TagbarToggle<CR>

if has("gui_running")
  set guifont=Fixed\ 11
  set columns=120
  set lines=72
  set go-=T
  set t_md=
endif

