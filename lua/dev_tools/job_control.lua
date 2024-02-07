--[[
 
 ==============================================================================
 job_control.lua
 Created: 6 Feb 2024 2:50:43pm
 Author: Manos Lefakis
 
 ==============================================================================
 ]]
local notif = require("notify")
local utils = require('dev_tools.winbufutils')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local sorters = require('telescope.sorters')
local action_state = require('telescope.actions.state')
local actions = require('telescope.actions')
local previewers = require('telescope.previewers')
local entry_display = require("telescope.pickers.entry_display")

local M = {}
M.running_jobs = {}

local function select_and_kill(prompt_bufnr)
    local selection = action_state.get_selected_entry(prompt_bufnr)
    -- local comment_api = require('Comment.api')

    local entry = selection.value
    actions.close(prompt_bufnr)
    if entry.status == "running" then
        vim.fn.jobstop(entry.job_id)
    else
        vim.api.nvim_buf_set_lines(utils.error_buffer, 0, -1, true, entry.messages)
        utils.open_error_win()
    end
end

local generate_finder = function()
    return finders.new_table({
        results = M.running_jobs,
        entry_maker = function(entry)
            local displayer = entry_display.create({
                separator = " - ",
                items = {
                    { width = 10 },
                    { width = 30 },
                    { width = 30 },
                    { remaining = true },
                },
            })
            local make_display = function()
                return displayer({
                    tostring(entry.job_id),
                    entry.command,
                    entry.status,
                })
            end
            return {
                value = entry,
                ordinal = entry.job_id,
                display = make_display,
            }
        end,
    })
end

function M.Telescope_kill_job()

  pickers.new {
    results_title = 'Running Jobs',
    finder = generate_finder(),
    sorter = sorters.get_generic_fuzzy_sorter(),
    previewer = previewers.new_buffer_previewer {
      title = "My preview",
      define_preview = function (self, entry, status)
        vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, entry.value.messages)
      end
    },
    attach_mappings = function(_, map)
      map('i', '<CR>', select_and_kill)
      map('n', '<CR>', select_and_kill)
      return true
    end,
  }:find()

end

function M.new_job(job)
    table.insert(M.running_jobs, {
        job_id = job.id,
        command = job.command,
        status = "running",
        messages = {"...building..."}
    })
end

function M.set_status(id, status)
    for idx, job in pairs(M.running_jobs) do
        if job.job_id == id then
            job.status = status
        end
    end
end

function M.set_messages(id, msg_array)
    for idx, job in pairs(M.running_jobs) do
        if job.job_id == id then
            job.messages = msg_array
        end
    end
end

function M.append_messages(id, msg_array)
    for idx, job in pairs(M.running_jobs) do
        if job.job_id == id then
            for _,v in ipairs(msg_array) do 
                table.insert(job.messages, v)
            end
        end
    end
end

return M
