local opts = { noremap=true, silent=true }

-- basic completions
vim.keymap.set('i', '(', '()<left>', opts)
vim.keymap.set('i', '[', '[]<left>', opts)
vim.keymap.set('i', '"', '""<left>', opts)
vim.keymap.set('i', '\'', '\'\'<left>', opts)

vim.api.nvim_create_autocmd("filetype", {
    pattern = "sh",
    callback = function()
        vim.keymap.set('i', '`', '``<left>', opts)
        vim.keymap.set('v', '<leader>`', 'di`<esc>pa`<esc>', opts)
    end,
})

vim.keymap.set('i', '{', '{}<left>', opts)

-- single line surrounds
vim.keymap.set('v', '<leader>(', 'hdi()<esc>Pldlp', opts)
vim.keymap.set('v', '<leader>[' , 'hdi[]<esc>Pldlp', opts)
vim.keymap.set('v', '<leader>"' , 'hdi""<esc>Pldlp', opts)
vim.keymap.set('v', '<leader>\'' , 'hdi\'\'<esc>Pldlp', opts)
vim.keymap.set('v', '<leader>{' , 'hdi{}<esc>Pldlp', opts)

vim.api.nvim_create_autocmd("filetype", {
    pattern = {"html", "typescriptreact"},
    callback = function()
        vim.keymap.set('i', '<', '<><left>', opts)
        vim.keymap.set('i', '>>', '<esc>ya<ea!@#<esc>f>pF<a/<left><left><CR>!@#<CR><esc>?!@#<cr>n3cl', opts)
        vim.keymap.set('i', '<leader><tab>', '<esc>/!@#<cr>3cl', opts)
    end,
})

