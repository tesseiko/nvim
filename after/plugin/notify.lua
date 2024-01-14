local telescope = require("telescope")
telescope.load_extension("notify")

vim.api.nvim_set_keymap("n", "<leader>tn", '<cmd> lua require("telescope").extensions.notify.notify()<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>tq', '<cmd> lua require("notify").dismiss({})<CR>', { noremap = true, silent = true })
