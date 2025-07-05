if true then
  return {}
end
local dap = require("dap")

-- C/C++ configuration with GDB
dap.adapters.cppdbg = {
  id = "cppdbg",
  type = "executable",
  command = "OpenDebugAD7", -- Installed via Mason (cpptools-gdb)
}

dap.configurations.cpp = {
  {
    name = "Launch with GDB (GEF)",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    args = {},
    cwd = "${workspaceFolder}",
    stopAtEntry = true,
    setupCommands = {
      {
        text = "-enable-pretty-printing",
        description = "Enable pretty-printing for GDB",
        ignoreFailures = true,
      },
      {
        text = "source ~/.gdbinit-gef.py", -- Load GEF (if you use it)
        description = "Load GEF",
        ignoreFailures = true,
      },
    },
  },
}

-- (Optional) Reuse config for C
dap.configurations.c = dap.configurations.cpp

vim.keymap.set("n", "<F5>", function()
  require("dap").continue()
end)
vim.keymap.set("n", "<F6>", function()
  require("dap").step_over()
end)
vim.keymap.set("n", "<F7>", function()
  require("dap").step_into()
end)
vim.keymap.set("n", "<F8>", function()
  require("dap").step_out()
end)
vim.keymap.set("n", "<leader>bt", function()
  require("dap").up()
end)
-- vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end)
-- vim.keymap.set('n', '<leader>B', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
vim.keymap.set("n", "<leader>dr", function()
  require("dap").repl.open()
end)
vim.keymap.set("n", "<leader>du", function()
  require("dapui").toggle()
end)
