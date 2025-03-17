local callback = require('dev_tools.callbacks')
local notif = require("notify")

local function init_bear_prefix()
    if os.execute('bear --version > /dev/null') == 0 then
        return true
    else
        return false
    end
end

local function get_projucer_commmand()
    local lala = io.popen('ls ./*.jucer')
    local jucer_file = ""
    if lala == nil then
        notif("fatal error no jucer file found", "error")
        return ';', callback.on_exit_callback
    end
    jucer_file = lala:read()
    lala:close()
    notif("Resaving Projucer")

    local projucerCMD = 'Projucer --resave "'..jucer_file..'"'

    return projucerCMD
end

local function check_projucer_need_to_run()
    if os.execute('[ ! -d Builds/LinuxMakefile ]') == 0 then
        return true
    else
        return false
    end
end

local function construct_build_command()
    local build_command = ""
    local make_options = "-j1"
    local doBear = init_bear_prefix()
    local on_exit_notification_status = "info"

    local pwd_cmd=io.popen("pwd")
    if pwd_cmd == nil then
        notif("fatal error, cannot execute pwd", "error")
        return nil, nil
    end
    local dir = pwd_cmd:read()
    pwd_cmd:close()
    local prefix = ""

    if os.execute('[ -f platformio.ini ]') == 0 then
        notif("Building with platformio")
        build_command = "platformio run"
        if os.execute('[ -f compile_commands.json ]') == 0 then
            doBear = false
        end
    elseif os.execute('[ -f Makefile ]') == 0 then
        notif("Building with Makefile")
        build_command = "make "..make_options
        if os.execute('[ -f compile_commands.json ]') == 0 then
            doBear = false
        end
    elseif os.execute('[ -f *.jucer ]') == 0 then
        notif("juce framework detected")
        if check_projucer_need_to_run() then
            build_command = get_projucer_commmand()
            on_exit_notification_status = "warn"
            doBear = false
        else
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
        end
    elseif os.execute('[ -f *.tex ]') == 0 then
        doBear = false
        os.execute('mkdir -p build')
        notif("Start building with pdflatex - no Makefile found")
        notif("You should write a Makefile for this project!!", "warn")

        local ls_cmd=io.popen("ls *.tex")
        if ls_cmd == nil then
            notif("fatal error, cannot execute ls", "error")
            return nil, nil
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
        return nil, nil
    end

    return build_command, dir, doBear, on_exit_notification_status
end

local M = {}

function M.get_build_command()
    notif.dismiss({})

    local build_command, dir, doBear, on_exit_notification_status= construct_build_command()

    -- run build job
    if doBear then
        build_command = "bear -- "..build_command
    end

    local job_options = {
        cwd = dir,
        stderr_buffered = true,
        on_stdout = callback.get_stdio_callback(build_command),
        on_stderr = callback.stderr_callback,
        on_exit = callback.get_on_exit_callback(on_exit_notification_status)
    }

    return build_command, job_options
end

function M.get_clean_command()
    notif.dismiss({})

    local build_command, dir, _, on_exit_notification_status= construct_build_command()

    build_command = build_command.." clean"

    local job_options = {
        cwd = dir,
        stderr_buffered = true,
        on_stdout = callback.get_stdio_callback(build_command),
        on_stderr = callback.stderr_callback,
        on_exit = callback.get_on_exit_callback(on_exit_notification_status)
    }

    return build_command, job_options
end
return M
