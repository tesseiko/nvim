" INDEX
"
" lib/comments.vim
" lib/completions.vim
" lib/plug.vim
" lib/remaps.vim
" lib/sets.vim
" lib/statusline.vim
"
" lib_plug/floaterm.vim
" lib_plug/gitgutter.vim
" lib_plug/lsp.vim
" lib_plug/servers.lua
" lib_plug/telescope.vim
" lib_plug/vimwiki.vim
"

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
command! -nargs=1 Commit :lcd %:p:h |!git add --all && git commit -m <args>
command! Push :lcd %:p:h |!git push
command! Pull :lcd %:p:h |!git pull
command! Add :lcd %:p:h |!git add %
command! Tileei :lcd %:p:h |!git remote update && git status

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

