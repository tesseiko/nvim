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
" TODO fix cprev and cnext remaps - confilict with lsp remaps

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

" Some git helpers
function Commit(...)
	let msgStr = ""
	for msg in a:000
		let msgStr = msgStr." -m \"".msg."\""
	endfor
	" :echom msgStr
	lcd %:p:h |!git add --all
	:exe '!git commit'  msgStr
	lcd -
endfunction

command! Push :lcd %:p:h |!git push <cr>: lcd -
command! Pull :lcd %:p:h |!git pull <cr>: lcd -
command! Add :lcd %:p:h |!git add % <cr>: lcd -
command! Tileei :lcd %:p:h |!git remote update && git status <cr>: lcd -

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

