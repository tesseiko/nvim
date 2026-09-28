local job_control = require('dev_tools.job_control')

function SmartBuildTarget()

    local picker = require('dev_tools.make_targets')
    -- Open Telescope first, and provide a callback function
    picker.choose_make_target(function(target)
        -- This block only executes if a valid target was chosen and confirmed
        local build_commands = require('dev_tools.build_commands')
        local build_command, job_options = build_commands.get_build_command()

        -- Append the target to the build command string
        local final_command = build_command .. " " .. target

        -- Start the job with the updated command string
        local job = vim.fn.jobstart(final_command, job_options)
        job_control.new_job({id = job, command = final_command})
    end)
end

function SmartBuild()
    local build_commands = require('dev_tools.build_commands')
    local build_command, job_options = build_commands.get_build_command()

    local job = vim.fn.jobstart(build_command, job_options)
    job_control.new_job({id = job, command = build_command})
end

-- TODO: 
function SmartRun()
    local build_commands = require('dev_tools.build_commands')
    local build_command, job_options = build_commands.get_build_command()

    local job = vim.fn.jobstart(build_command, job_options)
    job_control.new_job({id = job, command = build_command})
end

function SmartClean()
    local build_commands = require('dev_tools.build_commands')
    local build_command, job_options = build_commands.get_clean_command()

    local job = vim.fn.jobstart(build_command, job_options)
    job_control.new_job({id = job, command = build_command})
end

function Toggle_error_win_center()
    require('dev_tools.winbufutils').toggle_error_win("center")
end

function Toggle_error_win_side()
    require('dev_tools.winbufutils').toggle_error_win("top_right")
end

function Toggle_scratch_win_side()
    require('dev_tools.winbufutils').toggle_scratch_win("top_right")
end


function Telescope_build_jobs()
    job_control.Telescope_build_jobs()
end


-- build specific target
vim.keymap.set("n", "<leader>tB",  "<cmd>lua SmartBuildTarget()<CR>", { desc = "Select Make Target" })
-- build project
vim.api.nvim_set_keymap("n", "<leader>tb", "<cmd>lua SmartBuild()<CR>", {noremap = true, silent = true})
-- clean project
vim.api.nvim_set_keymap("n", "<leader>tc", "<cmd>lua SmartClean()<CR>", {noremap = true, silent = true})
-- error window big
vim.api.nvim_set_keymap("n", "<leader>tM", "<cmd>lua Toggle_error_win_center()<CR>", {noremap = true, silent = true})
-- error window small
vim.api.nvim_set_keymap("n", "<leader>tm", "<cmd>lua Toggle_error_win_side()<CR>", {noremap = true, silent = true})
-- quick notes window
vim.api.nvim_set_keymap("n", "<leader>tn", "<cmd>lua Toggle_scratch_win_side()<CR>", {noremap = true, silent = true})
-- list running jobs
vim.api.nvim_set_keymap("n", "<leader>tk", "<cmd>lua Telescope_build_jobs()<CR>", {noremap = true, silent = true})
-- move to next error - usefull in error window
vim.api.nvim_set_keymap("n", "]e", "/error<CR>", {noremap = true, silent = true})
-- move to previous error - usefull in error window
vim.api.nvim_set_keymap("n", "[e", "?error<CR>", {noremap = true, silent = true})
-- move to next warning - usefull in error window
vim.api.nvim_set_keymap("n", "]w", "/warning<CR>", {noremap = true, silent = true})
-- move to previous warning - usefull in error window
vim.api.nvim_set_keymap("n", "[w", "?warning<CR>", {noremap = true, silent = true})
