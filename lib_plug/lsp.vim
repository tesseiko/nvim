"let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

"nnoremap <silent> <leader>gd :lua vim.lsp.buf.definition()<cr>
lua << EOF

local pid = vim.fn.getpid()
local omnisharp_bin = "/home/lef/.local/share/nvim/lsp_servers/omnisharp/omnisharp/run"

require'lspconfig'.omnisharp.setup{
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) };
    ...
}

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- local folderOfThisFile = (...):match("(.-)[^%.]+$")
local home = os.getenv( "HOME" )
local vimlibpath = home .. '/.config/nvim/lib_plug/?.lua;'
package.path = vimlibpath .. package.path

local servers = require('servers')
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-- nvim_lsp['sumneko_lua'].setup {
-- 	settings = {
-- 		-- Insert your settings here
-- 		Lua = {
-- 			runtime = {
-- 				version = 'Lua 5.3',
-- 				path = {
-- 					'?.lua',
-- 					'?/init.lua',
-- 					vim.fn.expand'~/.luarocks/share/lua/5.3/?.lua',
-- 					vim.fn.expand'~/.luarocks/share/lua/5.3/?/init.lua',
-- 					'/usr/share/5.3/?.lua',
-- 					'/usr/share/lua/5.3/?/init.lua'
-- 				}
-- 			},
-- 			workspace = {
-- 				library = {
-- 					[vim.fn.expand'~/.luarocks/share/lua/5.3'] = true,
-- 					['/usr/share/lua/5.3'] = true
-- 				}
-- 			}
-- 		} 
-- 	}
-- }

EOF
