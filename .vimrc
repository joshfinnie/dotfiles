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
set nocompatible                  " sets vi capatiblity to no
syntax enable                     " enables syntax processing
set background=dark
set term=screen-256color
set t_Co=256
colorscheme solarized
set shell=/bin/sh

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" Bundles {{{
Bundle 'Raimondi/delimitMate'
Bundle 'airblade/vim-rooter'
Bundle 'amirh/HTML-AutoCloseTag'
Bundle 'bling/vim-airline'
Bundle 'gregsexton/MatchTag'
Bundle 'kien/ctrlp.vim'
Bundle 'klen/python-mode'
Bundle 'majutsushi/tagbar'
Bundle 'mattn/emmet-vim'
Bundle 'scrooloose/nerdtree'
Bundle 'tomtom/vimtlib'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/Align'
Bundle 'tpope/vim-commentary'
Bundle 'airblade/vim-gitgutter'
Bundle 'jmcantrell/vim-virtualenv'
"}}}

" Syntax Highlighting {{{
Bundle 'dart-lang/dart-vim-plugin'
Bundle 'digitaltoad/vim-jade'
Bundle 'groenewege/vim-less'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'jiangmiao/simple-javascript-indenter'
Bundle 'kchmck/vim-coffee-script'
Bundle 'othree/html5-syntax.vim'
Bundle 'tpope/vim-markdown'
Bundle 'scrooloose/syntastic'
Bundle 'lilydjwg/colorizer'
"}}}

" SnipMate {{{
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'
"}}}

filetype plugin indent on         " load file-type specific indent files
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic Options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{
set autoindent
set autoread
set autowriteall
set backspace=indent,eol,start
set colorcolumn=80
set encoding=utf-8
set hidden
set history=1000
set laststatus=2
set lazyredraw                    " redray only when needed
set linebreak
set nolist
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set matchtime=3
set modeline
set modelines=5
set mouse=a
set noerrorbells
set notimeout
set number                        " show line numbers
set relativenumber
set ruler
set shiftround
set shiftwidth=4
set showcmd                       " show command in bottom bar
set showmatch                     " highlights matching [{()}]
set showmode
set splitbelow
set splitright
set synmaxcol=512
set termencoding=utf-8
set textwidth=0
set title
set ttimeout
set ttimeoutlen=10
set undofile
set undolevels=1000
set undoreload=10000
set visualbell
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,node_modules,*.pyc
set wildmenu                      " visual autocomplete for command menu
set wrap
set wrapmargin=0

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabs & Spaces
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{
set tabstop=4                     " number of visual spaces per TAB is 4
set softtabstop=4                 " number of spaces in tabs while editing is 4
set expandtab                     " tabs are saved as spaces

autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype coffeescript setlocal ts=2 sts=2 sw=2
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype htmldjango setlocal ts=2 sts=2 sw=2
autocmd Filetype jade setlocal ts=2 sts=2 sw=2
autocmd Filetype css setlocal ts=2 sts=2 sw=2

" Key bindings for adjusting the tab/shift width.
nnoremap <leader>w2 :setlocal tabstop=2<CR>:setlocal shiftwidth=2<CR>
nnoremap <leader>w4 :setlocal tabstop=4<CR>:setlocal shiftwidth=4<CR>
nnoremap <leader>w8 :setlocal tabstop=8<CR>:setlocal shiftwidth=8<CR>
"}}}

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

:au FocusLost * silent! wa        " Saves on loss of focus

" }}}

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
let mapleader=","                 " making the leader a comma
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

noremap <left> :bp<cr>
noremap <right> :bn<cr>

" move vertically by visual line
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

" Toggle Spell Check
nnoremap <F5> :setlocal spell! spelllang=en_us<CR>

" Toggle Paste
nnoremap <F6> :set paste!<cr>

" Sudo to write
cnoremap w!! w !sudo tee % >/dev/null

" Sort lines
nnoremap <leader>s vip:!sort<cr>
vnoremap <leader>s :!sort<cr>

" edit vimrc/zshrc/tmux.conf and load vimrc bindings
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>ez :e ~/.zshrc<cr>
nnoremap <leader>ea :e ~/.aliases<cr>
nnoremap <leader>et :e ~/.tmux.conf<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Reload all the things!
nnoremap <leader>r :bufdo e<cr>

" Create links in Markdown
nnoremap <leader>l viw<esc>a]<esc>hbi[<esc>lela(http://)<esc>ha

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Searching
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{
set gdefault
set hlsearch                      " highlight matches
set ignorecase
set incsearch                     " search as characters are entered
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
set nofoldenable                  " diables folding on file open

set foldlevelstart=10             " closes all folds on activation
set foldmethod=indent            " folds on code indentation
set foldnestmax=10               " has max of 10 nested folds

nnoremap <Space> za              " remap fold toggling to space
vnoremap <Space> za              " remap fold toggling to space

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
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . ' '
endfunction " }}}
set foldtext=MyFoldText()
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype Specific Stuff
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
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
    au Filetype javascript inoremap <buffer> {<cr> {}<left><cr><space><space>.<cr><esc>kA<bs>
augroup END
" }}}

" Trackmaven {{{
au BufRead,BufNewFile *.template setfiletype html
"}}}

" Generic {{{
" Autoclose NERDTree if it's the only window left open.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" }}}

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Specific Stuff
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{
" NerdTree {{{
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$']
let NERDTreeWinSize = 50
"}}}

" CtrlP {{{
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|log\|tmp|node_modules$',
  \ 'file': '\.exe$\|\.so$\|\.dat|\.pyc$'
  \ }
""}}}

" Airline {{{
let g:airline_enabled=1
let g:airline_powerline_fonts=1
let g:airline_theme='solarized'
set guifont=Inconsolata\ for\ Powerline
"}}}

" PyMode {{{
let g:pymode_folding = 0
autocmd CursorMovedI *  if pumvisible() == 0|silent! pclose|endif
autocmd InsertLeave * if pumvisible() == 0|silent! pclose|endif
"}}}

" TagBar {{{
nnoremap <leader>tb :TagbarToggle<cr>
"}}}

"}}}
