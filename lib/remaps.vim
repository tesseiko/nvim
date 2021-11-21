
nnoremap Y y$
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J m`J``

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

" file navigation
nnoremap <silent> <leader>? :tabnew ~/vimwiki/src/vim.md<cr>
nnoremap <silent> <leader>rc :tabnew ~/.config/nvim/init.vim<cr>
nnoremap <silent> <C-n> :bnext<cr>
nnoremap <silent> <C-p> :bprev<cr>
nnoremap <silent> <C-q> :bd<cr>

" etc
nnoremap <leader>m i<@><esc> 
nnoremap <leader>M /<@><cr>
nnoremap <leader><tab> /<@><cr>3cl
nnoremap <silent> <leader>h :tabprev<cr>
map <silent> <F9> :tabprev<cr>
map <silent> <F10> :-tabmove<cr>
nnoremap <silent> <leader>l :tabnext<cr>
map <silent> <F12> :tabnext<cr>
map <silent> <F11> :+tabmove<cr>
nnoremap <leader>d dlp
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

" surround current line with empty lines and reverse
nnoremap <leader>s O<esc>jo<esc>k
nnoremap <leader>S kddjddk

