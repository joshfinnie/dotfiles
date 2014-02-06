""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" PERSONAL .vimrc FILE
" Maintained by Josh Finnie
" Last updated: 05 Feb 2014
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible
filetype off
syntax on

" Vundle 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'bling/vim-airline'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdtree'
Bundle 'kchmck/vim-coffee-script'
Bundle 'jelera/vim-javascript-syntax'

map <C-n> :NERDTreeToggle<CR>

let g:airline_enabled=1
set guifont=Inconsolata\ for\ Powerline
let g:airline_powerline_fonts=1
let g:airline_theme='solarized'

" Editing behavior
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nowrap
set number
set autoread
set expandtab
set tabstop=4
set backspace=indent,eol,start
set autoindent
set copyindent
set shiftwidth=4
set shiftround
set showmatch
set foldenable
set foldcolumn=2
set foldmethod=marker
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
set ignorecase
set smartcase
set smarttab
set hlsearch
set incsearch
set nolist
set listchars=tab:»·,trail:·,extends:#,nbsp:·
set mouse=a

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editor layout
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set termencoding=utf-8
set encoding=utf-8
set lazyredraw
set laststatus=2
set cmdheight=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim behaviour
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hidden
set switchbuf=useopen
set history=1000
set undolevels=1000
set nobackup
set noswapfile
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set wildmenu
set wildmode=list:full
set wildignore=*.swp,*.bak,*.pyc,*.class
set title
set visualbell
set noerrorbells
set showcmd
set modeline
set modelines=5

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General mapping
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap ; :
vmap Q gq
nmap Q gqap
nnoremap ' `
nnoremap ` '
let mapleader=","
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
imap <C-f> <C-x><C-f>
imap <C-l> <C-x><C-l>
nmap <leader>y "+y
nmap <leader>Y "+yy
nmap <leader>p "+p
nmap <leader>P "+P
inoremap jj <Esc>
