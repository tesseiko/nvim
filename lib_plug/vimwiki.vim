
" github theme
" used by vimwiki html generator (pandas)
let g:vimwiki_list = [{
            \ 'auto_export': 1,
            \ 'auto_header' : 1,
            \ 'automatic_nested_syntaxes':1,
            \ 'path_html': '$HOME/vimwiki/html',
            \ 'path': '$HOME/vimwiki/src',
            \ 'template_path': '$HOME/vimwiki/templates/',
            \ 'template_default':'GitHub',
            \ 'template_ext':'.html5',
            \ 'syntax': 'markdown',
            \ 'ext':'.md',
            \ 'custom_wiki2html': '$HOME/vimwiki/wiki2html.sh',
            \ 'autotags': 1,
            \ 'list_margin': 0,
            \ 'links_space_char' : '_',
            \}]
let g:vimwiki_folding='expr'
let g:vimwiki_hl_headers = 1
let g:vimwiki_ext2syntax = {'.md': 'markdown'}


autocmd filetype vimwiki	nnoremap <buffer> <leader>t :VimwikiToggleListItem<cr>



" dark
" let g:vimwiki_list = [{'path': '$HOME/vimwiki/src',
"           \ 'template_path': '$HOME/vimwiki/templates/',
"           \ 'auto_export': 1,
" 		  \ 'template_default': 'def_template',
"           \ 'path_html': '$HOME/vimwiki/html',
"           \ 'syntax': 'markdown',
"           \ 'custom_wiki2html': '$HOME/vimwiki/wiki2html.sh',
"           \ 'ext':'.md',
" 		  \ 'template_ext': '.html'}]
" 
" " add the pre tag for inserting code snippets
" let g:vimwiki_valid_html_tags = 'b,i,s,u,sub,sup,kbd,br,hr, pre, script'
