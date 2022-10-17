local bqf_ok, bqf = pcall(require, "bqf")

if not bqf_ok then
    vim.notify(" 🤖 Not Working Properly", "error", {
        title = "Quickfix info",
        timeout = 2000,
    })
    return
end

local fn = vim.fn

function _G.qftf(info)
    local items
    local ret = {}
    local getqflist = fn.getqflist({ id = info.id, items = 0 }).items
    local getlocklist =
        fn.getloclist(info.winid, { id = info.id, items = 0 }).items
    if info.quickfix == 1 then
        items = getqflist
    else
        items = getlocklist
    end
    local limit = 31
    local fnameFmt1, fnameFmt2 =
        "%-" .. limit .. "s", "…%." .. (limit - 1) .. "s"
    local validFmt = "%s │%5d:%-3d│%s %s"
    for i = info.start_idx, info.end_idx do
        local e = items[i]
        local fname = ""
        local str
        if e.valid == 1 then
            if e.bufnr > 0 then
                fname = fn.bufname(e.bufnr)
                if fname == "" then
                    fname = "[No Name]"
                else
                    fname = fname:gsub("^" .. vim.env.HOME, "~")
                end
                if #fname <= limit then
                    fname = fnameFmt1:format(fname)
                else
                    fname = fnameFmt2:format(fname:sub(1 - limit))
                end
            end
            local lnum = e.lnum > 99999 and -1 or e.lnum
            local col = e.col > 999 and -1 or e.col
            local qtype = e.type == "" and "" or " " .. e.type:sub(1, 1):upper()
            str = validFmt:format(fname, lnum, col, qtype, e.text)
        else
            str = e.text
        end
        table.insert(ret, str)
    end
    return ret
end

local cfg = {
    auto_enable = true,
    auto_resize_height = true,
    preview = {
        win_height = 15,
        win_vheight = 15,
        delay_syntax = 50,
        border_chars = {
            "┃",
            "┃",
            "━",
            "━",
            "┏",
            "┓",
            "┗",
            "┛",
            "█",
        },
        show_title = true,
        should_preview_cb = function(bufnr)
            local ret = true
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            local fsize = fn.getfsize(bufname)
            if fsize > 100 * 1024 then
                ret = false
            end
            return ret
        end,
    },
    func_map = {
        drop = "o",
        openc = "O",
        split = "<C-s>",
        vsplit = "<C-v>",
        tabdrop = "\\ooo", -- i hate tab !
        tabc = "\\oaoa", -- stupid tab !
        ptogglemode = "z,",
    },
    filter = {
        fzf = {
            action_for = {
                ["\\ooo"] = { default = "tabedit" }, -- this too !
                ["ctrl-s"] = { default = "split" },
                ["ctrl-v"] = { default = "vsplit" },
                ["ctrl-q"] = { default = "signtoggle" },
                ["ctrl-c"] = { default = "closeall" },
            },
            extra_opts = { "--bind", "ctrl-o:toggle-all", "--delimiter", "│" },
        },
    },
}

function Toggle_qf()
    local qf_open = false
    for _, win in pairs(fn.getwininfo()) do
        if win["quickfix"] == 1 then
            qf_open = true
        end
    end
    if qf_open == true then
        vim.cmd("cclose")
        return
    end
    if not vim.tbl_isempty(fn.getqflist()) then
        vim.cmd("copen")
    end
end

local function grepper()
    local command = "vim "
    local curword, pattern
    local open = "| copen"
    local toggle = false

    local function curword_buffer(t)
        toggle = t
        pattern = "% "

        if curword ~= nil or curword ~= "" then
            curword = fn.expand("<cword>")
        end

        if curword == nil or curword == "" then
            vim.notify(" 🤖 No Words Under Cursor", "warn", {
                title = "Grepper Log",
                timeout = 1000,
            })
            return
        end

        if toggle == true then
            local result = command
                .. "/"
                .. curword
                .. "/"
                .. "j"
                .. " "
                .. pattern
                .. open
            vim.cmd(result)
        end

        if toggle == nil then
            local result = command
                .. "/"
                .. curword
                .. "/"
                .. "j"
                .. " "
                .. pattern
            vim.cmd(result)
        end
    end

    local function curword_recursive(t)
        toggle = t
        pattern = "**/*." .. vim.bo.filetype

        if curword ~= nil or curword ~= "" then
            curword = fn.expand("<cword>")
        end

        if curword == nil or curword == "" then
            vim.notify(" 🤖 No Words Under Cursor", "warn", {
                title = "Grepper Log",
                timeout = 1000,
            })
            return
        end

        if toggle == true then
            local result = command
                .. "/"
                .. curword
                .. "/"
                .. "j"
                .. " "
                .. pattern
                .. open
            vim.cmd(result)
        end

        if toggle == nil then
            local result = command
                .. "/"
                .. curword
                .. "/"
                .. "j"
                .. " "
                .. pattern
            vim.cmd(result)
        end
    end

    return {
        curword_buffer = curword_buffer,
        curword_recursive = curword_recursive,
    }
end

local keymap = vim.keymap.set
local opts = { silent = true }

keymap("n", "]e", function() Toggle_qf() end, opts)
keymap("n", "]gs", function() grepper().curword_buffer(true) end, opts)
keymap("n", "]gf", function() grepper().curword_recursive(true) end, opts)

vim.o.qftf = "{info -> v:lua._G.qftf(info)}"

bqf.setup(cfg)
