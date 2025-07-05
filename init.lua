vim.g.mapleader = " "
-- require("lef.package_manager")
require("config.lazy")

-- require("lef.completions")
require("lef.remaps")
-- require("lef.dev_tools")
-- vim.cmd [[colorscheme dracula]]
require("lef.settings")
require("lef.desktop")

-- vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
vim.api.nvim_set_keymap("n", "<leader>nr", "<cmd>luafile $MYVIMRC<CR>", { noremap = true, silent = true })
