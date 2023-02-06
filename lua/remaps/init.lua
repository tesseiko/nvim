vim.cmd([[

nnoremap Y y$
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J m`J``

vnoremap <leader>i <C-a>
vnoremap g<leader>i g<C-a>
nnoremap <leader>i <C-a>

" undo breakpoints
inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap ; ;<C-g>u

" moving
nnoremap <leader>k :m .-2<cr>==
nnoremap <leader>j :m .+1<cr>==
vnoremap K :m '<-2<cr>gv=gv
vnoremap J :m '>+1<cr>gv=gv
inoremap <C-l> <right>
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-h> <left>
inoremap <C-M-e> € 

nnoremap <leader>y "py
nnoremap <leader>p "pp
nnoremap <leader>P "pP
nnoremap <leader>d "_d

" file navigation
nnoremap <silent> <leader>? :tabnew ~/vimwiki/src/vim.md<cr>
nnoremap <silent> <leader>rc :tabnew ~/.config/nvim/init.lua<cr>
nnoremap <silent> <C-n> :bnext<cr>
nnoremap <silent> <C-p> :bprev<cr>
nnoremap <silent> <C-q> :b#<bar>bd#<cr>

" etc
nnoremap <leader>m i<@><esc> 
nnoremap <leader>M /<@><cr>
nnoremap <leader><tab> /<@><cr>3cl
nnoremap <silent> <leader><C-h> :tabprev<cr>
nnoremap <silent> <leader><C-l> :tabnext<cr>
nnoremap - <C-W><
nnoremap + <C-W>>
nnoremap <C--> <C-W>-
nnoremap <C-+> <C-W>+
inoremap :w<cr> <esc>:w<cr>
tnoremap <esc><esc> <C-\><C-n>
tnoremap <C-w> <C-\><C-n><C-w>
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <silent><C-k> :cprev<cr> 
nnoremap <silent><C-j> :cnext<cr>
nnoremap <C-s> :w<cr>
inoremap <C-s> <esc>:w<cr>
if &diff
nnoremap <leader>dp :diffput<cr>
nnoremap <leader>dg :diffget<cr>
nnoremap <leader>dh :diffget 1<cr>
nnoremap <leader>dl :diffget 3<cr>
endif
nnoremap <silent><leader>lq :LspStop<cr>

" surround current line with empty lines and reverse
nnoremap <leader>s O<esc>jo<esc>k
nnoremap <leader>S kddjddk

]])

vim.cmd([[
map α a
map ς w
map ε e
map ρ r
map τ t
map υ y
map θ u
map ι i
map ο o
map π p
map σ s
map δ d
map φ f
map γ g
map η h
map ξ j
map κ k
map λ l
map ζ z
map χ x
map ψ c
map ω v
map β b
map ψ c
map μ m
map ν n

map Α A
map Σ W
map Ε E
map Ρ R
map Τ T
map Υ Y
map Θ U
map Ι I
map Ο O
map Π P
map Σ S
map Δ D
map Φ F
map Γ G
map Η H
map Ξ J
map Κ K
map Λ L
map Ζ Z
map Χ X
map Ψ C
map Ω V
map Β B
map Ψ C
map Μ M
map Ν Ν

nmap γ;ιπ gqip
nmap ψς cw
nmap ψις ciw
nmap δς dw
]])

