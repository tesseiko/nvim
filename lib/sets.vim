
syntax enable
filetype plugin on
set clipboard=unnamedplus
set path+=**
set wildmenu
set exrc
set secure
set rnu
set nu
set guicursor=
set foldmethod=syntax
set foldlevelstart=30
hi Folded ctermbg=0
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set splitright
set noexpandtab
set nowrap
set colorcolumn=100
highlight ColorColumn ctermbg=darkgray
set incsearch
set nohlsearch
set hidden
set scrolloff=4
set encoding=utf-8
set undofile
set noswapfile  
set cmdheight=2
set updatetime=50
set mouse=a

set undodir=~/.config/nvim/undodir
set tags=./tags;

colorscheme dracula
set cursorline
hi Normal ctermbg=NONE
hi CursorLine term=bold cterm=bold ctermbg=NONE guibg=NONE
