
vim.keymap.set('n', '<leader>b', function ()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_call(bufnr, function()
        vim.cmd(':w')
    end)
    io.popen("tmake bear") end)

local notif = require("notify")

local build_command = ""
local make_options = "-j4"

local function stdio_callback(jobid, data, event)
    if data == nil then
        notif("null data")
        return
    end
    notif(data, "info", {title = build_command})
end

local function stderr_callback(jobid, data, event)
    if data == nil then
        notif("null data")
        return
    end
    local error_buffer = vim.api.nvim_create_buf(true, true)
    local tm = tostring(os.time())
    vim.api.nvim_buf_set_name(error_buffer, "Build Errors "..tm)
    vim.api.nvim_buf_set_lines(error_buffer, 0, 0, false, data)
end

local function on_exit_callback(jobid, exit_code, event)
    if exit_code ~= 0 then
        notif("Build failed", "error")
    else
        notif("Build succeeded")
    end
end

function SmartBuild()

    local pwd_cmd=io.popen("pwd")
    if pwd_cmd == nil then
        notif("fatal error, cannot execute pwd", "error")
        return
    end
    local dir = pwd_cmd:read()
    pwd_cmd:close()
    local prefix = ""
    if os.execute('bear --version > /dev/null') == 0 then
        prefix="bear -- "
    end

    if os.execute('[ -f platformio.ini ]') == 0 then
        notif("Start building with platformio")
        build_command = "platformio run"
    elseif os.execute('[ -f Makefile ]') == 0 then
        notif("Start building with Makefile")
        build_command = "make "..make_options
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
            local job_options = {
                cwd = dir,
                stderr_buffered = true,
                on_stdout = stdio_callback,
                on_stderr = stderr_callback,
                on_exit = SmartBuild
            }
            vim.fn.jobstart('Projucer --resave '..jucer_file , job_options)
            return
        end
        os.execute("ln -sf "..dir.."/Builds/LinuxMakefile/compile_commands.json "..dir.."/Source/compile_commands.json")
        -- Ready to build
        if os.execute('[ -f /bin/g++-10 ]') == 0 then
            make_options=make_options.." CXX=/bin/g++-10"
        elseif os.execute('[ -f /bin/g++-11 ]') == 0 then
            make_options=make_options.." CXX=/bin/g++-11"
        end
        build_command="make "..make_options
        dir = dir..'/Builds/LinuxMakefile'
        -- cd $DIR/Builds/LinuxMakefile
        -- prefix = 'cd '..dir..'/Builds/LinuxMakefile; '..prefix
    elseif os.execute('[ -f *.tex ]') == 0 then
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
    build_command = prefix..build_command
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
