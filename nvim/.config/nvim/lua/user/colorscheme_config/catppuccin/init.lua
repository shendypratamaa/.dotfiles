local cat_ok, cat = pcall(require, "catppuccin")
local utils       = require("user.colorscheme_config.utils")

vim.g.catppuccin_flavour = "mocha"

if not cat_ok then
    return
end

local M = {}

local load_utils = function()
    local opts = {
        NormalNc = {
            fg = "none",
            bg = "none",
        },
        NormalFloat = {
            link = "NormalNc",
        },
        NormalSb = {
            link = "NormalNc",
        },
    }
    utils.border_default()
    utils.illuminate()
    utils.nontext()
    utils.load_colors(opts)
end

local cfg = {
    transparent_background = true,
    term_colors = true,
    compile = {
        enabled = true,
        path = vim.fn.stdpath("cache") .. "/catppuccin",
    },
    dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.50,
    },
    styles = {
        comments     = { "italic" },
        conditionals = {},
        loops        = {},
        functions    = {},
        keywords     = {},
        strings      = {},
        variables    = {},
        numbers      = {},
        booleans     = {},
        properties   = {},
        types        = {},
        operators    = {},
    },
    integrations = {
        dashboard          = true,
        fidget             = true,
        gitsigns           = true,
        illuminate         = true,
        leap               = true,
        lsp_saga           = true,
        lsp_trouble        = true,
        notify             = true,
        nvimtree           = true,
        symbols_outline    = true,
        telescope          = true,
        treesitter         = true,
        treesitter_context = true,
        ts_rainbow         = true,
        which_key          = true,
        dap = {
            enable = false,
            enable_ui = false,
        },
        indent_blankline = {
            enable = false,
            color_indent_levels = false,
        },
        navic = {
            enable = true,
            custom_bg = "NONE",
        },
    },
    color_overrides = {},
    highlight_overrides = {
        all       = {},
        latte     = {},
        frappe    = {},
        macchiato = {},
        mocha     = {},
    },
}

function M.setup()
    cat.setup(cfg)
    load_utils()
end

return M
