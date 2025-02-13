vim.g.mapleader = ' '
require("package_manager")
require("completions")
require("remaps")
require("dev_tools")
-- vim.cmd [[colorscheme dracula]]
require("settings")
require("desktop")

-- vim.o.background = "dark" -- or "light" for light mode
-- vim.cmd([[colorscheme gruvbox]])
vim.api.nvim_set_keymap("n", "<leader>nr", "<cmd>luafile $MYVIMRC<CR>", {noremap = true, silent = true})
