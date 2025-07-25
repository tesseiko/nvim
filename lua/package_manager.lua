-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	is_bootstrap = true
	vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
	vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
	-- Package manager
	use 'wbthomason/packer.nvim'

	-- Fuzzy Finder (files, lsp, etc)
	use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }
    use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    -- Fuzzy Finder Algorithm which requires local dependencies to be built. 
    -- Only load if `make` is available
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }
    use {
        'phaazon/mind.nvim',
        branch = 'v2.2',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require'mind'.setup()
        end
    }
    use 'norcalli/nvim-colorizer.lua'
	use {
        'williamboman/mason.nvim',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},
			{'williamboman/mason-lspconfig.nvim'},

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-buffer'},
			{'hrsh7th/cmp-path'},
			{'saadparwaiz1/cmp_luasnip'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-nvim-lua'},
            {'folke/neodev.nvim'},

			-- Snippets
			{'L3MON4D3/LuaSnip'},
			{'rafamadriz/friendly-snippets'},
		}
	}

    use 'mfussenegger/nvim-dap'

    use {
        "rcarriga/nvim-dap-ui",
        requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }
    }

    use {
        "williamboman/mason.nvim",
        "mfussenegger/nvim-dap",
        "jay-babu/mason-nvim-dap.nvim",
    }

	use { -- Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter',
		run = function()
			pcall(require('nvim-treesitter.install').update { with_sync = true })
		end,
	}
	use { -- Additional text objects via treesitter
		'nvim-treesitter/nvim-treesitter-textobjects',
		after = 'nvim-treesitter',
	}
	use { -- Additional text objects via treesitter
		'nvim-treesitter/nvim-treesitter-angular',
		after = 'nvim-treesitter',
	}
    use("nvim-treesitter/nvim-treesitter-context");
    use {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    }
	use 'tpope/vim-fugitive'
	use 'airblade/vim-gitgutter'
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
    }
    use { 'vimwiki/vimwiki' }
    use {'chipsenkbeil/vimwiki-server.nvim', tag = 'v0.1.0-alpha.5'}
    use {'akinsho/toggleterm.nvim'}
    use 'ryanoasis/vim-devicons'
    use 'kyazdani42/nvim-web-devicons'
    use({
        "kyazdani42/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons", -- optional, for file icons
        },
    })
    -- themes
    use 'Mofiqul/dracula.nvim'
    use { "ellisonleao/gruvbox.nvim" }
    use 'rcarriga/nvim-notify'
    use 'simrat39/symbols-outline.nvim'
    use 'MunifTanjim/nui.nvim'
    -- lazy.nvim
    use {
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
    }

	if is_bootstrap then
		require('packer').sync()
	end
end)

--
-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})
