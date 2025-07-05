if true then
  return {}
end

local dap = require("dap")
local dapui = require("dapui")
dapui.setup()

-- Auto-open UI when debugging starts
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
