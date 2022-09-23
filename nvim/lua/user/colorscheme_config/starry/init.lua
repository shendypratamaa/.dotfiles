local utils = require "user.colorscheme_config.utils.init"

local M = {}

local function load_utils()
  local telescope_border = utils.telescope_border_utils()

  local opts = {
    Normal = {
      fg = "none",
      bg = "none",
    },
    SignColumn = {
      bg = "none",
    },
    CursorLine = {
      bg = "none",
    },
    ColorColumn = {
      bg = "#FFE6F7",
    },
    NonText = {
      fg = "#FFE6F7",
      bold = true,
    },
    IndentBlanklineChar = {
      fg = "#FFE6F7",
      bold = true,
    },
    IlluminatedWord = {
      link = "PmenuSel",
    },
    IlluminatedWordText = {
      link = "PmenuSel",
    },
    IlluminatedWordRead = {
      link = "PmenuSel",
    },
  }

  utils.load_colors(telescope_border)
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
