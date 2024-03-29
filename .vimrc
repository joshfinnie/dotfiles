""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PERSONAL .vimrc FILE
" Maintained by Josh Finnie
" Last updated: 28 Jun 2020
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Preamble
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{
if 0 | endif
if &compatible
    set nocompatible
endif
syntax enable
set termencoding=utf-8
set encoding=UTF-8

set background=dark
colorscheme gruvbox

let mapleader=","
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{
filetype off
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'dense-analysis/ale'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'

call plug#end()
filetype plugin indent on
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{
" NerdTree
map <C-n> :NERDTreeToggle<CR>
map <C-s> :NERDTreeFind<CR>
let NERDTreeIgnore = ['\.pyc$', '\.DS_Store$']
let NERDTreeWinSize = 50
let NERDTreeShowHidden=1

" FZF
nmap <C-p> :FZF<CR>  " Maps to Ctrl+P to help with the muscle memory...

" Airline
let g:lightline = {
  \ 'active': {
  \   'left': [ [ 'mode', 'paste'  ],
  \             [ 'fugitive', 'readonly', 'filename', 'modified'  ] ],
  \   'right': [ [ 'lineinfo'  ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype'  ], [ 'ale' ]  ],
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
  \   'ale': 'LinterStatus',
  \ },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '', 'right': '' }
  \ }

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

function! LightlineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightlineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  try
    if expand('%:t') !~? 'Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
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
  return fname == 'ControlP' ? 'CtrlP' :
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


let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

" Gitgutter
let g:bufferline_echo = 0
set signcolumn=yes

" Ale
let g:ale_linters = {
\    'javascript': ['eslint'],
\    'typescript': ['eslint'],
\    'python': ['flake8'],
\    'markdown': ['markdownlint']
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\   'python': ['black'],
\}

let g:airline#extensions#ale#enabled = 1
let g:ale_python_flake8_options="--ignore=E501,W503"
let g:ale_python_black_options = '-l 120'
let g:ale_fix_on_save = 0
let g:ale_use_global_executables = 1

highlight clear ALEErrorSign
highlight clear ALEWarningSign

let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'

nnoremap <Leader>f :ALEFix<CR>

" Goyo
nnoremap <Leader>gy :Goyo 120<CR>
nnoremap <Leader>gyx :Goyo<CR>
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
let g:limelight_conceal_ctermfg = 240

" Gruvbox
let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'

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
set textwidth=0
set title
set ttimeout
set ttimeoutlen=10
set ttymouse=sgr
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
autocmd Filetype python setlocal ts=4 sts=4 sw=4 colorcolumn=120
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

highlight ColorColumn ctermbg=grey
nnoremap <leader>cc :setlocal colorcolumn=120<CR>

" Key bindings for adjusting the tab/shift width.
nnoremap <leader>w2 :setlocal tabstop=2<CR>:setlocal shiftwidth=2<CR>
nnoremap <leader>w4 :setlocal tabstop=4<CR>:setlocal shiftwidth=4<CR>
nnoremap <leader>w8 :setlocal tabstop=8<CR>:setlocal shiftwidth=8<CR>
"}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{
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
" Movement
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{

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
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{
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

" CoC Mappings
nmap <silent> gd :vsp<cr><Plug>(coc-definition)

" Terminal Normal Mode
tnoremap <c-j> <c-\><c-n>

let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver']
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
" Filetype Specific Stuff
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Vim
augroup ft_vim
    au!
    au FileType vim setlocal foldmethod=marker
    au FileType help setlocal textwidth=78
    au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END

" Trackmaven
au BufRead,BufNewFile *.template setfiletype html

" Vue
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css
autocmd Filetype vue setlocal ts=2 sts=2 sw=2

" Typescript JSX
autocmd BufNewFile,BufRead *.tsx set filetype=typescript
autocmd Filetype typescript setlocal ts=2 sts=2 sw=2

" JSX
autocmd BufNewFile,BufRead *.jsx set filetype=javascript
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2

" Mdx
autocmd BufNewFile,BufRead *.mdx set filetype=markdown
" }}}
