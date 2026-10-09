local M = {}

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

function M.choose_make_target(callback)
  -- Guard clause: Check if a Makefile exists before popping open Telescope
  if vim.fn.filereadable("Makefile") == 0 and vim.fn.filereadable("makefile") == 0 then
    vim.notify("No Makefile found in the current directory", vim.log.levels.WARN)
    return
  end

  -- TODO: add "global makefiles" for building juce and other things
  local cmd = "make -qp | awk -F':' '/^[a-zA-Z0-9][^$#\\/\\t=]*:([^=]|$)/ {split($1,A,/ /);for(i in A)print A[i]}' | sort -u"

  pickers.new({}, {
    prompt_title = "Select Make Target",
    finder = finders.new_oneshot_job({ "bash", "-c", cmd }, {}),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        
        -- selection[1] contains the actual string text of the target in Telescope
        if selection and selection[1] and selection[1] ~= "" then
          callback(selection[1])
        end
      end)
      return true
    end,
  }):find()
end

return M
