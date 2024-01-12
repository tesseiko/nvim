local error_win = nil;
local error_buffer = nil;

local function open_error_win()
    if error_buffer == nil then
        error_buffer = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_name(error_buffer, "Build Messages")
        local data = {'No Build Messages'}
        vim.api.nvim_buf_set_lines(error_buffer, 0, -1, true, data)
    end

    local validWin = (error_win ~= nil) and (vim.api.nvim_win_is_valid(error_win))
    if validWin then
        return;
    end

    local width = math.ceil(math.min(vim.o.columns, math.max(80, vim.o.columns - 20)))
    local height = math.ceil(math.min(vim.o.lines, math.max(20, vim.o.lines - 10)))

    local row = math.ceil(vim.o.lines - height) * 0.5 - 1
    local col = math.ceil(vim.o.columns - width) * 0.5 - 1

    error_win = vim.api.nvim_open_win(error_buffer, true, {
        row = row,
        col = col,
        relative = "editor",
        style = "minimal",
        width = width,
        height = height,
        border = 'double',
        zindex = nil,
    })
end

local function close_error_win()
    if error_win == nil then
        return
    end
    local validWin = vim.api.nvim_win_is_valid(error_win)
    if validWin then
        vim.api.nvim_win_close(error_win, true)
    end
    error_win = nil;
end

local M = {}
function M.open_error_win()
    open_error_win()
end

function M.close_error_win()
    close_error_win()
end

function M.toggle_error_win()
    if error_win == nil then
        open_error_win()
    else
        close_error_win()
    end
end

return M
