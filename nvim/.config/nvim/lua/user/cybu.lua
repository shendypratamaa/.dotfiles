local cybu_ok, cybu = pcall(require, "cybu")
local keymap        = vim.keymap.set
local opts          = { silent = true }

if not cybu_ok then
    return
end

keymap("n", "<s-h>", "<Plug>(CybuPrev)", opts)
keymap("n", "<s-l>", "<Plug>(CybuNext)", opts)

local cfg = {
    position = {
        relative_to       = "editor",
        anchor            = "center",
        vertical_offset   = 0,
        horizontal_offset = 0,
        max_win_height    = 10,
        max_win_width     = 0.5,
    },
    style = {
        path      = "absolute",
        border    = "single",
        separator = " ",
        prefix    = "…",
        padding   = 4,
        hide_buffer_id = false,
        devicons = {
            enabled  = true,
            colored  = true,
            truncate = true,
        },
        highlights = {
            current_buffer   = "CybuFocus",
            adjacent_buffers = "CybuAdjacent",
            background       = "CybuBackground",
            border           = "CybuBorder",
        },
    },
    behavior = {
        mode = {
            default = {
                switch = "on_close",
                view   = "paging",
            },
            last_used = {
                switch = "on_close",
                view   = "paging",
            },
        },
    },
    display_time = 500,
    exclude = {
        "neo-tree",
        "fugitive",
        "qf",
    },
    fallback = function() end,
}

cybu.setup(cfg)
