
"BASIC



" Dictionary: take mode() input -> longer notation of current mode
" mode() is defined by Vim
let g:currentmode={ 'n' : 'Normal ', 'no' : 'N·Operator Pending ', 'v' : 'Visual ', 'V' : 'V·Line ', '^V' : 'V·Block ', 's' : 'Select ', 'S': 'S·Line ', '^S' : 'S·Block ', 'i' : 'Insert ', 'R' : 'Replace ', 'Rv' : 'V·Replace ', 'c' : 'Command ', 'cv' : 'Vim Ex ', 'ce' : 'Ex ', 'r' : 'Prompt ', 'rm' : 'More ', 'r?' : 'Confirm ', '!' : 'Shell ', 't' : 'Terminal '}


" Function: return current mode
" abort -> function will abort soon as error detected
function! ModeCurrent() abort
    let l:modecurrent = mode()
    " use get() -> fails safely, since ^V doesn't seem to register
    " 3rd arg is used when return of mode() == 0, which is case with ^V
    " thus, ^V fails -> returns 0 -> replaced with 'V Block'
    let l:modelist = toupper(get(g:currentmode, l:modecurrent, 'V·Block '))
    let l:current_status_mode = l:modelist
    return l:current_status_mode
endfunction



function! GitBranch()
	" return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
	return system("git branch --show-current 2> /dev/null | tr -d '\n'")
	" return system("git_current_branch")
endfunction

function! StatuslineGit()
	let l:branchname = GitBranch()
	return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

function! My_git_status()
	""br=`git_current_branch`
	""let l:br=$(git_current_branch)
	return system("git_current_branch")
endfunction

set statusline= 
""set statusline+=%0*\ %{toupper(g:currentmode[mode()])} 
set statusline+=%#LineNr#
set statusline+=\ %{ModeCurrent()}
set statusline+=%#folded#
set statusline+=%#conceal#
set statusline+=%{StatuslineGit()}
" set statusline+=%{My_git_status()}
set statusline+=%#WildMenu#
set statusline+=\ %f
set statusline+=%=
set statusline+=%m
set statusline+=%#LineNr#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
"set statusline+=\ 

set laststatus=2
