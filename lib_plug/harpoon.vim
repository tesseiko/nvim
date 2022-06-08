
lua << EOF

require("telescope").load_extension('harpoon')

local opts = { noremap=true, silent=true }

vim.api.nvim_set_keymap('n', '<space>hq', '<cmd> lua require("harpoon.ui").toggle_quick_menu()<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>hw', '<cmd> lua require("harpoon.mark").add_file()<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>he', '<cmd> lua require("harpoon.tmux").gotoTerminal("build")<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>hr', '<cmd> lua require("harpoon.cmd-ui").toggle_quick_menu()<cr>', opts)

vim.api.nvim_set_keymap('n', '<space>1', '<cmd> lua require("harpoon.ui").nav_file(1)<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>2', '<cmd> lua require("harpoon.ui").nav_file(2)<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>3', '<cmd> lua require("harpoon.ui").nav_file(3)<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>4', '<cmd> lua require("harpoon.ui").nav_file(4)<cr>', opts)

vim.api.nvim_set_keymap('n', '<space>n', '<cmd> lua require("harpoon.ui").nav_next()<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>p', '<cmd> lua require("harpoon.ui").nav_prev()<cr>', opts)
EOF
