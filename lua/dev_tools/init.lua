local job_control = require('dev_tools.job_control')

function SmartBuild()
    local build_commands = require('dev_tools.build_commands')
    local build_command, job_options = build_commands.get_build_command()

    local job = vim.fn.jobstart(build_command, job_options)
    job_control.new_job({id = job, command = build_command})
end

function Toggle_error_win()
    require('dev_tools.winbufutils').toggle_error_win()
end


function Telescope_build_jobs()
    job_control.Telescope_build_jobs()
end


vim.api.nvim_set_keymap("n", "<leader>tb", "<cmd>lua SmartBuild()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>tm", "<cmd>lua Toggle_error_win()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>tk", "<cmd>lua Telescope_build_jobs()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>ts", "<cmd>so %<CR>", {noremap = true, silent = true})
