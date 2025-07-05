if true then
  return {}
end

local lsp = vim.lsp
-- local lsp = require('lsp-zero')
local nvimlsp = require("lspconfig")
-- lsp.preset('recommended')

require("mason").setup()
require("mason-nvim-dap").setup()

-- Fix Undefined global 'vim'
lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = {
        library = {
          "/usr/share/nvim/runtime/lua",
          "/usr/share/nvim/runtime/lua/lsp",
          "/usr/share/awesome/lib",
        },
      },
      diagnostics = {
        globals = {
          "vim",
          "awesome",
          "awful",
          "client",
          "screen",
          "tag",
          "root",
        },
      },
      runtime = { version = "LuaJIT" },
    },
  },
})

lsp.config("pylsp", {
  settings = {
    pylsp = {
      plugins = {
        pyflakes = { enabled = false },
        pylint = { enabled = false },
        pycodestyle = { enabled = false },
        -- pycodestyle = {
        --   ignore = {'W391'},
        --   maxLineLength = 120
        -- }
      },
    },
  },
})

local pid = vim.fn.getpid()
-- On linux/darwin if using a release build, otherwise under scripts/OmniSharp(.Core)(.cmd)
local omnisharp_bin = "/home/lef/.local/share/nvim/mason/packages/omnisharp-mono/run"

lsp.config("omnisharp", {
  cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
  root_dir = nvimlsp.util.root_pattern("*.csproj", "*.sln"),
  ...,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    local opts = { buffer = bufnr, remap = false }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  end,
})

-- lsp.on_attach(function (client, bufnr)
--     local opts = {buffer = bufnr, remap = false}
--
--   -- See `:help vim.lsp.*` for documentation on any of the below functions
--   vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
--   vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
--   vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
--   vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
--   vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
--   vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
--   vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
--   vim.keymap.set("n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
--   vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
--   vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
--   vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
--   vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
--   vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
--   vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
--
-- end)

-- lsp.nvim_workspace();
-- lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
})

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  mapping = {
    -- Navigate between snippet placeholders
    ["<C-f>"] = cmp.mapping(function()
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      end
    end, { "i", "s" }),
    ["<C-b>"] = cmp.mapping(function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { "i", "s" }),
  },
})

-- local cmp_action = lsp.cmp_action()
-- local cmp = require('cmp')
-- local cmp_action = require('lsp-zero').cmp_action()
--
-- cmp.setup({
--   mapping = {
--     -- Navigate between snippet placeholder
--     ['<C-f>'] = cmp_action.luasnip_jump_forward(),
--     ['<C-b>'] = cmp_action.luasnip_jump_backward(),
--   }
-- })
