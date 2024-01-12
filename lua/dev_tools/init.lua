
function SmartBuild()
    local build_commands = require('dev_tools.build_commands')
    local build_command, job_options = build_commands.get_build_command()
    vim.fn.jobstart(build_command, job_options)
end

function Toggle_error_win()
    require('dev_tools.winbufutils').toggle_error_win()
end

vim.api.nvim_set_keymap("n", "<leader>tb", "<cmd>lua SmartBuild()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>tm", "<cmd>lua Toggle_error_win()<CR>", {noremap = true, silent = true})
