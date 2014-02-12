""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" PERSONAL .vimrc FILE
" Maintained by Josh Finnie
" Last updated: 07 Feb 2014
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Preamble
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{
set nocompatible
filetype off
syntax on

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'bling/vim-airline'
Bundle 'digitaltoad/vim-jade'
Bundle 'gmarik/vundle'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'kchmck/vim-coffee-script'
Bundle 'scrooloose/nerdtree'
Bundle 'tomtom/vimtlib'
Bundle 'tpope/vim-fugitive'

map <C-n> :NERDTreeToggle<CR>

let g:airline_enabled=1
let g:airline_powerline_fonts=1
let g:airline_theme='solarized'
set guifont=Inconsolata\ for\ Powerline

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic Options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{
set autoindent
set autoread
set autowrite
set backspace=indent,eol,start
set encoding=utf-8
set hidden
set history=1000
set laststatus=2
set lazyredraw
set linebreak
set list
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set matchtime=3
set modeline
set modelines=5
set mouse=a
set noerrorbells
set notimeout
set number
set relativenumber
set ruler
set shiftround
set showbreak=↪
set showcmd
set showmode
set splitbelow
set splitright
set termencoding=utf-8
set title
set ttimeout
set ttimeoutlen=10
set undofile
set undolevels=1000
set undoreload=10000
set visualbell

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Nice Commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{
" Trailing whitespace {{{
augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:⌴
    au InsertLeave * :set listchars+=trail:⌴
augroup END

" }}}

" Line Return {{{
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" }}}

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabs, Spaces, and Wrapping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set wrap
set textwidth=80
set formatoptions=qrn1j
set colorcolumn=+1

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{
set backup
set noswapfile

set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings and Movement
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{
let mapleader=","
let maplocalleader="\\"
nnoremap ; :
vmap Q gq
nmap Q gqap
nnoremap ' `
nnoremap ` '

" Disallows arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Better pane management
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

" More sane line movement
noremap H ^
noremap L $
vnoremap L g_
nnoremap D d$

" Better way to escape out of Insert Mode
inoremap jj <Esc>

" Clean trailing whitespace
nnoremap <leader>ww mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" Toggle Paste
nnoremap <F6> :set paste!<cr>

" Sudo to write
cnoremap w!! w !sudo tee % >/dev/null

" Sort lines
nnoremap <leader>s vip:!sort<cr>
vnoremap <leader>s :!sort<cr>
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Searching
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{
set gdefault
set hlsearch
set ignorecase
set incsearch
set showmatch
set smartcase

" Use sane regexes.
nnoremap / /\v
vnoremap / /\v

set scrolloff=3
set sidescroll=1
set sidescrolloff=10

noremap <silent> <leader><space> :noh<cr>:call clearmatches()<cr>
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""{{{
set foldlevelstart=0
set foldmethod=indent
set foldnestmax=10
set nofoldenable

nnoremap <Space> za
vnoremap <Space> za

" Make zO recursively open whatever fold we're in, even if it's partially open.
nnoremap z0 zcz0

function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype Specific Stuff
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{
" Vim {{{
augroup ft_vim
    au!
    au FileType vim setlocal foldmethod=marker
    au FileType help setlocal textwidth=78
    au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END
" }}}

" Javascript {{{
augroup ft_javascript
    au!
    au Filetype javascript inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
augroup END
" }}}

" }}}
