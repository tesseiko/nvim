
-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.cmd([[

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
set formatoptions+=actw
set breakindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set splitright
set splitbelow
set expandtab
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

let g:tex_flavor = 'latex'
set undodir=~/.config/nvim/undodir
set tags=./tags;

colorscheme dracula
set cursorline
hi Normal ctermbg=NONE
hi CursorLine term=bold cterm=bold ctermbg=NONE guibg=NONE
highlight WinSeparator guifg=#403510
]])
