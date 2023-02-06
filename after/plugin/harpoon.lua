
require("telescope").load_extension('harpoon')

local opts = { noremap=true, silent=true }
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set('n', '<leader>he', '<cmd> lua require("harpoon.tmux").gotoTerminal("build")<cr>', opts)
vim.keymap.set('n', '<leader>hr', '<cmd> lua require("harpoon.cmd-ui").toggle_quick_menu()<cr>', opts)
vim.keymap.set('n', '<leader>hq', ui.toggle_quick_menu)
vim.keymap.set('n', '<leader>hw', mark.add_file)

vim.keymap.set('n', '<leader>1', function() ui.nav_file(1) end)
vim.keymap.set('n', '<leader>2', function() ui.nav_file(2) end)
vim.keymap.set('n', '<leader>3', function() ui.nav_file(3) end)
vim.keymap.set('n', '<leader>4', function() ui.nav_file(4) end)

-- vim.keymap.set('n', '<leader>n', ui.nav_next)
-- vim.keymap.set('n', '<leader>p', ui.nav_prev)
