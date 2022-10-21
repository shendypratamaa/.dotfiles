local keymap     = vim.keymap.set
local fn         = vim.fn
local opts       = function(desc)
    local result = {
        silent   = true,
        desc     = desc
    }
    return result
end

vim.api.nvim_create_autocmd({ "Filetype" }, {
    pattern  = { "fzf" },
    callback = function()
        vim.cmd([[ set laststatus=0 noshowmode noruler ]])
    end,
})

vim.api.nvim_create_autocmd({ "BufLeave" }, {
    pattern  = { "*" },
    callback = function()
        vim.cmd([[
            set laststatus=2 showmode ruler
        ]])
    end,
})

local change_working_dir = function()
    local nw = ":enew | "
    local f  = ":FZF "
    local h  = fn.expand("$HOME")
    local r  = nw .. f .. h
    vim.cmd(r)
end

local run = {
    change_working_dir = change_working_dir,
}

keymap("n", "cdo", function() run.change_working_dir() end, opts('change directory and open using FZF'))
