local utils = require "user.colorscheme_config.utils"

local M = {}

local function load_utils()
  local telescope_border = utils.telescope_border()
  local illuminate_hl = utils.illuminate()
  local nontext = utils.nontext()

  local opts = {
    Normal = {
      fg = "none",
      bg = "none",
    },
    SignColumn = {
      bg = "none",
    },
  }

  utils.load_colors(telescope_border)
  utils.load_colors(illuminate_hl)
  utils.load_colors(nontext)
  utils.load_colors(opts)
end

local function starry_load()
  vim.g.starry_italic_functions = false
  vim.g.starry_italic_comments  = true
  vim.g.starry_italic_string    = true
  vim.g.starry_italic_keywords  = true
  vim.g.starry_italic_variables = true
  vim.g.starry_contrast         = true
  vim.g.starry_borders          = true
  vim.g.starry_darker_contrast  = true
  vim.g.starry_deep_black       = true
  vim.g.starry_set_hl           = true
  vim.g.starry_daylight_switch  = true
end

function M.setup()
  starry_load()
  load_utils()
end

return M
