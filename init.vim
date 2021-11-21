"BASIC

set nocompatible
let mapleader=" "

" build"
autocmd filetype vim	nnoremap <buffer> <leader>b :w<cr>:so<space>%<cr>
set makeprg=make\ -C\ ../build\ -j4
" autocmd filetype python	nnoreap <buffer> <leader>b :w<cr>:!python %<cr>

augroup project
	autocmd!
	autocmd BufRead,BufNewFile *.h,*.c set filetype=c
augroup END

command! -nargs=1 CreateSession :mksession <args>.vim | !ln -sf $(realpath <args>.vim) ~/.config/vim/sessions/<args>.vim
command! -nargs=1 SaveSession :mksession <args>_tmp.vim |!mv <args>_tmp.vim <args>.vim && ln -sf $(realpath <args>.vim) ~/.config/vim/sessions/<args>.vim

command! OpenGreek :!st -f"Inconsolata LGC:style=Regular:size=12" -e nvim %
command! MakeTags !ctags -R .
" use ^] to jump to tag
" use g^] to see ambiguous tags
" use ^t to jump back to tag stack

for f in split(glob('~/.config/nvim/lib/*.vim'), '\n')
	exe 'source' f
endfor

for f in split(glob('~/.config/nvim/lib_plug/*.vim'), '\n')
	exe 'source' f
endfor

