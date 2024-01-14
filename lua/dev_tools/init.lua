local running_jobs = {}

function SmartBuild()
    local build_commands = require('dev_tools.build_commands')
    local build_command, job_options = build_commands.get_build_command()

    local job = vim.fn.jobstart(build_command, job_options)
    table.insert(running_jobs, {key = job, value = build_command})
end

function Toggle_error_win()
    require('dev_tools.winbufutils').toggle_error_win()
end

local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local sorters = require('telescope.sorters')
local action_state = require('telescope.actions.state')
local actions = require('telescope.actions')

local function select_and_kill(prompt_bufnr)
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

function Telescope_kill_job()

    local l2 = {}
    for key, value in pairs(running_jobs) do
       table.insert(l2, tostring(value.key)..tostring(value.value))
    end

  pickers.new {
    results_title = 'Running Jobs',
    finder = finders.new_table {
      results = l2,
    },
    sorter = sorters.get_generic_fuzzy_sorter(),
    attach_mappings = function(_, map)
      map('i', '<CR>', select_and_kill)
      map('n', '<CR>', select_and_kill)
      return true
    end
  }:find()
end


vim.api.nvim_set_keymap("n", "<leader>tb", "<cmd>lua SmartBuild()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>tm", "<cmd>lua Toggle_error_win()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>tk", "<cmd>lua Telescope_kill_job()<CR>", {noremap = true, silent = true})
