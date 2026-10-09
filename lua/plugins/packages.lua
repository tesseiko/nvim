return{

    -- Fuzzy Finder (files, lsp, etc)
    { 'nvim-telescope/telescope.nvim',
        -- branch = '1.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' } },

    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

    'numToStr/Comment.nvim',

    { 'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
      config = function()
        require('lualine').setup {
          options = {
            icons_enabled = true,
            -- theme = 'gruvbox_light',
            -- theme = 'gruvbox_dark',
                component_separators = '|',
            theme = 'gruvbox-material',
            section_separators = '',
          },
        }
      end,
    },


    {
        'norcalli/nvim-colorizer.lua',
        config = function()
          require'colorizer'.setup()
        end,
    },

    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
          local harpoon = require("harpoon")
          harpoon:setup()
          vim.keymap.set("n", "<leader>hw", function() harpoon:list():add() end)
          vim.keymap.set("n", "<leader>hq", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
          
          vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
          vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
          vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
          vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
        end,
    },

    {
        'tpope/vim-fugitive',
        config = function()
          vim.keymap.set("n", "<leader>gs", vim.cmd.Git);
        end,
    },
    {
        'airblade/vim-gitgutter',
        config = function()
        end,
    },

    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
    },

    {'akinsho/toggleterm.nvim',
        config = function()
          require("toggleterm").setup{
              open_mapping = [[<c-\>]]
          }
          
          local Terminal  = require('toggleterm.terminal').Terminal
          local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float"})
          local fuzzydict = Terminal:new({ cmd = "fuzzydict", hidden = true, direction = "float"})
          
          function _lazygit_toggle()
            lazygit:toggle()
          end
          
          function _fuzzydict_toggle()
            fuzzydict:toggle()
          end
          
          vim.keymap.set('n', '<leader>ts', '<cmd>TermSelect<cr>', { noremap = true, silent = true })
          vim.keymap.set('n', '<leader><cr>', '<Esc><Cmd>ToggleTermToggleAll<CR>', { noremap = true, silent = true })
        end,
    },
    'kyazdani42/nvim-web-devicons',

    {
      'nvim-tree/nvim-tree.lua',
      lazy = false,
      keys = { '<leader>E' },
      config = function()
          vim.opt.termguicolors = true

          require('nvim-tree').setup({
              sort = { sorter = 'case_sensitive', },
              view = { width = 30, },
              renderer = { group_empty = true, },
              update_focused_file = {
                  enable = true,
                  update_root = true,
              },
              filters = { dotfiles = true, },
              actions = {
                  open_file = {
                      quit_on_open = true,
                  },
              },
          })

      vim.keymap.set('n', '<leader>E', '<cmd>NvimTreeToggle<cr>', { silent = true })
      end,
    },

    -- themes
    'Mofiqul/dracula.nvim',
    { "ellisonleao/gruvbox.nvim",
      config = function()
        require("gruvbox").setup({
          terminal_colors = false, -- add neovim terminal colors
          undercurl = true,
          underline = true,
          bold = false,
          italic = {
            strings = true,
            emphasis = true,
            comments = true,
            operators = false,
            folds = true,
          },
          strikethrough = true,
          invert_selection = false,
          invert_signs = false,
          invert_tabline = false,
          invert_intend_guides = false,
          inverse = true, -- invert background for search, diffs, statuslines and errors
          contrast = "hard", -- can be "hard", "soft" or empty string
          palette_overrides = {},
          overrides = {},
          dim_inactive = true,
          transparent_mode = false,
        })
        vim.o.background = "dark"
        vim.cmd("colorscheme gruvbox")
      end,
    },
    'rcarriga/nvim-notify',
    'simrat39/symbols-outline.nvim',

    {
        "folke/noice.nvim",
        -- event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    },
}
