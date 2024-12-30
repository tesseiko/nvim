local M = {}
M.error_win = nil;
M.error_buffer = nil;

local function double_pattern_highlight_above(bufnr, pattern1, pattern2, hlgroup)
    -- Search for the pattern in the buffer and highlight the matches
    for lineNo, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
        local match_start, match_end = string.find(line, pattern1, 1, false)
        if match_start then
            vim.api.nvim_buf_add_highlight(bufnr, -1, hlgroup, lineNo - 2, match_start - 1, match_end)
        end
        match_start, match_end = string.find(line, pattern2)
        if match_start then
            vim.api.nvim_buf_add_highlight(bufnr, -1, hlgroup, lineNo - 2, match_start - 1, match_end)
        end
    end
end


local function double_pattern_highlight(bufnr, pattern1, pattern2, hlgroup)
    -- Search for the pattern in the buffer and highlight the matches
    for lineNo, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
        local match_start, match_end = string.find(line, pattern1, 1, false)
        if match_start then
            vim.api.nvim_buf_add_highlight(bufnr, -1, hlgroup, lineNo - 1, match_start - 1, match_end)
        end
        match_start, match_end = string.find(line, pattern2)
        if match_start then
            vim.api.nvim_buf_add_highlight(bufnr, -1, hlgroup, lineNo - 1, match_start - 1, match_end)
        end
    end
end

local function highlight_error_window()

    local pattern1 = 'error'
    local pattern2 = 'Error'

    local pattern3 = 'warning'
    local pattern4 = 'Warning'
    -- Get the current buffer
    local bufnr = M.error_buffer

    double_pattern_highlight(bufnr, "error", "Error", "Error")
    double_pattern_highlight(bufnr, "warning", "Warning", "Warning")
    double_pattern_highlight(bufnr, "note", "Note", "Note")
    double_pattern_highlight(bufnr, "%^", "~*%^~+", "Underline")
    double_pattern_highlight_above(bufnr, "%^", "~*%^~+", "ErrorString")
end

local function getCenterLayout()
    local width = math.ceil(math.min(vim.o.columns, math.max(80, vim.o.columns - 20)))
    local height = math.ceil(math.min(vim.o.lines, math.max(20, vim.o.lines - 10)))

    local row = math.ceil(vim.o.lines - height) * 0.5 - 1
    local col = math.ceil(vim.o.columns - width) * 0.5 - 1
    return width, height, row, col
end

local function getTopRightLayout()
    local width = math.ceil(math.min(vim.o.columns * 0.4, math.max(80, vim.o.columns - 20)))
    local height = math.ceil(math.min(vim.o.lines, math.max(20, vim.o.lines - 10)))

    local row = 0
    local col = math.ceil(vim.o.columns - width)
    return width, height, row, col
end

local function close_error_win()
    if M.error_win == nil then
        return
    end
    local validWin = vim.api.nvim_win_is_valid(M.error_win)
    if validWin then
        vim.api.nvim_win_close(M.error_win, true)
    end
    M.error_win = nil;
end

local function open_error_win(layout)

    close_error_win()
    local hl_ns = vim.api.nvim_create_namespace("ErrorWin")
    vim.api.nvim_set_hl(hl_ns, 'Warning', { fg = "#deaf42", bold = true })
    vim.api.nvim_set_hl(hl_ns, 'Error', { fg = "#ff0000", bold = true })
    vim.api.nvim_set_hl(hl_ns, 'Note', { fg = "#00a075", bold = true })
    vim.api.nvim_set_hl(hl_ns, 'Underline', { fg = "#aa0000", bold = true })
    vim.api.nvim_set_hl(hl_ns, 'ErrorString', { bg = "#ffaaaa", fg = "#000000", bold = false })

    if M.error_buffer == nil then
        M.error_buffer = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_name(M.error_buffer, "Build Messages")
        local data = {'No Build Messages'}
        vim.api.nvim_buf_set_lines(M.error_buffer, 0, -1, true, data)
    end

    local validWin = (M.error_win ~= nil) and (vim.api.nvim_win_is_valid(M.error_win))
    if validWin then
        vim.api.nvim_win_set_hl_ns(M.error_win, hl_ns)
        vim.api.nvim_buf_set_option(M.error_buffer, "filetype", "yaml")
        highlight_error_window()
        return;
    end

    local w, h, r, c
    -- local w, h, r, c = getCenterLayout()
    if layout == 'center' then
        w, h, r, c = getCenterLayout()
    else
         w, h, r, c = getTopRightLayout()
    end
    -- local width = math.ceil(math.min(vim.o.columns, math.max(80, vim.o.columns - 20)))
    -- local height = math.ceil(math.min(vim.o.lines, math.max(20, vim.o.lines - 10)))

    -- local row = math.ceil(vim.o.lines - height) * 0.5 - 1
    -- local col = math.ceil(vim.o.columns - width) * 0.5 - 1

    M.error_win = vim.api.nvim_open_win(M.error_buffer, true, {
        row = r,
        col = c,
        relative = "editor",
        style = "minimal",
        width = w,
        height = h,
        border = 'double',
        zindex = nil,
        title = 'Build Messages',
        title_pos = 'center',
    })
    vim.api.nvim_win_set_hl_ns(M.error_win, hl_ns)
    vim.api.nvim_buf_set_option(M.error_buffer, "filetype", "yaml")
    highlight_error_window()
end

function M.open_error_win(layout)
    open_error_win(layout)
end

function M.close_error_win()
    close_error_win()
end

function M.toggle_error_win(layout)
    if M.error_win == nil then
        open_error_win(layout)
    else
        close_error_win()
    end
end

return M
