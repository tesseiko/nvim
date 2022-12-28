

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>F', builtin.buffers, {})
vim.keymap.set('n', '<leader>q', builtin.quickfix, {})
vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
vim.keymap.set('n', '<leader>gc', builtin.git_commits, {})
vim.keymap.set('n', '<leader>gs', builtin.git_status, {})
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>la', builtin.lsp_dynamic_workspace_symbols, {})
-- vim.keymap.set('n', '<leader>ld', builtin.lsp_document_diagnostics, {})
vim.keymap.set('n', 'gr', builtin.lsp_references, {})

vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, {})
