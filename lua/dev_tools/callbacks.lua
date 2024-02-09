
local M = {}
local notif = require("notify")
local utils = require('dev_tools.winbufutils')
local job_control = require('dev_tools.job_control')

local function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function M.stderr_callback(jobid, data, _)
    if data == nil then
        notif("null data")
        return
    end
    if utils.error_buffer == nil then
        utils.error_buffer = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_name(utils.error_buffer, "Build Messages")
    end

    local elem = nil
    elem = next(data)
    if elem == nil then
        return
    end

    if tablelength(data) == 1 then
        return
    end

    vim.api.nvim_buf_set_lines(utils.error_buffer, 0, -1, true, data)
    job_control.set_messages(jobid, data)
    utils.open_error_win()

end

function M.on_exit_callback(jobid, exit_code, _)
    if exit_code ~= 0 then
        job_control.set_status(jobid, "failed")
        notif("Build failed", "error", {timeout = false})
    else
        if utils.error_buffer ~= nil then
            vim.api.nvim_buf_set_lines(utils.error_buffer, 0, -1, true, {})
        end
        job_control.set_status(jobid, "succeded")
        notif("Build succeeded", "info", {timeout = false})
    end
end

function M.get_on_exit_callback(success_status)
    local function on_exit_callback(jobid, exit_code, _)
        notif.dismiss({})
        if exit_code ~= 0 then
            job_control.set_status(jobid, "failed")
            notif("Build failed", "error", {timeout = false})
        else
            if utils.error_buffer ~= nil then
                vim.api.nvim_buf_set_lines(utils.error_buffer, 0, -1, true, {})
            end
            job_control.set_status(jobid, "succeded")
            notif("Build succeeded", success_status, {timeout = false})
        end
    end
    return on_exit_callback
end

function M.get_stdio_callback(build_command)
    local function stdio_callback(jobid, data, _)
        if next(data) == nil then
            notif("null data")
            return
        end
        if tablelength(data) == 1 then
            return
        end
        notif(data, "info", {title = build_command})
        job_control.append_messages(jobid, data)
    end
    return stdio_callback
end

function M.tablelength(T)
  return tablelength(T)
end

return M
