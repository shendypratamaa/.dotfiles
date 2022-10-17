local signature_ok, signature = pcall(require, "lsp_signature")

if not signature_ok then
    return
end

local M = {}

local cfg = {
    bind = true,
    hint_enable = true,
    max_width = 80,
    floating_window = false,
    floating_window_above_cur_line = false,
    toggle_key = "<C-p>",
    handler_opts = {
        border = "rounded",
    },
}

function M.setup()
    signature.setup(cfg)
end

return M
