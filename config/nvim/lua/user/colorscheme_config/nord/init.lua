local nord_ok, nord = pcall(require, "nord")
local utils = require "user.colorscheme_config.utils"

if not nord_ok then
  return
end

local M = {}

local function load_utils()
  local opts = {
    TreesitterContext = {
      fg = "#eceff4",
      bg = "#1e222b",
    },
    TreesitterContextLineNumber = {
      fg = "#eceff4",
      bg = "#1e222b",
    },
    VertSplit = {
      link = "none",
    },
  }

  utils.border_default()
  utils.illuminate()
  utils.nontext()
  utils.load_colors(opts)
end

local function nord_theme_utils()
  vim.g.nord_contrast                = true
  vim.g.nord_borders                 = true
  vim.g.nord_disable_background      = true
  vim.g.nord_italic                  = true
  vim.g.nord_uniform_diff_background = false
end

function M.setup()
  nord.set()
  nord_theme_utils()
  load_utils()
end

return M
