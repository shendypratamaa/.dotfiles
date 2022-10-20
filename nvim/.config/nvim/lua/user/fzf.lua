local keymap = vim.keymap.set
local opts   = { silent = true }
local fn     = vim.fn

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

keymap("n", "cd", function() run.change_working_dir() end, opts)
