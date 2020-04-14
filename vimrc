if has("win32")
  let vim_path = "~/vimfiles"
else
  let vim_path = "~/.vim"
endif

call plug#begin(vim_path . '/plugged')

Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'altercation/vim-colors-solarized'
Plug 'bkad/CamelCaseMotion'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'qpkorr/vim-bufkill'
Plug 'rhysd/vim-clang-format'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

if has("win32")
  set guifont=DejaVu_Sans_Mono:h8,Consolas:h9
elseif has("mac")
  set guifont="SF Mono"\ 10
else
  set guifont=DejaVuSansMono\ 10
endif

" Hide GUI cruft
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=b
set guioptions-=T
set guioptions-=e
set guioptions-=m

" Editor appearance
colorscheme solarized
let g:load_doxygen_syntax = 1
set background=dark
set colorcolumn=101
set laststatus=2
set nowrap
set number
syntax enable

" Editor behaviour
filetype plugin indent on
set encoding=utf-8
set hidden
set history=1000
set noswapfile
set pumheight=15
set viminfo='1000,f1,:1000,/50,@50,!
set wildmenu

" Text input
set expandtab " Insert spaces instead of tabs
set shiftwidth=4 " Set the indentation width
set tabstop=4 " Number of spaces per tab
set softtabstop=4 " Number of spaces per tab
set backspace=2 " Normal backspace behaviour

" Search
set hlsearch " Highlight all search matches
set ignorecase " Case-insensitive search
set incsearch " React to search while typing
set smartcase " Case sensitive search only if term includes upper-case

" Treat extra file extensions as C files.
autocmd BufRead,BufNewFile
  \ *.glsl,*.hlsl,*.fs,*.vs,*.vert,*.frag,*.vert.block,*.frag.block,
  \*.ap,*.mat,*.sp
  \ set filetype=.c

" Treat extra file extensions as C++ files.
autocmd BufRead,BufNewFile
  \ *.i
  \ set filetype=.cpp

" Ignored filesystem names
set wildignore+=
  \*.swp,*.bak,
  \*doxygen*,
  \*/Debug/*,*/Release/*,*/Output/*,*/runtime/*,
  \*.ncb,*.suo,*.user,*.class,*.pyc,*.obj,
  \*.glo,*.png,*.bmp,*.jpg  " Asset files

" Custom key mappings
let mapleader = ","

" Open vimrc
execute 'nmap <Leader>v :e ' . vim_path . '/vimrc<CR>'

" Clear search highlighting with escape.
nnoremap <Esc> :let @/ = ""<CR><Esc>

" Word search
nnoremap <Leader>s yiw:%s/0//gc<Left><Left><Left>
vnoremap <Leader>s y:%s/0//gc<Left><Left><Left>
" Word search: whole word
nnoremap <Leader><Leader>s yiw:%s/\<0\>//gc<Left><Left><Left>
vnoremap <Leader><Leader>s y:%s/\<0\>//gc<Left><Left><Left>
" Word search: case sensitive
nnoremap <Leader>S yiw:%s/0//gc<Left><Left><Left>
vnoremap <Leader>S y:%s/0//gc<Left><Left><Left>
" Word search: whole word; case sensitive
nnoremap <Leader><Leader>S yiw:%s/\<0\>//gc<Left><Left><Left>
vnoremap <Leader><Leader>S y:%s/\<0\>//gc<Left><Left><Left>

" Change-paste operator
nmap <silent> cp :set opfunc=ChangePaste<CR>g@
function! ChangePaste(type, ...)
  silent exe "normal! `[v`]\"_c"
  silent exe "normal! p"
endfunction

" Airline
let g:airline_theme = 'solarized'
let g:airline#extensions#tabline#enabled = 1
nmap <C-q>h :bp<CR>
nmap <C-q><C-h> :bp<CR>
nmap <C-q>l :bn<CR>
nmap <C-q><C-l> :bn<CR>

" CamelCaseMotion
call camelcasemotion#CreateMotionMappings('<leader>')

" vim-clang-format
let g:clang_format#auto_format = 1
let g:clang_format#code_style = 'WebKit'

" Colorizer
let g:colorizer_auto_filetype = 'vim,css,html,cpp,hpp,c,h'

" FZF
let g:fzf_preview_window = ''

map <C-p> :Files<CR>
map <C-s><C-s> :Rg<CR>

" Gundo
let g:gundo_right = 1  " Open Gundo window on the right hand side
map <Leader>g :GundoToggle<CR>

" NERDTree
let g:NERDTreeWinSize = 45  " Set default NERDTree window width
map <Leader>f :NERDTreeFind<CR>
map <Leader>t :NERDTreeToggle<CR>
