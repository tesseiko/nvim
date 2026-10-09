return {
    -- Package management
    { 'williamboman/mason.nvim', config = function() require('mason').setup() end },
    { 'williamboman/mason-lspconfig.nvim' },

    -- LSP config (recipes)
    { 'neovim/nvim-lspconfig' },

    -- Autocompletion (keep for now, remove blink.cmp)
    { 'hrsh7th/nvim-cmp', dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',
        'folke/neodev.nvim',
    }, config = function()
        require("neodev").setup()
        local cmp = require('cmp')
        cmp.setup({
            sources = {
                { name = 'nvim_lsp' },
                { name = 'path' },
                { name = 'luasnip' },
                { name = 'buffer' },
            },
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            }),
        })
    end},

    -- LSP server config + keymaps
    {
        'neovim/nvim-lspconfig',
    config = function()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    vim.lsp.enable({ 'clangd', 'lua_ls', 'pylsp' })

    vim.lsp.config('lua_ls', {
        settings = {
            lua = {
                workspace = {
                    library = {
                        '/usr/share/nvim/runtime/lua',
                        '/usr/share/nvim/runtime/lua/lsp',
                        '/usr/share/awesome/lib'
                    }
                },
                diagnostics = {
                    globals = { 'vim', 'awesome', 'awful', 'client',
                        'screen', 'tag', 'root' }
                },
                runtime = { version = 'luajit' },
            }
        }
    })

    vim.lsp.config('pylsp', {
        settings = {
            pylsp = {
                plugins = {
                    pyflakes = { enabled = false },
                    pylint = { enabled = false },
                    pycodestyle = { enabled = false },
                }
            }
        }
    })

    vim.lsp.config('clangd', {
        cmd = {
            'clangd',
            '--background-index',
            '--clang-tidy',
            '--header-insertion=never',
            '--completion-style=detailed'
        },
        settings = {
            clangd = {
                fallbackFlags = { '-std=c++20',
                    '--query-driver=/usr/bin/g++',
            },
                semantichighlighting = true,
            }
        }
    })

    vim.diagnostic.config({ virtual_text = true })

    vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
            local bufnr = args.buf
            local opts = { buffer = bufnr, remap = false }

            -- vim.keymap.set('n', 'gD', vim.lsp.buf.declarations, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<c-k>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set('n', '<leader>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
            vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        end,
    })
end,
    },
}
