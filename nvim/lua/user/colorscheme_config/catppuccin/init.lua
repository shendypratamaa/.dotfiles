local cat_ok, cat = pcall(require, "catppuccin")
local utils = require "user.colorscheme_config.utils"

vim.g.catppuccin_flavour = "mocha"

if not cat_ok then
  return
end

local M = {}

local load_utils = function()
  utils.border_default("default")
  utils.illuminate()
  utils.nontext()
end

local cfg = {
  transparent_background  = true,
  term_colors             = false,
  compile                 = {
    enabled               = false,
    path                  = vim.fn.stdpath "cache" .. "/catppuccin",
  },
  dim_inactive            = {
    enabled               = false,
    shade                 = "dark",
    percentage            = 0.15,
  },
  styles                  = {
    comments              = { "italic" },
    conditionals          = {},
    loops                 = {},
    functions             = {},
    keywords              = {},
    strings               = {},
    variables             = {},
    numbers               = {},
    booleans              = {},
    properties            = {},
    types                 = {},
    operators             = {},
  },
  integrations            = {
    dashboard             = true,
    fidget                = true,
    gitsigns              = true,
    illuminate            = true,
    leap                  = true,
    lsp_saga              = true,
    lsp_trouble           = true,
    notify                = true,
    nvimtree              = true,
    symbols_outline       = true,
    telescope             = true,
    treesitter            = true,
    treesitter_context    = true,
    ts_rainbow            = true,
    which_key             = true,
    dap                   = {
      enable              = false,
      enable_ui           = false,
    },
    indent_blankline      = {
      enable              = false,
      color_indent_levels = false,
    },
    navic                 = {
      enable              = true,
      custom_bg           = "NONE",
    },
  },
  color_overrides         = {},
  highlight_overrides     = {
    all                   = {},
    latte                 = {},
    frappe                = {},
    macchiato             = {},
    mocha                 = {},
  },
}

function M.setup()
  cat.setup(cfg)
  load_utils()
end

return M
