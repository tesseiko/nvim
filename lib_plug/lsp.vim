" go lsp
"augroup LspGo
"  au!
"  autocmd User lsp_setup call lsp#register_server({
"      \ 'name': 'go-lang',
"      \ 'cmd': {server_info->['gopls']},
"      \ 'whitelist': ['go'],
"      \ })
"  autocmd FileType go setlocal omnifunc=lsp#complete
"  "autocmd FileType go nmap <buffer> gd <plug>(lsp-definition)
"  "autocmd FileType go nmap <buffer> ,n <plug>(lsp-next-error)
"  "autocmd FileType go nmap <buffer> ,p <plug>(lsp-previous-error)
"augroup END

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" gopls
lua require'lspconfig'.gopls.setup{ on_attach=require'completion'.on_attach }
" bash-language-server
lua require'lspconfig'.bashls.setup{ on_attach=require'completion'.on_attach }
" installed using yarn global add yaml-language-server
lua require'lspconfig'.yamlls.setup{ on_attach=require'completion'.on_attach }
" ansible-language-server
lua require'lspconfig'.ansiblels.setup{ on_attach=require'completion'.on_attach }
" typescript-language-server
lua require'lspconfig'.tsserver.setup{ on_attach=require'completion'.on_attach }
" ccls
lua require'lspconfig'.ccls.setup{ on_attach=require'completion'.on_attach }

nnoremap <silent> <leader>gd :lua vim.lsp.buf.definition()<cr>
