if true then
  return {}
end
local telescope = require("telescope")
telescope.load_extension("notify")

require("notify").setup({
  background_colour = "#deaf42",
})

vim.api.nvim_set_keymap(
  "n",
  "<leader>tw",
  '<cmd> lua require("telescope").extensions.notify.notify()<CR>',
  { noremap = true, silent = true }
)
vim.keymap.set("n", "<leader>tq", '<cmd> lua require("notify").dismiss({})<CR>', { noremap = true, silent = true })
