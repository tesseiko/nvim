  -- disable netrw at the very start of your init.lua
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  -- set termguicolors to enable highlight groups
  vim.opt.termguicolors = true

  -- empty setup using defaults
  -- require("nvim-tree").setup()

  -- OR setup with some options
  require("nvim-tree").setup({
      sort = {
          sorter = "case_sensitive",
      },
      view = {
          width = 30,
      },
      renderer = {
          group_empty = true,
      },
      update_focused_file = {
          enable = true,
          update_root = true
      },
      filters = {
          dotfiles = true,
      },
      actions = {
          open_file = {
              quit_on_open = true,
          },
      },
  })

vim.keymap.set('n', '<leader>E', [[:NvimTreeToggle<cr>]], {silent = true})

