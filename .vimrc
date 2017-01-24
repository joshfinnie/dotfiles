"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PERSONAL .vimrc FILE
" Maintained by Josh Finnie
" Last updated: 08 Dec 2016
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Preamble
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{
if 0 | endif
if &compatible
    " Be iMproved
    set nocompatible
endif
syntax enable                     " enables syntax processing
set t_Co=256
set termencoding=utf-8
if has('gui_running')
    colorscheme Tomorrow-Night-Eighties
else
    colorscheme Tomorrow-Night-Eighties
endif
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
Plugin 'airblade/vim-gitgutter'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'itchyny/lightline.vim'  " status bar
Plugin 'bling/vim-bufferline'  " status bar buffer tabs
Plugin 'jiangmiao/auto-pairs'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'mattn/emmet-vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
"}}}

" Syntax Highlighting {{{
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'digitaltoad/vim-jade'
Plugin 'fatih/vim-go'
Plugin 'flazz/vim-colorschemes'
Plugin 'isRuslan/vim-es6'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'kchmck/vim-coffee-script'
Plugin 'leafgarland/typescript-vim'
Plugin 'lilydjwg/colorizer'
Plugin 'tpope/vim-markdown'
Plugin 'vim-syntastic/syntastic'
"}}}

call vundle#end()

" load file-type specific indent files
filetype plugin indent on
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
set guifont=Meslo\ LG\ M\ Regular\ for\ Powerline
let g:lightline = {
  \ 'active': {
  \   'left': [ [ 'mode', 'paste'  ],
  \             [ 'fugitive', 'readonly', 'filename', 'modified'  ] ],
  \   'right': [ [ 'lineinfo'  ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype'  ]  ],
  \ },
  \ 'component': {
  \   'readonly': '%{&readonly?"":""}',
  \ },
  \ 'component_function': {
  \   'fugitive': 'LightlineFugitive',
  \   'filename': 'LightlineFilename',
  \   'fileformat': 'LightlineFileformat',
  \   'filetype': 'LightlineFiletype',
  \   'fileencoding': 'LightlineFileencoding',
  \   'mode': 'LightlineMode',
  \ },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '', 'right': '' }
  \ }

function! LightlineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightlineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let branch = fugitive#head()
      return branch !=# '' ? mark.branch : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0
"}}}

" Gitgutter {{{
let g:bufferline_echo = 0
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
let g:syntastic_python_checkers = ['flake8']

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1

let g:syntastic_error_symbol = '💩'
" let g:syntastic_error_symbol = '❌'
let g:syntastic_error_symbol = '💩'
" let g:syntastic_warning_symbol = '⚠️'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
"}}}

" Typescript-Vim {{{
let g:typescript_indent_disable = 1
"}}}

"}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic Options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{
set autoread
set autowriteall
set backspace=indent,eol,start
set encoding=utf-8
set hidden
set history=1000
set laststatus=2
set lazyredraw
set linebreak
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set matchtime=3
set modeline
set modelines=5
set mouse=a
set noerrorbells
set nolist
set notimeout
set number
set relativenumber
set ruler
set shiftround
set showcmd
set showmatch
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
set wildmenu
set wrap
set wrapmargin=0

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabs, Spaces & ColorColumn
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{
set autoindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

autocmd Filetype css setlocal ts=2 sts=2 sw=2
autocmd Filetype go setlocal ts=8 sts=8 sw=8
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype htmldjango setlocal ts=2 sts=2 sw=2
autocmd Filetype jade setlocal ts=2 sts=2 sw=2
autocmd Filetype python setlocal ts=4 sts=4 sw=4 colorcolumn=80

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
set nofoldenable

set foldlevelstart=10
set foldmethod=indent
set foldnestmax=10

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

" Trackmaven {{{
au BufRead,BufNewFile *.template setfiletype html
"}}}

" ES6 {{{
au BufRead,BufNewFile *.es6 setfiletype javascript
"}}}

" Generic {{{
" Autoclose NERDTree if it's the only window left open. ** NO LONGER WORKS :-( **
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" }}}

" }}}
