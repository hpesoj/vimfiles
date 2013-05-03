" Useful variables
if has("win32")
    let vimfiles = "vimfiles"
else
    let vimfiles = ".vim"
endif

" Change the leader character
let mapleader = ","

" Configure Vundle plugin manager
execute 'set rtp+=~/' . vimfiles . '/bundle/vundle'
call vundle#rc('~/' . vimfiles . '/bundle')

" Make Vundle manage itself
Bundle 'gmarik/vundle'

" Specify plugins to install
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Lokaltog/vim-powerline'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'bkad/CamelCaseMotion'
Bundle 'derekmcloughlin/gvimfullscreen_win32'
Bundle 'garbas/vim-snipmate'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'tomtom/tlib_vim'
Bundle 'tpope/vim-fugitive'
Bundle 'vim-scripts/bufkill.vim'
Bundle 'vim-scripts/sessionman.vim'

" Colour schemes
Bundle 'altercation/vim-colors-solarized'

" Plugin-specific options
autocmd SessionLoadPost * silent PowerlineReloadColorscheme  " Keep colours
let g:Powerline_symbols = 'compatible'  " Disable fancy symbols for Powerline
map <Leader>t :NERDTree<CR>  " Quick open for NERDTree
map <F11> <C-c>:call libcallnr('gvimfullscreen.dll', 'ToggleFullScreen', 0)<CR>

" Editor appearance
set encoding=utf-8  " Use unicode
set guifont=DejaVu_Sans_Mono:h8,Consolas:h9  " Preferred fonts
set guioptions-=r  " Don't show right scrollbar
set guioptions-=R  " Don't show right scrollbar when split window
set guioptions-=l  " Don't show left scrollbar
set guioptions-=L  " Don't show left scrollbar when split window
set guioptions-=b  " Don't show bottom scrollbar
set guioptions-=T  " Don't show toolbar
set guioptions-=e  " Don't use native tabs
set guioptions-=m  " Don't show menu
set laststatus=2  " Always show the status bar
set nowrap  " Do not wrap lines
set number  " Show line numbers

if version >= 703
    set colorcolumn=81
endif

syntax enable  " Use default syntax highlighting
set background=dark  " Use a light colour scheme
colorscheme solarized  " Set to a cool colour scheme
autocmd GUIEnter * simalt ~x " Maximise window on launch
let g:load_doxygen_syntax = 1  " Enable doxygen syntax highlighting

" Text input
set backspace=2  " Make backspace delete over lines
set expandtab  " Insert spaces instead of tabs
set shiftwidth=4  " Set the indentation width
set tabstop=4  " Number of spaces per tab

" Search
set hlsearch  " Highlight all search matches
set ignorecase  " Case-insensitive search
set incsearch  " React to search while typing
set smartcase  " Case sensitive search only if term includes upper-case

" Remove trailing whitespace on save
autocmd FileType
            \ c,h,cpp,hpp,
            \java,
            \py,
            \ap,mat,sp,frag,vert
            \xml,txt,bat,cfg,
            \ autocmd BufWritePre <buffer> :%s/\s\+$//e

" File type identification
autocmd BufRead,BufNewFile
            \ *.glsl,*.hlsl,*.fs,*.vs,*.vert,*.frag,
            \*.ap,*.mat,*.sp
            \ set filetype=.c

autocmd BufRead,BufNewFile
            \ *.i
            \ set filetype=.cpp

" Other editor behaviour
set completeopt=menu,menuone,longest  " Disable preview scratch window
set fileformats=unix,dos  " Make new files have unix line endings
set hidden  " Change buffers without saving!
set history=1000  " Increase command history
set noswapfile  " Don't use swap files (slow over network)
set pumheight=15  " Max items in autocomplete menu
set viminfo='1000,f1,:1000,/50,@50,!  " Increase viminfo storage!
set wildmenu  " Display command line completion list

filetype plugin indent on  " Turn on all file type detection

" Ignored filesystem names
set wildignore+=
            \*.swp,*.bak,
            \*doxygen*,
            \*/Debug/*,*/Release/*,*/runtime/*,
            \*.ncb,*.suo,*.user,*.class,*.pyc,*.obj,
            \*.glo,*.png,*.bmp,*.jpg  " Asset files

" Custom mappings

" Disable escape key
inoremap <Esc> <NOP>
nnoremap <Esc> <NOP>
cnoremap <Esc> <NOP>

" Map escape key to clear search highlighting
nnoremap <C-c> :let @/ = ""<CR><C-c>

" Map the return key to insert blank lines
nmap <S-Enter> O<C-c>
nmap <CR> o<C-c>

" Search for selected word or word under cursor
nnoremap <Leader>s yiw:%s/0//gc<Left><Left><Left>
vnoremap <Leader>s y:%s/0//gc<Left><Left><Left>
" Search for word until _ (e.g. for preprocessor constants)
nnoremap <Leader>S yt_:%s/0//gc<Left><Left><Left>

" Change-paste operator
nmap <silent> cp :set opfunc=ChangePaste<CR>g@
function! ChangePaste(type, ...)
    silent exe "normal! `[v`]\"_c"
    silent exe "normal! p"
endfunction

" Open vimrc
execute 'nmap <Leader>v :e $HOME/' . vimfiles . '/vimrc<CR>'
