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

" Configure Vundle plugin manager
execute 'set rtp+=~/' . vimfiles . '/bundle/Vundle.vim'
call vundle#rc('~/' . vimfiles . '/bundle')

" Make Vundle manage itself
Plugin 'VundleVim/Vundle.vim'

" Specify plugins to install
Plugin 'KuoE0/vim-janitor'
Plugin 'Lokaltog/vim-powerline'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'Valloric/YouCompleteMe'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bkad/CamelCaseMotion'
Plugin 'chrisbra/Colorizer'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'garbas/vim-snipmate'
Plugin 'lyuts/vim-rtags'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'nfvs/vim-perforce'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'qpkorr/vim-bufkill'
Plugin 'rhysd/vim-clang-format'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-surround'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'

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
            \*/Debug/*,*/Release/*,*/Output/*,*/runtime/*,*/Build/*,
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
"
" CamelCaseMotion
call camelcasemotion#CreateMotionMappings('<leader>')

" CtrlP
let g:ctrlp_by_filename = 1 " Filename mode by default
let g:ctrlp_match_window = 'max:20' " Show up to 20 results

" Colorizer
let g:colorizer_auto_filetype='vim,css,html,cpp,hpp,c,h'

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

" Powerline
autocmd SessionLoadPost * silent PowerlineReloadColorscheme  " Keep colours
let g:Powerline_symbols = 'fancy'  " Disable fancy symbols for Powerline

" Session
let g:session_autoload = 'yes'  " Automatically load default session
let g:session_autosave = 'yes'  " Automatically save default session

" YouCompleteMe
let g:ycm_confirm_extra_conf = 0  " Do not prompt to load YCM config
let g:ycm_global_ycm_extra_conf = '~/' . vimfiles . '/.ycm_extra_conf.py'
nnoremap <Leader>yy :YcmCompleter GoTo<CR>
nnoremap <Leader>yh :YcmCompleter GoToDeclaration<CR>
nnoremap <Leader>yc :YcmCompleter GoToDefinition<CR>
nnoremap <Leader>yx :YcmCompleter GoToImplementationElseDeclaration<CR>
nnoremap <Leader>yu :YcmCompleter GoToImprecise<CR>
nnoremap <Leader>yr :YcmCompleter GoToReferences<CR>
nnoremap <Leader>yq :YcmRestartServer<CR>
