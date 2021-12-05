
" github theme
" used by vimwiki html generator (pandas)
"let g:vimwiki_list = [{
"            \ 'auto_export': 1,
"            \ 'auto_header' : 1,
"            \ 'automatic_nested_syntaxes':1,
"            \ 'path_html': '$HOME/vimwiki/html',
"            \ 'path': '$HOME/vimwiki/src',
"            \ 'template_path': '$HOME/vimwiki/templates/',
"            \ 'template_default':'GitHub',
"            \ 'template_ext':'.html5',
"            \ 'syntax': 'markdown',
"            \ 'ext':'.md',
"            \ 'custom_wiki2html': '$HOME/vimwiki/wiki2html.sh',
"            \ 'autotags': 1,
"            \ 'list_margin': 0,
"            \ 'links_space_char' : '_',
"            \}]
autocmd filetype vimwiki	set textwidth=72
 
" github theme
" used by vimwiki html generator (pandas)
let g:vimwiki_list = [{
            \ 'auto_header' : 1,
            \ 'automatic_nested_syntaxes':1,
            \ 'path': '$HOME/vimwiki/src',
            \ 'syntax': 'markdown',
            \ 'ext':'.md',
            \ 'autotags': 1,
            \ 'list_margin': 0,
            \ 'links_space_char' : '_',
            \}]

let g:vimwiki_folding='list'
let g:vimwiki_hl_headers = 1
let g:vimwiki_ext2syntax = {'.md': 'markdown'}

