local bufjump_ok, bf = pcall(require, "bufjump")

if not bufjump_ok then
    return
end

local cfg = {
    forward = "<C-i>",
    backward = "<C-o>",
    on_success = function()
        vim.cmd([[execute "normal! g`\"zz"]])
    end,
}

bf.setup(cfg)
