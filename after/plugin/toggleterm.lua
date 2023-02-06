
-- https://github.com/akinsho/toggleterm.nvim

require("toggleterm").setup{
    open_mapping = [[<c-\>]]
}

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float"})

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>tg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader><cr>", "<Esc><Cmd>ToggleTermToggleAll<CR>", {noremap = true, silent = true})