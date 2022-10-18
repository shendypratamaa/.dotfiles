local keymap = vim.keymap.set
local opts   = { silent = true }
local fn     = vim.fn

local change_working_dir = function()
    local f = ":FZF "
    local h = fn.expand("$HOME")
    local r = f .. h
    vim.cmd(r)
end

local run = {
    change_working_dir = change_working_dir,
}

keymap("n", "cd", function() run.change_working_dir() end, opts)
