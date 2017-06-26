" Useful variables
if has("win32")
    let vimfiles = "vimfiles"
else
    let vimfiles = ".vim"
endif

" Change the leader character
let mapleader = ","

" Configure Vundle plugin manager
execute 'set rtp+=~/' . vimfiles . '/bundle/Vundle.vim'
call vundle#rc('~/' . vimfiles . '/bundle')

" Make Vundle manage itself
Bundle 'VundleVim/Vundle.vim'

" Specify plugins to install
Bundle 'KuoE0/vim-janitor'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Lokaltog/vim-powerline'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'bkad/CamelCaseMotion'
Bundle 'derekmcloughlin/gvimfullscreen_win32'
Bundle 'garbas/vim-snipmate'
Bundle 'kien/ctrlp.vim'
Bundle 'nfvs/vim-perforce'
Bundle 'ntpeters/vim-better-whitespace'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'sjl/gundo.vim'
Bundle 'tomtom/tlib_vim'
Bundle 'tpope/vim-fugitive'
Bundle 'Valloric/YouCompleteMe'
Bundle 'vim-scripts/bufkill.vim'
Bundle 'vim-scripts/sessionman.vim'

" Colour schemes
Bundle 'Addisonbean/Vim-Xcode-Theme'
Bundle 'altercation/vim-colors-solarized'

" Plugin-specific options
autocmd SessionLoadPost * silent PowerlineReloadColorscheme  " Keep colours
let g:Powerline_symbols = 'compatible'  " Disable fancy symbols for Powerline
let g:NERDTreeWinSize = 45  " Set default NERDTree window width
let g:gundo_right = 1  " Open Gundo window on the right hand side
let g:perforce_open_on_change = 1  " Prompt for checkout on change
let g:janitor_enable_highlight = 0  " Do not highlight trailing whitespace
let g:janitor_auto_clean_up_on_write = 1  " Strip whitespace on save
let g:janitor_auto_clean_up_trailing_space_only_added = 1  " Only changed lines

" Editor appearance'
if has("win32")
    set guifont=DejaVu_Sans_Mono:h8,Consolas:h9  " Preferred fonts
elseif has("mac")
    set guifont="SF Mono"\ 10  " Preferred fonts
else
    set guifont=DejaVuSansMono\ 10  " Preferred fonts
endif

set encoding=utf-8  " Use unicode
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
let g:load_doxygen_syntax = 1  " Enable doxygen syntax highlighting

" Text input
set backspace=2  " Make backspace delete over lines
set expandtab  " Insert spaces instead of tabs
set shiftwidth=2  " Set the indentation width
set tabstop=2  " Number of spaces per tab

" Search
set hlsearch  " Highlight all search matches
set ignorecase  " Case-insensitive search
set incsearch  " React to search while typing
set smartcase  " Case sensitive search only if term includes upper-case

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

nnoremap <Leader>yy :YcmCompleter GoTo<CR>
nnoremap <Leader>yu :YcmCompleter GoToImprecise<CR>
nnoremap <Leader>yh :YcmCompleter GoToDeclaration<CR>
nnoremap <Leader>yc :YcmCompleter GoToDefinition<CR>
nnoremap <Leader>yr :YcmCompleter GoToReferences<CR>
nnoremap <Leader>yx :YcmCompleter GoToImplementationElseDeclaration<CR>

" Map escape key to clear search highlighting
nnoremap <C-c> :let @/ = ""<CR><Esc>
inoremap <C-c> <Esc>
vnoremap <C-c> <Esc>

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

" Set fullscreen
map <F11> <C-c>:call libcallnr('gvimfullscreen.dll', 'ToggleFullScreen', 0)<CR>

" Open vimrc
execute 'nmap <Leader>v :e $HOME/' . vimfiles . '/vimrc<CR>'

" Quick open for NERDTree
map <Leader>t :NERDTreeToggle<CR>
map <Leader>f :NERDTreeFind<CR>

" Quick open for Gundo
map <Leader>g :GundoToggle<CR>
