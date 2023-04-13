
vim.keymap.set('n', '<leader>b', function ()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_call(bufnr, function()
        vim.cmd(':w')
    end)
    io.popen("tmake bear") end)
