"-------------------------------------------------------------------------------
" Useful variables
"-------------------------------------------------------------------------------
if has("win32")
    let vimfiles = "vimfiles"
else
    let vimfiles = ".vim"
endif

"-------------------------------------------------------------------------------
" System settings
"-------------------------------------------------------------------------------
set backspace=2
filetype off
filetype plugin on
filetype plugin indent on

autocmd BufRead,BufNewFile *.glsl,*.hlsl,*.fs,*.ps,*.vs,*.sp,*.vert,*.frag set filetype=.c
autocmd BufRead,BufNewFile *.i set filetype=.cpp
set wildignore+=*.swp,*.bak,*doxygen*,*/Debug/*,*/Release/*,*/runtime/*,*.ncb,*.suo,*.user,*.class,*.glo,*.png,*.bmp,*.jpg,*.pyc

" Don't use swap files (slow over network)
set noswapfile

" Make new files have unix line endings
set fileformats=unix,dos

" Change buffers without saving!
set hidden

" Increase viminfo storage!
set viminfo='1000,f1,:1000,/50,@50,!

"-------------------------------------------------------------------------------
" Indent settings
"-------------------------------------------------------------------------------
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4

"-------------------------------------------------------------------------------
" Autocomplete options (disable preview scratch window)
"-------------------------------------------------------------------------------
set completeopt=menu,menuone,longest
set pumheight=15

"-------------------------------------------------------------------------------
" Command line options
"-------------------------------------------------------------------------------
set wildmenu
set history=1000

" Configure Vundle (plugin manager)
set rtp+=~/vimfiles/bundle/vundle/
call vundle#rc('$HOME/vimfiles/bundle/')

" Make Vundle manage itself
Bundle 'gmarik/vundle'

" List plugins to have installed.
Bundle 'Lokaltog/vim-easymotion'
Bundle 'bkad/CamelCaseMotion'
Bundle 'kien/ctrlp.vim'
Bundle 'msanders/snipmate.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-fugitive'
Bundle 'vim-scripts/bufkill.vim'
Bundle 'vim-scripts/sessionman.vim'
Bundle 'altercation/vim-colors-solarized'

" MatchParen slows down cursor movement on network drives.
"autocmd VimEnter * NoMatchParen

"-------------------------------------------------------------------------------
" Windows commands
"-------------------------------------------------------------------------------
autocmd GUIEnter * simalt ~x " Maximised on launch

"-------------------------------------------------------------------------------
" Turn off GUI menubar and toolbar
"-------------------------------------------------------------------------------
set guioptions-=m
set guioptions-=T

"-------------------------------------------------------------------------------
" Search settings
"-------------------------------------------------------------------------------
set hlsearch
set ignorecase
set incsearch
set smartcase

"-------------------------------------------------------------------------------
" Display settings
"-------------------------------------------------------------------------------
set background=dark
colorscheme mustang
let g:load_doxygen_syntax = 1
syntax on
set guifont=DejaVu_Sans_Mono:h8,Consolas:h9
set number
set nowrap
highlight OverLength ctermbg=red ctermfg=white guibg=#A92929
match OverLength /\%81v.\+/
set ruler

if version >= 703
    set colorcolumn=81
endif


"-------------------------------------------------------------------------------
" Custom mappings
"-------------------------------------------------------------------------------
:let mapleader = ","

" Map the return key to insert blank lines
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" Open vimrc
execute 'nmap <Leader>v :e $HOME/' . vimfiles . '/vimrc<CR>'

" Change-paste operator (see ChangePaste() function below)
nmap <silent> cp :set opfunc=ChangePaste<CR>g@

" Map escape key to clear search highlighting
:nnoremap <Esc> :let @/ = ""<CR><Esc>

" Remove trailing whitespace
:autocmd FileType cpp,c,h,xml,txt,sp,frag,vert,java autocmd BufWritePre <buffer> :%s/\s\+$//e

" Search for selected word or word under cursor
:nnoremap <Leader>s yiw:%s/0//gc<Left><Left><Left>
:vnoremap <Leader>s y:%s/0//gc<Left><Left><Left>
" Search for word until _ (e.g. for preprocessor constants)
:nnoremap <Leader>S yt_:%s/0//gc<Left><Left><Left>

" Continous visual indenting
vnoremap < <gv
vnoremap > >gv

" Map key combination to Esc
inoremap kj <Esc>
inoremap <Esc> <NOP>

"-------------------------------------------------------------------------------
" Plugin options
"-------------------------------------------------------------------------------
" Quick open for NERDTree
nmap <Leader>t :NERDTree<CR>

"-------------------------------------------------------------------------------
" Custom functions
"-------------------------------------------------------------------------------

" This allows for change paste motion cp{motion}
function! ChangePaste(type, ...)
    silent exe "normal! `[v`]\"_c"
    silent exe "normal! p"
endfunction
