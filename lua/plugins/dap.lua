return {
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'nvim-neotest/nvim-nio',
        },
        config = function()
            local dap = require('dap')

            -- C/C++ configuration with GDB (cpptools via Mason)
            dap.adapters.cppdbg = {
                id = 'cppdbg',
                type = 'executable',
                command = vim.fn.stdpath('data') .. '/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
            }

            dap.configurations.cpp = {
                {
                    name = "Launch with GDB (GEF)",
                    type = "cppdbg",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    args = {},
                    cwd = '${workspaceFolder}',
                    stopAtEntry = true,
                    setupCommands = {
                        {
                            text = '-enable-pretty-printing',
                            description = 'Enable pretty-printing for GDB',
                            ignoreFailures = true,
                        },
                        {
                            text = 'source ~/.gdbinit-gef.py',
                            description = 'Load GEF',
                            ignoreFailures = true,
                        },
                    },
                },
            }
            dap.configurations.c = dap.configurations.cpp

            local map = function(keys, fn)
                vim.keymap.set('n', keys, fn)
            end
            map('<F5>',  function() dap.continue() end)
            map('<F6>',  function() dap.step_over() end)
            map('<F7>',  function() dap.step_into() end)
            map('<F8>',  function() dap.step_out() end)
            map('<leader>bt', function() dap.up() end)
            map('<leader>dr', function() dap.repl.open() end)
            map('<leader>du', function() require('dapui').toggle() end)
        end,
    },

    {
        'rcarriga/nvim-dap-ui',
        keys = { '<leader>du' },
        config = function()
            local dap = require('dap')
            local dapui = require('dapui')
            dapui.setup()

            dap.listeners.after.event_initialized['dapui_config'] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated['dapui_config'] = function()
                dapui.close()
            end
        end,
    },

    {
        'jay-babu/mason-nvim-dap.nvim',
        dependencies = 'mfussenegger/nvim-dap',
        opts = {
            ensure_installed = { 'cpptools' },
            automatic_installation = false,
        },
    },
}
