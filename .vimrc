""""""""""""""""""""""
""PREFERENCES
""---------------------
"
let mapleader=" "
set number
syntax on
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set cursorline
set noerrorbells
set smartindent
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set hlsearch
set autoindent

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey
set background=dark

"""""""""""""""""""""""""
""PLUGINS
""-----------------------

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim' 
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'mbbill/undotree'
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-surround'
Plug 'ap/vim-css-color'

call plug#end()

"autocmd vimenter * NERDTree
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'
let NERDTreeShowLineNumbers=0
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1
let g:NERDTreeWinSize=38
let UndotreeWinSize=38
let g:netrw_banner=0
let g:lightline = {
	      \ 'colorscheme': 'default',
      \ }
" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports
set t_Co=256

syntax enable
set number relativenumber
let g:rehash256 = 1
let g:lightline = {
          \ 'colorscheme': 'wombat',
      \ }
