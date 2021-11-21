
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

" vim
autocmd filetype vim	inoremap <buffer> <leader><tab> <esc>f@cl
autocmd filetype vim	inoremap <buffer> " "
autocmd filetype vim	nnoremap <buffer> <leader>n onnoremap<space>
autocmd filetype vim	nnoremap <buffer> <leader>i oinoremap<space>
autocmd filetype vim	nnoremap <buffer> <leader>N oautocmd<space>filetype<space>@<tab>nnoremap<space><lt>buffer><space>@<esc>F@cw
autocmd filetype vim	nnoremap <buffer> <leader>I oautocmd<space>filetype<space>@<tab>inoremap<space><lt>buffer><space>@<esc>F@cw
autocmd filetype vim	nnoremap <buffer> <leader>ln onnoremap<space><lt>leader>
autocmd filetype vim	nnoremap <buffer> <leader>li oinoremap<space><lt>leader>
autocmd filetype vim	nnoremap <buffer> <leader>lN oautocmd<space>filetype<space>@<tab>nnoremap<space><lt>buffer><space><lt>leader>@<esc>0f@cw
autocmd filetype vim	nnoremap <buffer> <leader>lI oautocmd<space>filetype<space>@<tab>inoremap<space><lt>buffer><space><lt>leader>@<esc>0f@cw

