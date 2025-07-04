

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>F', builtin.buffers, {})
vim.keymap.set('n', '<leader>q', builtin.quickfix, {})
vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
vim.keymap.set('n', '<leader>gc', builtin.git_commits, {})
vim.keymap.set('n', '<leader>gf', function()
    builtin.git_files({ recurse_submodules = true })
end, {})
vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>la', builtin.lsp_dynamic_workspace_symbols, {})
vim.keymap.set('n', '<leader>gr', builtin.lsp_references)
-- vim.keymap.set('n', '<leader>ld', builtin.lsp_document_diagnostics, {})
vim.keymap.set('n', 'gr', builtin.lsp_references, {})

vim.keymap.set('n', '<leader>tt', builtin.builtin)
vim.keymap.set('n', '<c-->', builtin.resume)

vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, {})

local telescope = require('telescope')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local sorters = require('telescope.sorters')


local words = {"TODO: ", "FIX: ", "NOTE: ", "WARN: "}

local function select_word(prompt_bufnr)
    local selection = action_state.get_selected_entry(prompt_bufnr)
    local comment_api = require('Comment.api')

    actions.close(prompt_bufnr)
    comment_api.uncomment.linewise()
    local crs = vim.api.nvim_win_get_cursor(0);
    vim.api.nvim_command("normal! ^")
    vim.api.nvim_put({selection.value}, '', false, true)
    comment_api.comment.linewise()
    vim.api.nvim_win_set_cursor(0, {crs[1], crs[2] + #(selection.value)})
end

local word_picker = function()
  pickers.new {
    results_title = 'Words',
    finder = finders.new_table {
      results = words,
    },
    sorter = sorters.get_generic_fuzzy_sorter(),
    attach_mappings = function(_, map)
      map('i', '<CR>', select_word)
      map('n', '<CR>', select_word)
      return true
    end
  }:find()
end

-- return word_picker

vim.keymap.set('n', '<leader>ti', word_picker)
