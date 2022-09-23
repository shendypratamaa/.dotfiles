local cat_ok, cat = pcall(require, "catppuccin")
local utils = require "user.colorscheme_config.utils"

vim.g.catppuccin_flavour = "mocha"

if not cat_ok then
  return
end

local M = {}

local load_utils = function()
  local telescope_border = utils.telescope_border()
  local illuminate = utils.illuminate()
  local nontext = utils.nontext()

  utils.load_colors(telescope_border)
  utils.load_colors(illuminate)
  utils.load_colors(nontext)
end

local cfg = {
  transparent_background  = false,
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
    conditionals          = { "italic" },
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
  highlight_overrides     = {},
}

function M.setup()
  cat.setup(cfg)
  load_utils()
end

return M
