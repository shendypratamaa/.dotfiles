local fidget_ok, fd = pcall(require, "fidget")
local hl            = vim.api.nvim_set_hl

if not fidget_ok then
    return
end

local cfg = {
    align = {
        bottom = true,
        right = true,
    },
    window = {
        relative = "win",
        blend = 0,
        zindex = nil,
    },
    sources = {
        ["null-ls"] = {
            ignore = true,
        },
    },
}

hl(0, "FidgetTitle", { link = "Boolean" })

fd.setup(cfg)
