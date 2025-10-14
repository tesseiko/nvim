return{

    -- Fuzzy Finder (files, lsp, etc)
    { 'nvim-telescope/telescope.nvim',
        -- branch = '1.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' } },

    'numToStr/Comment.nvim', -- "gc" to comment visual regions/lines

    { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true } },

    -- Fuzzy Finder Algorithm which requires local dependencies to be built. 
    -- Only load if `make` is available
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

    'norcalli/nvim-colorizer.lua',


    { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        build = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end,
    },

    { -- Additional text objects via treesitter
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = 'nvim-treesitter',
    },

    { -- Additional text objects via treesitter
        'nvim-treesitter/nvim-treesitter-angular',
        dependencies = 'nvim-treesitter',
    },

    "nvim-treesitter/nvim-treesitter-context",

    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    },

    'tpope/vim-fugitive',
    'airblade/vim-gitgutter',

    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
    },

    { 'vimwiki/vimwiki' },
    {'chipsenkbeil/vimwiki-server.nvim', tag = 'v0.1.0-alpha.5'},
    {'akinsho/toggleterm.nvim'},
    'ryanoasis/vim-devicons',
    'kyazdani42/nvim-web-devicons',

    {
        "kyazdani42/nvim-tree.lua",
        dependencies = {
            "kyazdani42/nvim-web-devicons", -- optional, for file icons
        },
    },

    -- themes
    'Mofiqul/dracula.nvim',
    { "ellisonleao/gruvbox.nvim" },
    'rcarriga/nvim-notify',
    'simrat39/symbols-outline.nvim',
    'MunifTanjim/nui.nvim',

    -- lazy.nvim
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
