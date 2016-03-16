""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" PERSONAL .vimrc FILE
" Maintained by Josh Finnie
" Last updated: 16 Jul 2015
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Preamble
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{
set nocompatible                  " sets vi capatiblity to no
syntax enable                     " enables syntax processing
set t_Co=256
set termencoding=utf-8
if has('gui_running')
    colorscheme Tomorrow-Night-Eighties
else
    colorscheme Tomorrow-Night-Eighties
endif
highlight Normal ctermfg=grey ctermbg=black
let mapleader=","                 " making the leader a comma
let maplocalleader="\\"

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

" Plugins {{{
Plugin 'Raimondi/delimitMate'
Plugin 'airblade/vim-rooter'
Plugin 'amirh/HTML-AutoCloseTag'
Plugin 'itchyny/lightline.vim'
Plugin 'gregsexton/MatchTag'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'mattn/emmet-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tomtom/vimtlib'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/Align'
Plugin 'tpope/vim-commentary'
Plugin 'airblade/vim-gitgutter'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'mileszs/ack.vim'
"}}}

" Syntax Highlighting {{{
Plugin 'dart-lang/dart-vim-plugin'
Plugin 'digitaltoad/vim-jade'
Plugin 'fatih/vim-go'
Plugin 'groenewege/vim-less'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'jiangmiao/simple-javascript-indenter'
Plugin 'kchmck/vim-coffee-script'
Plugin 'othree/html5-syntax.vim'
Plugin 'tpope/vim-markdown'
Plugin 'scrooloose/syntastic'
Plugin 'lilydjwg/colorizer'
"}}}

" SnipMate {{{
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
"}}}

" Fun Things {{{
Plugin 'ryanss/vim-hackernews'
"}}}

call vundle#end()
filetype plugin indent on         " load file-type specific indent files
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic Options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{

set autoindent
set autoread
set autowriteall
set backspace=indent,eol,start
set encoding=utf-8
set hidden
set history=1000
set laststatus=2
set lazyredraw                    " redraw only when needed
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
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/**,*.pyc,*/.bower-cache/**,*/.sass-cache/**
set wildmenu                      " visual autocomplete for command menu
set wrap
set wrapmargin=0

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabs, Spaces & ColorColumn
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{
set tabstop=4                     " number of visual spaces per TAB is 4
set softtabstop=4                 " number of spaces in tabs while editing is 4
set expandtab                     " tabs are saved as spaces

autocmd Filetype python setlocal ts=4 sts=4 sw=4 colorcolumn=80
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype htmldjango setlocal ts=2 sts=2 sw=2
autocmd Filetype jade setlocal ts=2 sts=2 sw=2
autocmd Filetype css setlocal ts=2 sts=2 sw=2
autocmd Filetype go setlocal ts=8 sts=8 sw=8

highlight ColorColumn ctermbg=grey
nnoremap <leader>cc :setlocal colorcolumn=80<CR>

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
nnoremap <leader>ef :e ~/.config/fish/config.fish<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Reload all the things!
nnoremap <leader>r :bufdo e<cr>

" Create links in Markdown
nnoremap <leader>l viw<esc>a]<esc>hbi[<esc>lela()<esc>ha

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

" ES6 {{{
au BufRead,BufNewFile *.es6 setfiletype javascript
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
let NERDTreeIgnore = ['\.pyc$', '\.DS_Store$']
let NERDTreeWinSize = 50
let NERDTreeShowHidden=1
"}}}

" CtrlP {{{
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|^log\|tmp|node_modules$',
  \ 'file': '\.exe$\|\.so$\|\.dat|\.pyc$'
  \ }
""}}}

" Airline {{{
set guifont=Inconsolata\ for\ Powerline
let g:lightline = {
  \ 'component': {
  \   'readonly': '%{&readonly?"":""}',
  \ },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '', 'right': '' }
  \ }
"}}}

" Gitgutter {{{
let g:gitgutter_sign_column_always=1
"}}}

" TagBar {{{
nnoremap <leader>tb :TagbarToggle<cr>
"}}}

" Syntastic {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_javascript_checkers = ['eslint']

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
"}}}

"}}}
