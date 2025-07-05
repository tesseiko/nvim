if true then
  return {}
end

-- https://github.com/akinsho/toggleterm.nvim

require("toggleterm").setup({
  open_mapping = [[<c-\>]],
})

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
local fuzzydict = Terminal:new({ cmd = "fuzzydict", hidden = true, direction = "float" })

function _lazygit_toggle()
  lazygit:toggle()
end

function _fuzzydict_toggle()
  fuzzydict:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>tg", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>td", "<cmd>lua _fuzzydict_toggle()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader><cr>", "<Esc><Cmd>ToggleTermToggleAll<CR>", { noremap = true, silent = true })
