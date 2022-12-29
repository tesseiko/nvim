
vim.cmd([[
" basic completions
inoremap ( ()<left>
inoremap [ []<left>
inoremap " ""<left>
inoremap ' ''<left>
autocmd FileType sh 	inoremap <buffer>  ` ``<left>
autocmd FileType sh 	vnoremap <buffer>  <leader>` di`<esc>pa`<esc>
autocmd FileType vim 	inoremap <buffer>  < <><left>
autocmd FileType vim 	vnoremap <buffer>  <leader>, di<lt><esc>pa><esc>
inoremap { {}<left>
" probably this should remaped only on C files (also java,js if I used them)
inoremap }} <ESC>/}<cr>i<cr><ESC>O
inoremap )) <ESC>/)<cr>i<cr><ESC>O
" single line surrounds
vnoremap <leader>( hdi()<esc>Pldlp
vnoremap <leader>[ hdi[]<esc>Pldlp
vnoremap <leader>" hdi""<esc>Pldlp
vnoremap <leader>' hdi''<esc>Pldlp
vnoremap <leader>{ hdi{}<esc>Pldlp

" advanced completions
autocmd filetype html 	inoremap <buffer> < <><left>
autocmd filetype html 	noremap <buffer> <silent> <esc> <esc>:wa<cr>
autocmd filetype css 	noremap <buffer> <silent> <esc> <esc>:wa<cr>
autocmd filetype html 	inoremap <buffer>  >> <esc>ya<ea!@#<esc>f>pF<a/<left><left><CR>!@#<CR><esc>?!@#<cr>n3cl
autocmd filetype html 	inoremap <buffer>  <leader><tab> <esc>/!@#<cr>3cl

autocmd filetype typescriptreact 	inoremap <buffer> < <><left>
autocmd filetype typescriptreact 	noremap <buffer> <silent> <esc> <esc>:wa<cr>
autocmd filetype typescriptreact 	inoremap <buffer>  >> <esc>ya<ea!@#<esc>f>pF<a/<left><left><CR>!@#<CR><esc>?!@#<cr>n3cl
autocmd filetype typescriptreact 	inoremap <buffer>  <leader><tab> <esc>/!@#<cr>3cl
]])
