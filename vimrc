"----------
" Vimfiles
"==========

" Useful variables
if has("win32")
  let vimfiles = "vimfiles"
else
  let vimfiles = ".vim"
endif

"---------
" Plugins
"=========

" Configure vim-plug plugin manager
call plug#begin('~/' . vimfiles . '/plugged')

" Specify plugins to install
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'bkad/CamelCaseMotion'
Plug 'chrisbra/Colorizer'
Plug 'kuoe0/vim-janitor'
Plug 'lyuts/vim-rtags'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'nfvs/vim-perforce'
Plug 'ntpeters/vim-better-whitespace'
Plug 'qpkorr/vim-bufkill'
Plug 'rhysd/vim-clang-format'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-surround'

" Mac specific
if has("mac")
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'
endif

" Colour schemes
Plug 'altercation/vim-colors-solarized'
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'

" Initialize plugin manager
call plug#end()

"------------
" Appearance
"============

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
set completeopt=menu,menuone,longest  " Disable preview scratch window

if version >= 703
  set colorcolumn=81
endif

" Colour scheme and syntax highlighting
syntax enable  " Use default syntax highlighting
colorscheme solarized  " Set to a cool colour scheme
set background=dark  " Use a dark colour scheme
let g:load_doxygen_syntax = 1  " Enable doxygen syntax highlighting

"---------
" Buffers
"=========

autocmd BufRead,BufNewFile
  \ *.glsl,*.hlsl,*.fs,*.vs,*.vert,*.frag,*.vert.block,*.frag.block,
  \*.ap,*.mat,*.sp
  \ set filetype=.c

autocmd BufRead,BufNewFile
  \ *.i
  \ set filetype=.cpp

filetype plugin indent on  " Turn on all file type detection
set hidden  " Change buffers without saving!
set fileformats=unix,dos  " Make new files have unix line endings
set noswapfile  " Don't use swap files (slow over network)

" Ignored filesystem names
set wildignore+=
  \*.swp,*.bak,
  \*doxygen*,
  \*/Debug/*,*/Release/*,*/Output/*,*/runtime/*,
  \*.ncb,*.suo,*.user,*.class,*.pyc,*.obj,
  \*.glo,*.png,*.bmp,*.jpg  " Asset files

"------------------
" Custom Behaviour
"==================

" General settings
set history=1000  " Increase command history
set pumheight=15  " Max items in autocomplete menu
set viminfo='1000,f1,:1000,/50,@50,!  " Increase viminfo storage!
set wildmenu  " Display command line completion list

" Text input
set backspace=2  " Make backspace delete over lines
set expandtab  " Insert spaces instead of tabs
set shiftwidth=2  " Set the indentation width
set tabstop=2  " Number of spaces per tab
set softtabstop=2  " Number of spaces per tab

" Search
set hlsearch  " Highlight all search matches
set ignorecase  " Case-insensitive search
set incsearch  " React to search while typing
set smartcase  " Case sensitive search only if term includes upper-case

" Change the leader character
let mapleader = ","

" Open vimrc
execute 'nmap <Leader>v :e $HOME/' . vimfiles . '/vimrc<CR>'

" Ctrl-C literally means Escape
nnoremap <C-c> :let @/ = ""<CR><Esc>
inoremap <C-c> <Esc>
vnoremap <C-c> <Esc>

" Search for selected word or word under cursor
nnoremap <Leader>s yiw:%s/0//gc<Left><Left><Left>
vnoremap <Leader>s y:%s/0//gc<Left><Left><Left>
nnoremap <Leader><Leader>s yiw:%s/\<0\>//gc<Left><Left><Left>
vnoremap <Leader><Leader>s y:%s/\<0\>//gc<Left><Left><Left>
" Search for word until _ (e.g. for preprocessor constants)
nnoremap <Leader>S yt_:%s/0//gc<Left><Left><Left>

" Change-paste operator
nmap <silent> cp :set opfunc=ChangePaste<CR>g@
function! ChangePaste(type, ...)
  silent exe "normal! `[v`]\"_c"
  silent exe "normal! p"
endfunction

"----------------------
" Plugin Configuration
"======================

" Airline
let g:airline_theme = 'murmur'
let g:airline#extensions#tabline#enabled = 1
nmap <C-q>h :bp<CR>
nmap <C-q><C-h> :bp<CR>
nmap <C-q>l :bn<CR>
nmap <C-q><C-l> :bn<CR>

" CamelCaseMotion
call camelcasemotion#CreateMotionMappings('<leader>')

" Colorizer
let g:colorizer_auto_filetype = 'vim,css,html,cpp,hpp,c,h'

" FZF
function! FzfFiles()
  " fd reads any .gitignore files
  let cmd = 'fd --type f'
  " Ignore the current file if it exists
  let this = expand('%')
  if this !=# ''
    let cmd = cmd . ' -E ' . shellescape(this)
  endif
  call fzf#run(fzf#wrap({'source': cmd, 'options': '--tiebreak=end'}))
endfunction

command! -bang -nargs=* AgCpp
  \ call fzf#vim#ag(<q-args>,
  \                 '--cpp',
  \                 {'options': '--delimiter : --nth 4..'},
  \                 <bang>0)

command! -bang -nargs=* AgJava
  \ call fzf#vim#ag(<q-args>,
  \                 '--java',
  \                 {'options': '--delimiter : --nth 4..'},
  \                 <bang>0)

command! -bang -nargs=* AgPython
  \ call fzf#vim#ag(<q-args>,
  \                 '--python',
  \                 {'options': '--delimiter : --nth 4..'},
  \                 <bang>0)

command! -bang -nargs=* AgGlsl
  \ call fzf#vim#ag(<q-args>,
  \                 '-G "\.block$"',
  \                 {'options': '--delimiter : --nth 4..'},
  \                 <bang>0)

command! -bang -nargs=* AgCMake
  \ call fzf#vim#ag(<q-args>,
  \                 '-G "CMakeLists\.txt$|\.cmake$"',
  \                 {'options': '--delimiter : --nth 4..'},
  \                 <bang>0)

map <C-s><C-c> :AgCpp<CR>
map <C-s><C-j> :AgJava<CR>
map <C-s><C-p> :AgPython<CR>
map <C-s><C-g> :AgGlsl<CR>
map <C-s><C-m> :AgCMake<CR>
map <C-p> :call FzfFiles()<CR>

let g:fzf_colors =
  \ { 'fg':      ['fg', 'Normal'],
  \   'bg':      ['bg', 'Normal'],
  \   'hl':      ['fg', 'Comment'],
  \   'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \   'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \   'hl+':     ['fg', 'Statement'],
  \   'info':    ['fg', 'PreProc'],
  \   'border':  ['fg', 'Ignore'],
  \   'prompt':  ['fg', 'Conditional'],
  \   'pointer': ['fg', 'Exception'],
  \   'marker':  ['fg', 'Keyword'],
  \   'spinner': ['fg', 'Label'],
  \   'header':  ['fg', 'Comment'] }

" Gruvbox
let g:gruvbox_contrast_dark = 'soft'

" Gundo
let g:gundo_right = 1  " Open Gundo window on the right hand side
map <Leader>g :GundoToggle<CR>

" Janitor
let g:janitor_enable_highlight = 0  " Do not highlight trailing whitespace
let g:janitor_auto_clean_up_on_write = 1  " Clean code on save
let g:janitor_auto_clean_up_trailing_space_only_added = 1  " Strip whitespace

" NERDTree
let g:NERDTreeWinSize = 45  " Set default NERDTree window width
map <Leader>f :NERDTreeFind<CR>
map <Leader>t :NERDTreeToggle<CR>

" Perforce
let g:perforce_prompt_on_open = 0  " Do not prompt to open
nnoremap <Leader>p4e :P4edit<CR>
nnoremap <Leader>p4i :P4info<CR>
nnoremap <Leader>p4m :P4movetocl<CR>
nnoremap <Leader>p4r :P4revert<CR>
