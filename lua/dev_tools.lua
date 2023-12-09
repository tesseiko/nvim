
vim.keymap.set('n', '<leader>b', function ()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_call(bufnr, function()
        vim.cmd(':w')
    end)
    io.popen("tmake bear") end)

local notif = require("notify")
local error_buffer = nil;
local error_win = nil;

local function open_error_win()
    if error_buffer == nil then
        return;
    end

    if error_win ~= nil then
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
    vim.api.nvim_win_close(error_win, true)
    error_win = nil;
end

function Toggle_error_win()
    if error_win == nil then
        open_error_win()
    else
        close_error_win()
    end
end

local function stderr_callback(jobid, data, event)
    if data == nil then
        notif("null data")
        return
    end
    if error_buffer == nil then
        error_buffer = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_name(error_buffer, "Build Messages")
    end
    vim.api.nvim_buf_set_lines(error_buffer, 0, -1, true, data)
    -- vim.cmd('buffer ' .. error_buffer)

    open_error_win()
end


local function on_exit_callback(jobid, exit_code, event)
    if exit_code ~= 0 then
        notif("Build failed", "error")
    else
        notif("Build succeeded")
    end
end

function SmartBuild()

    local build_command = ""
    local make_options = "-j3"

    local doBear = false

    local pwd_cmd=io.popen("pwd")
    if pwd_cmd == nil then
        notif("fatal error, cannot execute pwd", "error")
        return
    end
    local dir = pwd_cmd:read()
    pwd_cmd:close()
    local prefix = ""
    if os.execute('bear --version > /dev/null') == 0 then
        doBear = true
    end

    if os.execute('[ -f platformio.ini ]') == 0 then
        notif("Start building with platformio")
        build_command = "platformio run"
        if os.execute('[ -f compile_commands.json ]') == 0 then
            doBear = false
        end
    elseif os.execute('[ -f Makefile ]') == 0 then
        notif("Start building with Makefile")
        build_command = "make "..make_options
        if os.execute('[ -f compile_commands.json ]') == 0 then
            doBear = false
        end
    elseif os.execute('[ -f *.jucer ]') == 0 then
        notif("juce framework detected")
        if os.execute('[ ! -d Builds/LinuxMakefile ]') == 0 then
            local lala = io.popen('ls ./*.jucer')
            local jucer_file = ""
            if lala == nil then
                notif("fatal error no jucer file found", "error")
                return
            end
            jucer_file = lala:read()
            lala:close()
            notif("Resaving Projucer")

            local projucerCMD = 'Projucer --resave '..jucer_file
            local function stdio_callback(jobid, data, event)
                if data == nil then
                    notif("null data")
                    return
                end
                notif(data, "info", {title = projucerCMD})
            end

            local job_options = {
                cwd = dir,
                stderr_buffered = true,
                on_stdout = stdio_callback,
                on_stderr = stderr_callback,
                on_exit = SmartBuild
            }
            vim.fn.jobstart(projucerCMD, job_options)
            return
        end
        if os.execute('[ -f Builds/LinuxMakefile/compile_commands.json ]') == 0 then
            doBear = false
        else
            os.execute("ln -sf "..dir.."/Builds/LinuxMakefile/compile_commands.json "..dir.."/Source/compile_commands.json")
        end
        -- Ready to build
        if os.execute('[ -f /bin/g++-11 ]') == 0 then
            make_options=make_options.." CXX=/bin/g++-11"
        elseif os.execute('[ -f /bin/g++-10 ]') == 0 then
            make_options=make_options.." CXX=/bin/g++-10"
        end
        build_command="make "..make_options
        dir = dir..'/Builds/LinuxMakefile'
        -- cd $DIR/Builds/LinuxMakefile
        -- prefix = 'cd '..dir..'/Builds/LinuxMakefile; '..prefix
    elseif os.execute('[ -f *.tex ]') == 0 then
        doBear = false
        os.execute('mkdir -p build')
        notif("Start building with pdflatex")

        local ls_cmd=io.popen("ls *.tex")
        if ls_cmd == nil then
            notif("fatal error, cannot execute ls", "error")
            return
        end
        local src = ls_cmd:read()
        ls_cmd:close()
        -- TODO: make them to run in build_command or remove completely tex 
        -- support
		notif("PDFLaTeX ... generating auxiliary files...")
		os.execute('pdflatex -draftmode --shell-escape --output-directory build' ..src)
		notif("BibTeX ... generating blg and bbl files...")
		os.execute('bibtex build/*.aux')
        notif("PDFLaTeX ... patching bib ...")
        os.execute('pdflatex -draftmode --output-directory build '..src)
        notif("PDFLaTeX ... start building pdf ...")
        os.execute('pdflatex --output-directory build '..src)
		notif(dir.." Done building PDF")
        return
    end

    -- run build job
    if doBear then
        prefix = "bear -- "..prefix
    end
    build_command = prefix..build_command
    local function stdio_callback(jobid, data, event)
        if data == nil then
            notif("null data")
            return
        end
        notif(data, "info", {title = build_command})
    end

    local job_options = {
        cwd = dir,
        stderr_buffered = true,
        on_stdout = stdio_callback,
        on_stderr = stderr_callback,
        on_exit = on_exit_callback
    }
    vim.fn.jobstart( build_command, job_options)

end

vim.api.nvim_set_keymap("n", "<leader>tb", "<cmd>lua SmartBuild()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>tm", "<cmd>lua Toggle_error_win()<CR>", {noremap = true, silent = true})
